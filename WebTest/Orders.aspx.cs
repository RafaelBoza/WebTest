using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebTest
{
    public partial class About : Page
    {
        MyContext context;
        private void get_accounts()
        {
            var lista = context.Accounts.Select((x) => new { x.Id, x.Name }).ToList();
            lista.Insert(0, new { Id = 0, Name = "--All--"});
            drop_accounts.DataSource = lista;
            drop_accounts.DataTextField = "Name";
            drop_accounts.DataValueField = "Id";
            drop_accounts.DataBind();
            drop_accounts.SelectedIndex = -1;
        }

        private void BindGridView(int account_id)
        {
            GvOrders.DataSource = null;
            GvOrders.Visible = true;
            if (account_id != 0)
            {
                GvOrders.DataSource = context.Orders.Where(x => x.AccountId == account_id).Select((x) => new
                {
                    x.Id,
                    x.Subtotal,
                    x.Total,
                    x.Taxes,
                    Account = context.Accounts.FirstOrDefault(a => a.Id == x.AccountId).Name,
                    x.CreatedAt
                }).OrderByDescending(x=> x.CreatedAt).ToList();              
            }
            else
            {
                GvOrders.DataSource = context.Orders.Select((x) => new
                {
                    x.Id,
                    x.Subtotal,
                    x.Total,
                    x.Taxes,
                    Account = context.Accounts.FirstOrDefault(a => a.Id == x.AccountId).Name,
                    x.CreatedAt
                }).OrderByDescending(x => x.CreatedAt).ToList();
            }           
            GvOrders.DataBind();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            context = new MyContext();
            if (!IsPostBack)
            {
                get_accounts();
                BindGridView(0);
            }
        }

        protected void drop_accounts_SelectedIndexChanged(object sender, EventArgs e)
        {
            int account_id = int.Parse(drop_accounts.SelectedValue);
            BindGridView(account_id);
        }

        protected void btn_createOrder_Click(object sender, EventArgs e)
        {
            Response.Redirect("ProcessOrder");
        }

        protected void GvOrders_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int orderId = int.Parse(todelete.Value);
            var order = context.Orders.FirstOrDefault(x => x.Id == orderId);
            var lines = context.ProductLines.Where(x => x.OrderId == orderId).ToList();
            context.ProductLines.RemoveRange(lines);
            context.SaveChanges();
            context.Orders.Remove(order);
            context.SaveChanges();
            Response.Redirect("Orders");
        }
    }
}