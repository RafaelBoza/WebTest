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
    <div class="col-lg-12 col-sm-12 col-12" style="display: flex; justify-content: space-between">
        <h3>Orders</h3>
        <div class="col-xs-2 col-sm-2 col-md-2" style="align-content: end;">
            <asp:Button ID="btn_createOrder" runat="server" CssClass="btn btn-primary" OnClick="btn_createOrder_Click" Text="New Order" />
        </div>
    </div>
    <asp:UpdatePanel ID="up1" runat="server" UpdateMode="Conditional">
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="drop_accounts" EventName="SelectedIndexChanged" />
            <asp:AsyncPostBackTrigger ControlID="GvOrders" EventName="RowCommand" />
        </Triggers>
        <ContentTemplate>
            <div class="row">
                <div class="col-lg-3 col-sm-3 col-xs-3">
                    <h4>Filter by Account</h4>
                    <span class="dropdown-header">
                        <asp:DropDownList ID="drop_accounts" class="selectpicker show-tick form-control" data-live-search="true" data-style="btn-primary" runat="server" AutoPostBack="true" OnSelectedIndexChanged="drop_accounts_SelectedIndexChanged">
                        </asp:DropDownList>
                    </span>
                </div>
            </div>
            <br />
            <br />
            <div>
                <asp:HiddenField ID="todelete" runat="server" ClientIDMode="Static" />
                <div style="overflow-y: scroll; max-height: 500px;">
                    <asp:GridView ID="GvOrders" runat="server"
                        CssClass="table border-bottom bs-table"
                        margin-left="auto" margin-right="auto"
                        AutoGenerateColumns="False" OnRowCommand="GvOrders_RowCommand">
                        <Columns>
                            <asp:BoundField DataField="Id" HeaderText="Order Id" ReadOnly="True" SortExpression="Id" />
                            <asp:BoundField DataField="Account" HeaderText="Account Name" ReadOnly="True" SortExpression="Account" />
                            <asp:BoundField DataField="Subtotal" HeaderText="Subtotal" ReadOnly="True" SortExpression="Subtotal" />
                            <asp:BoundField DataField="Taxes" HeaderText="Taxes" ReadOnly="True" SortExpression="Taxes" />
                            <asp:BoundField DataField="Total" HeaderText="Total" ReadOnly="True" SortExpression="Total" />
                            <asp:BoundField DataField="CreatedAt" HeaderText="Created Date" ReadOnly="True" SortExpression="CreatedAt" />
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <button type="button" id="false_delete" class="btn btn-primary" onclick="var cc = $('#todelete')[0]; $(cc).val($('#false_delete:hover').parent().prev().prev().prev().prev().prev().prev().text()) ;var x = $('#MyModal')[0]; $(x).modal('toggle');">
                                        Delete
                                    </button>
                                    <div class="modal" id="MyModal" tabindex="-1" role="dialog">
                                        <div class="modal-dialog" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title">Confirmation</h5>
                                                </div>
                                                <div class="modal-body">
                                                    <p>Do you want to delete this Order?</p>
                                                </div>
                                                <div class="modal-footer">
                                                    <asp:Button ID="btnDelete" runat="server" ClientIDMode="Static" CssClass="btn btn-secondary" CommandName="Delete" Text="Delete" OnClientClick="var x = $('#MyModal')[0]; $(x).modal('toggle');"></asp:Button>
                                                    <button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="var x = $('#MyModal')[0]; $(x).modal('toggle');">Cancel</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
