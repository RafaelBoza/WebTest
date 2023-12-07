using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebTest.Models;

namespace WebTest
{
    public partial class Accounts : System.Web.UI.Page
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
                get_states();
                BindGridView();
            }

        }
        private void get_states()
        {
            var lista = context.States.Select((x) => new { x.Id, x.Name }).ToList();
            lista.Insert(0, new { Id = string.Empty, Name = "--All--" });
            drop_states.DataSource = lista;
            drop_states.DataTextField = "Name";
            drop_states.DataValueField = "Id";
            drop_states.DataBind();
            drop_states.SelectedIndex = -1;
        }

        private void BindGridView()
        {
            GvAccounts.DataSource = null;
            GvAccounts.Visible = true;
            GvAccounts.DataSource = context.Accounts.Select((x) => new
            {
                x.Name,
                x.Phone,
                Address = (x.AddressLine1.Trim() + " " + x.AddressLine2.Trim()).Trim(),
                x.City,
                State = context.States.FirstOrDefault(s => s.Id == x.StateId).Name,
                x.ZipCode
            }).ToList();
            GvAccounts.DataBind();
        }

        private void ClearControls()
        {
            tbx_name.Text = string.Empty;
            tbx_phone.Text = string.Empty;
            tbx_address1.Text = string.Empty;
            tbx_address2.Text = string.Empty;
            tbx_city.Text = string.Empty;
            drop_states.SelectedIndex = -1;
            tbx_zipcode.Text = string.Empty;
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(tbx_name.Text))
            {
                Msj = "The Account name cannot be empty";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ramdomtext", "alertme('" + titulo + "','" + Msj + "','" + tipo + "');", true);
                return;
            }
            if (string.IsNullOrEmpty(tbx_address1.Text))
            {
                Msj = "The Account address name cannot be empty";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ramdomtext", "alertme('" + titulo + "','" + Msj + "','" + tipo + "');", true);
                return;
            }
            if (string.IsNullOrEmpty(tbx_city.Text))
            {
                Msj = "The Account City name cannot be empty";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ramdomtext", "alertme('" + titulo + "','" + Msj + "','" + tipo + "');", true);
                return;
            }
            if (string.IsNullOrEmpty(drop_states.SelectedValue))
            {
                Msj = "The Account State name cannot be empty";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ramdomtext", "alertme('" + titulo + "','" + Msj + "','" + tipo + "');", true);
                return;
            }

            Account account = new Account();
            account.Name = tbx_name.Text;
            account.Phone = tbx_phone.Text;
            account.AddressLine1 = tbx_address1.Text;
            account.AddressLine2 = tbx_address2.Text;
            account.City = tbx_city.Text;
            account.StateId = drop_states.SelectedValue;
            account.ZipCode = tbx_zipcode.Text;

            if (HttpContext.Current.Session["Mode"] != null)
            {
                if (HttpContext.Current.Session["Mode"].ToString() == "Edit")
                {
                    string oldAccountName = HttpContext.Current.Session["OldAccountName"].ToString();
                    var dbaccount = context.Accounts.FirstOrDefault(x => x.Name == oldAccountName);
                    dbaccount.UpdatedAt = DateTime.Now;
                    dbaccount.Name = tbx_name.Text;
                    dbaccount.Phone = tbx_phone.Text;
                    dbaccount.AddressLine1 = tbx_address1.Text;
                    dbaccount.AddressLine2 = tbx_address2.Text;
                    dbaccount.City = tbx_city.Text;
                    dbaccount.StateId = drop_states.SelectedValue;
                    dbaccount.ZipCode = tbx_zipcode.Text;

                    context.SaveChanges();
                    ClearControls();
                }
            }
            else
            {
                if (context.Accounts.Any(x => x.Name == account.Name))
                {
                    Msj = "There is already an Account with the same name";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ramdomtext", "alertme('" + titulo + "','" + Msj + "','" + tipo + "');", true);
                    return;
                }
                context.Accounts.Add(account);
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
            HttpContext.Current.Session["OldAccountName"] = null;
            BindGridView();
        }

        protected void GvAccounts_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            //Edit Mode
            if (e.CommandName == "Select")
            {
                int rowIndex = int.Parse(e.CommandArgument.ToString());
                GridViewRow row = GvAccounts.Rows[rowIndex];
                string accountName = row.Cells[0].Text;
                var account = context.Accounts.FirstOrDefault(x => x.Name == accountName);
                tbx_name.Text = account.Name;
                tbx_phone.Text = account.Phone;
                tbx_address1.Text = account.AddressLine1;
                tbx_address2.Text = account.AddressLine2;
                tbx_city.Text = account.City;
                tbx_zipcode.Text = account.ZipCode;
                drop_states.SelectedValue = account.StateId;
                HttpContext.Current.Session["Mode"] = "Edit";
                HttpContext.Current.Session["OldAccountName"] = account.Name;
            }
            else
            {

                string accountName = todelete.Value;
                var account = context.Accounts.FirstOrDefault(x => x.Name == accountName);
                if (context.Orders.Any(x => x.AccountId == account.Id))
                {
                    HttpContext.Current.Session["Action"] = true;
                    mv.SetActiveView(v2);
                    Response.Redirect("Accounts.aspx");
                }
                else
                {
                    context.Accounts.Remove(account);
                    context.SaveChanges();
                    BindGridView();
                    HttpContext.Current.Session["Action"] = false;
                    Response.Redirect("Accounts.aspx");
                }

            }
        }

        protected void btn_return_Click(object sender, EventArgs e)
        {
            mv.SetActiveView(v1);
            HttpContext.Current.Session["Action"] = false;
            Response.Redirect("Accounts.aspx");
        }

        protected void btm_clear_Click(object sender, EventArgs e)
        {
            ClearControls();
            HttpContext.Current.Session["Mode"] = null;
        }
    }
}