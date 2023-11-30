<%@ Page Title="Orders List" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Orders.aspx.cs" Inherits="WebTest.About" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <script src="../Scripts/sweetalert.min.js" type="text/javascript"></script>
    <script>
        function alert(campo) {
            $(campo).show("slow").delay(3000).hide("slow")
            return true;
        }
    </script>
    <script>
        function alertme(titulo, mesaje, Tipo) {
            swal.fire(titulo, mesaje, Tipo)
        }
    </script>
    <div class="col-lg-12 col-sm-12 col-12">
        <h3>Orders List</h3>
    </div>
    <asp:UpdatePanel ID="up1" runat="server" UpdateMode="Conditional">
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="drop_accounts" EventName="SelectedIndexChanged" />           
        </Triggers>
        <ContentTemplate>
            <div class="row">
                <div class="col-lg-3 col-sm-3 col-xs-3">
                    <h4>Select Account</h4>
                    <span class="dropdown-header">
                        <asp:DropDownList ID="drop_accounts" class="selectpicker show-tick form-control" data-live-search="true" data-style="btn-primary" runat="server" AutoPostBack="true" OnSelectedIndexChanged="drop_accounts_SelectedIndexChanged">
                        </asp:DropDownList>
                    </span>
                </div>
            </div>
            <br />
            <br />
            <div>
                <div style="overflow-y: scroll; max-height: 500px;">
                    <asp:GridView ID="GvOrders" runat="server"
                        CssClass="table border-bottom bs-table"
                        margin-left="auto" margin-right="auto"
                        AutoGenerateColumns="False">
                        <Columns>
                            <asp:BoundField DataField="Id" HeaderText="Order Id" ReadOnly="True" SortExpression="Id" />
                            <asp:BoundField DataField="Account" HeaderText="Account Name" ReadOnly="True" SortExpression="Account" />
                            <asp:BoundField DataField="Subtotal" HeaderText="Subtotal" ReadOnly="True" SortExpression="Subtotal" />
                            <asp:BoundField DataField="Taxes"  HeaderText="Taxes" ReadOnly="True" SortExpression="Taxes" />
                            <asp:BoundField DataField="Total" HeaderText="Total" ReadOnly="True" SortExpression="Total" />
                            <asp:BoundField DataField="CreatedAt"  HeaderText="Created Date" ReadOnly="True" SortExpression="CreatedAt" />                           
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
