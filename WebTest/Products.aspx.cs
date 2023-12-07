using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebTest.Models;

namespace WebTest
{
    public partial class AddItem : System.Web.UI.Page
    {
        MyContext context;
        string tipo = "error";
        string Msj = string.Empty;
        string titulo = "Validation Error";

        protected void Page_Load(object sender, EventArgs e)
        {
            context = new MyContext();
            if (HttpContext.Current.Session["Action"] != null && (bool)HttpContext.Current.Session["Action"])
            {
                mv.SetActiveView(v2);
            }
            else
            {
                mv.SetActiveView(v1);
            }
            if (!IsPostBack)
            {
                HttpContext.Current.Session["Mode"] = null;
                BindGridView();
            }           
        }

        private void ClearControls()
        {
            Name.Text = string.Empty;
            Price.Text = string.Empty;
        }

        private void BindGridView()
        {
            GvItems.DataSource = null;
            GvItems.Visible = true;
            List<Item> items = context.Items.ToList();
            HttpContext.Current.Session["Products"] = items;
            GvItems.DataSource = items.Select((x) => new { Price = x.Price.ToString("C2"), x.Name }).ToList();
            GvItems.DataBind();            
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if(string.IsNullOrEmpty(Name.Text))
            {              
                Msj = "The Product name cannot be empty";              
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ramdomtext", "alertme('" + titulo + "','" + Msj + "','" + tipo + "');", true);
                return;
            }
            if(string.IsNullOrEmpty(Price.Text))
            {                              
                Msj = "The Product price cannot be empty";               
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ramdomtext", "alertme('" + titulo + "','" + Msj + "','" + tipo + "');", true);
                return;
            }
            if (Price.Text.Any(x => !char.IsDigit(x) && (x != '.') && (x != ',')))
            {              
                Msj = "The price must be a valid data type";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ramdomtext", "alertme('" + titulo + "','" + Msj + "','" + tipo + "');", true);
                return;
            }
            if (decimal.Parse(Price.Text) <= 0)
            {              
                Msj = "The price must be over 0";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ramdomtext", "alertme('" + titulo + "','" + Msj + "','" + tipo + "');", true);
                return;
            }

            Item item = new Item();
            item.Name = Name.Text.Trim();
            decimal temp_price = 0;
            if(!decimal.TryParse(Price.Text, out temp_price))
            {
                Msj = "The price must be a valid data type";                
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ramdomtext", "alertme('" + titulo + "','" + Msj + "','" + tipo + "');", true);
                return;
            }
            item.Price = temp_price;
            if(HttpContext.Current.Session["Mode"]!=null)
            {
                if(HttpContext.Current.Session["Mode"].ToString() == "Edit")
                {
                    string olditemName = HttpContext.Current.Session["OldItemName"].ToString();
                    var dbitem = context.Items.FirstOrDefault(x => x.Name == olditemName);
                    dbitem.UpdatedAt = DateTime.Now;
                    dbitem.Name = item.Name;
                    dbitem.Price = item.Price;
                    context.SaveChanges();
                    ClearControls();
                }
            }
            else
            {
                if (context.Items.Any(x => x.Name == item.Name))
                {
                    Msj = "There is already an Product with the same name";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ramdomtext", "alertme('" + titulo + "','" + Msj + "','" + tipo + "');", true);
                    return;
                }
                context.Items.Add(item);
                try
                {
                    context.SaveChanges();
                    ClearControls();
                }
                catch (Exception ex)
                {
                    Msj = ex.Message;
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ramdomtext", "alertme('" + titulo + "','" + Msj + "','" + tipo + "');", true);
                    return;
                }
            }
            HttpContext.Current.Session["Mode"] = null;
            HttpContext.Current.Session["OldItemName"] = null;
            BindGridView();    
        }

        protected void GvItems_RowCommand(object sender, GridViewCommandEventArgs e)
        {                       

            //Edit Mode
            if (e.CommandName == "Select")
            {
                int rowIndex = int.Parse(e.CommandArgument.ToString());
                GridViewRow row = GvItems.Rows[rowIndex];

                string itemName = row.Cells[0].Text;
                var item = context.Items.FirstOrDefault(x => x.Name == itemName);
                Name.Text = item.Name;
                Price.Text = item.Price.ToString();
                HttpContext.Current.Session["Mode"] = "Edit";
                HttpContext.Current.Session["OldItemName"] = item.Name;
            }
            else
            {
                string itemName = todelete.Value;
                var item = context.Items.FirstOrDefault(x => x.Name == itemName);
                if (context.ProductLines.Any(x => x.ItemId == item.Id))
                {
                    HttpContext.Current.Session["Action"] = true;
                    mv.SetActiveView(v2);
                    Response.Redirect("Products.aspx");
                }
                else
                {
                    context.Items.Remove(item);
                    context.SaveChanges();
                    BindGridView();
                    HttpContext.Current.Session["Action"] = false;
                    Response.Redirect("Products.aspx");
                }               
               
            }
        }
        protected void btn_return_Click(object sender, EventArgs e)
        {
            mv.SetActiveView(v1);
            HttpContext.Current.Session["Action"] = false;
            Response.Redirect("Products.aspx");
        }
        protected void btm_clear_Click(object sender, EventArgs e)
        {
            ClearControls();
            HttpContext.Current.Session["Mode"] = null;
        }
    }
}