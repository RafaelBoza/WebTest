using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebTest
{
    public partial class CompletedOrder : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btn_createOrder_Click(object sender, EventArgs e)
        {
            HttpContext.Current.Session["Action"] = true;
            Response.Redirect("ProcessOrder.aspx");
        }

        protected void btn_changeAccount_Click(object sender, EventArgs e)
        {
            HttpContext.Current.Session["Account"] = null;
            Response.Redirect("ProcessOrder.aspx");
        }
    }
}