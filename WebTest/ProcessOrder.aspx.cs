using System;
using System.Collections;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebTest.Models;

namespace WebTest
{    
    public partial class ProcessOrder : System.Web.UI.Page
    {
        MyContext context;
        bool action = false;
        string tipo = "error";
        string Msj = string.Empty;
        string titulo = "Validation Error";

        private void get_accounts()
        {            
            drop_accounts.DataSource = context.Accounts.Select((x) => new { x.Id, x.Name }).ToList();
            drop_accounts.DataTextField = "Name";
            drop_accounts.DataValueField = "Id";
            drop_accounts.DataBind();
            drop_accounts.SelectedIndex = -1;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            context = new MyContext();
            if (HttpContext.Current.Session["OrderedItems"] == null)
            {
                HttpContext.Current.Session["OrderedItems"] = new List<ProductLine>();
            }
            if(HttpContext.Current.Session["Action"]!=null)
            {
                action = (bool)HttpContext.Current.Session["Action"];
            }
           
            if (!IsPostBack)
            {
                get_accounts();
                if(action)
                {
                    int account_id = int.Parse(HttpContext.Current.Session["Account"].ToString());
                    lbl_account.Text = context.Accounts.FirstOrDefault(a => a.Id == account_id).Name;
                    MV.SetActiveView(V_NewOrder);
                    BindGridView();
                }
                else
                {
                    MV.SetActiveView(V_SelectAccount);
                }
                HttpContext.Current.Session["Action"] = false;
            }            
        }

        protected void btnCreate_Click(object sender, EventArgs e)
        {
            HttpContext.Current.Session["Account"] = drop_accounts.SelectedValue;
            int account_id = int.Parse(drop_accounts.SelectedValue);
            lbl_account.Text = context.Accounts.FirstOrDefault(a => a.Id == account_id).Name;
            MV.SetActiveView(V_NewOrder);
            BindGridView();            
        }

        private void BindGridView()
        {
            GvItems.DataSource = null;
            GvItems.Visible = true;
            GvItems.DataSource = context.Items.Select((x) => new { x.Id,x.Name}).ToList();
            GvItems.DataBind();                        
        }

        private void BindGridViewOrder(List<ProductLine> lines)
        {
            if(lines.Count > 0)
            {
                lines.ForEach(x => x.Amount = context.Items.FirstOrDefault(i => i.Id == x.ItemId).Price * x.Qty);
                GvItemsInOrder.DataSource = lines.Select((x) => new 
                { 
                  context.Items.FirstOrDefault(i=> i.Id == x.ItemId).Name,
                  UnitPrice = context.Items.FirstOrDefault(i => i.Id == x.ItemId).Price,
                  x.Qty, 
                  Total = x.Amount
                }).ToList();
                GvItemsInOrder.Visible = true;
                GvItemsInOrder.DataBind();
                decimal sub_total = lines.Sum(x => x.Amount);
                decimal taxes = Math.Round(sub_total * 7 / 100, 2);
                lbl_subtotal.Text = sub_total.ToString("C2"); 
                lbl_taxes.Text = taxes.ToString("C2");
                lbl_total.Text = (sub_total + taxes).ToString("C2");
                HttpContext.Current.Session["OrderedItems"] = lines;
            }
            else
            {
                lbl_subtotal.Text = string.Empty;
                lbl_taxes.Text = string.Empty;
                lbl_total.Text = string.Empty;
                GvItemsInOrder.DataSource = null;
                GvItemsInOrder.Visible = true;
                GvItemsInOrder.DataBind();
            }
            
        }

        protected void GvItems_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            List<ProductLine> lines = (List<ProductLine>)HttpContext.Current.Session["OrderedItems"];
            int rowIndex = int.Parse(e.CommandArgument.ToString());
            GridViewRow row = GvItems.Rows[rowIndex];

            if (e.CommandName == "Select")
            {
                string itemName = row.Cells[0].Text;
                var item = context.Items.FirstOrDefault(x => x.Name == itemName);
                var line = new ProductLine();                  
                line.ItemId = item.Id;
                if(lines.Any(x=> x.ItemId == item.Id))
                {
                    foreach (var productLine in lines) if (productLine.ItemId == item.Id)
                    {
                       productLine.Qty++;
                    }                    
                }
                else
                {
                    lines.Add(line);
                }                
            }            
            BindGridViewOrder(lines);
            MV.SetActiveView(V_NewOrder);
        }

        protected void GvItems_RowDataBound(object sender, GridViewRowEventArgs e)
        {

        }

        protected void GvItemsInOrder_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            List<ProductLine> lines = (List<ProductLine>)HttpContext.Current.Session["OrderedItems"];
            int rowIndex = int.Parse(e.CommandArgument.ToString());
            GridViewRow row = GvItemsInOrder.Rows[rowIndex];
            //Restar items
            if (e.CommandName == "Select")
            {
                string itemName = row.Cells[0].Text;
                var item = context.Items.FirstOrDefault(x => x.Name == itemName);
                var line = new ProductLine();
                line.ItemId = item.Id;
                if (lines.Any(x => x.ItemId == item.Id))
                {                    
                    foreach (var productLine in lines) if (productLine.ItemId == item.Id)
                        {
                            productLine.Qty--;                           
                        }                    
                }
                lines.RemoveAll(x => x.Qty == 0);               
            }
            //Sumar items
            if (e.CommandName == "New")
            {
                string itemName = row.Cells[0].Text;
                var item = context.Items.FirstOrDefault(x => x.Name == itemName);
                var line = new ProductLine();
                line.ItemId = item.Id;
                if (lines.Any(x => x.ItemId == item.Id))
                {
                    foreach (var productLine in lines) if (productLine.ItemId == item.Id)
                        {
                            productLine.Qty++;
                        }
                }                
            }
            BindGridViewOrder(lines);
            MV.SetActiveView(V_NewOrder);
        }

        protected void GvItemsInOrder_RowDataBound(object sender, GridViewRowEventArgs e)
        {

        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            int account_id = int.Parse(HttpContext.Current.Session["Account"].ToString());
            List<ProductLine> lines = (List<ProductLine>)HttpContext.Current.Session["OrderedItems"];
            //Validations
            if (!lines.Any())
            {                
                string Msj = "Cannot submit an empty order";               
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ramdomtext", "alertme('" + titulo + "','" + Msj + "','" + tipo + "');", true);
                return;
            }

            Order order = new Order();
            order.Subtotal = lines.Sum(x => x.Amount);
            order.Taxes = Math.Round(order.Subtotal * 7 / 100,2);
            order.Total = order.Subtotal + order.Taxes;
            order.ProductLines = lines;
            order.AccountId = account_id;              
            context.Orders.Add(order);
            try
            {
                context.SaveChanges();
                HttpContext.Current.Session["OrderedItems"] = null;
                Response.Redirect("CompletedOrder.aspx");
            }
            catch (Exception ex)
            {
                Msj = ex.Message;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ramdomtext", "alertme('" + titulo + "','" + Msj + "','" + tipo + "');", true);
                return;
            }           
        }

        protected void btn_cancel_Click(object sender, EventArgs e)
        {
            HttpContext.Current.Session["OrderedItems"] = null;
            HttpContext.Current.Session["Account"] = null;
            Response.Redirect("ProcessOrder.aspx");
        }

        
        protected void tbx_Search_TextChanged(object sender, EventArgs e)
        {
            
        }

        protected void btn_search_Click(object sender, EventArgs e)
        {
            string text_to_search = tbx_Search.Text;
            if (string.IsNullOrEmpty(text_to_search))
            {
                GvItems.DataSource = null;
                GvItems.Visible = true;
                GvItems.DataSource = context.Items.Select((x) => new { x.Id, x.Name }).ToList();
                GvItems.DataBind();
            }
            else
            {
                GvItems.DataSource = null;
                GvItems.Visible = true;
                GvItems.DataSource = context.Items.Where(x => x.Name.Contains(text_to_search)).Select((x) => new { x.Id, x.Name }).ToList();
                GvItems.DataBind();
            }
        }
    }
}