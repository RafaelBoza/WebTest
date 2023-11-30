<%@ Page Title="Process Order" Language="C#" MasterPageFile="~/Site.Master" EnableEventValidation="false" AutoEventWireup="true" CodeBehind="ProcessOrder.aspx.cs" Inherits="WebTest.ProcessOrder" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script src="../Scripts/sweetalert.min.js" type="text/javascript"></script>
    <script>
        function alert(campo) {
            $(campo).show("slow").delay(3000).hide("slow")
            return true;
        }
    </script>
    <script>
        function alertme(titulo, mesaje, Tipo) {
            swal(titulo, mesaje, Tipo)
        }
    </script>
    
    <asp:MultiView ID="MV" runat="server">
        <asp:View ID="V_SelectAccount" runat="server">
            <div class="row">
                <div class="col-lg-3 col-sm-3 col-xs-3">
                    <h4>*Select Account</h4>
                    <span class="dropdown-header">
                        <asp:DropDownList ID="drop_accounts"  class="selectpicker show-tick form-control" data-live-search="true" data-style="btn-primary" runat="server">
                        </asp:DropDownList>
                    </span>
                </div>
            </div>
            <br />
            <br />
            <div class="row">
                <div class="col-xs-3 col-sm-3 col-md-3">
                    <div class="form-group row">
                        <label class="col-form-label col-sm-4"></label>
                        <div class="col-sm-8" style="margin: 5px">
                            <asp:Button Text="Create Order" ID="btnCreate" runat="server" CssClass="btn btn-primary" title="Create Order" OnClick="btnCreate_Click" />
                        </div>
                    </div>
                </div>
            </div>
        </asp:View>
        <asp:View ID="V_NewOrder" runat="server">
            <div class="col-xs-10 col-sm-10 col-md-10" id="M4">
                <div class="form-group row">
                    <h3 class="col-xs-5 col-sm-5 col-md-5">New Order</h3>
                    <div class="col-xs-5 col-sm-5 col-md-5 h3">
                        <asp:Label ID="lbl_account" runat="server" Text=""></asp:Label>
                    </div>
                </div>
            </div>
            <asp:UpdatePanel ID="up1" runat="server" UpdateMode="Conditional">
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="GvItems" EventName="RowCommand" />
                    <asp:AsyncPostBackTrigger ControlID="GvItemsInOrder" EventName="RowCommand" />
                    <asp:AsyncPostBackTrigger ControlID="btn_submit" EventName="Click" />
                </Triggers>
                <ContentTemplate>
                    <div class="row col-xs-10 col-sm-10 col-md-10" style="display: flex; justify-content: space-between">
                        <div class="col-xs-4 col-sm-4 col-md-4" style="overflow-y: scroll; max-height: 300px; min-height: 300px">
                            <div class="row" style="margin:3px">                                
                                <div class="col-xs-8 col-sm-8 col-md-8">                                      
                                    <asp:TextBox placeholder="Search Products"  type="text" runat="server" AutoComplete="off" AutoCompleteType="Disabled" MaxLength="80" ID="tbx_Search" ClientIDMode="Static" class="form-control" TabIndex="0" />                                    
                                 </div>
                                <div class="col-xs-4 col-sm-4 col-md-4">
                                    <asp:Button id="btn_search" runat="server" OnClick="btn_search_Click" Text="Search"/>
                                </div>
                            </div>
                            <asp:GridView ID="GvItems" runat="server"
                                CssClass="table border-bottom bs-table"
                                margin-left="auto" margin-right="auto"
                                AutoGenerateColumns="False"
                                OnRowCommand="GvItems_RowCommand"
                                OnRowDataBound="GvItems_RowDataBound">
                                <Columns>
                                    <asp:BoundField DataField="Name" ReadOnly="True" SortExpression="Name" />
                                    <asp:CommandField ShowSelectButton="True" ControlStyle-CssClass="btn-success" ButtonType="Button" SelectText="Add" ShowCancelButton="False">
                                        <ControlStyle CssClass="btn-success"></ControlStyle>
                                    </asp:CommandField>
                                </Columns>
                            </asp:GridView>
                        </div>
                        <div class="col-xs-6 col-sm-6 col-md-6">
                            <div class="col-lg-12 col-sm-12 col-xs-12" style="overflow-y: scroll; max-height: 300px; min-height: 300px">
                                <asp:GridView ID="GvItemsInOrder" runat="server"
                                    CssClass="table border-bottom bs-table"
                                    margin-left="auto" margin-right="auto"
                                    AutoGenerateColumns="False"
                                    OnRowCommand="GvItemsInOrder_RowCommand"
                                    OnRowDataBound="GvItemsInOrder_RowDataBound">
                                    <Columns>
                                        <asp:BoundField DataField="Name" ReadOnly="True" SortExpression="Name" />
                                        <asp:BoundField DataField="UnitPrice" HeaderText="UnitPrice" ReadOnly="True" SortExpression="UnitPrice" />
                                        <asp:BoundField DataField="Total" HeaderText="Total" ReadOnly="True" SortExpression="Total" />
                                        <asp:CommandField ShowSelectButton="True" ControlStyle-CssClass="glyphicon glyphicon-plus" ButtonType="Button" SelectText="-">
                                            <ControlStyle CssClass="glyphicon glyphicon-plus" />
                                        </asp:CommandField>
                                        <asp:BoundField DataField="Qty" HeaderText="Qty" ReadOnly="True" SortExpression="Qty" />
                                        <asp:CommandField ShowInsertButton="True" ControlStyle-CssClass="glyphicon glyphicon-plus" ButtonType="Button" NewText="+">
                                            <ControlStyle CssClass="glyphicon glyphicon-plus" />
                                        </asp:CommandField>
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>
                        <div style="display: flex; flex-direction: row; justify-content: space-between">
                            <div style="display: flex; flex-direction: column; margin-right: auto">
                            </div>
                            <div style="display: flex; flex-direction: column; justify-content: flex-end; margin-left: auto">

                                <div style="display: flex; flex-direction: row; margin-bottom: 3px">
                                    <h5 style="margin: 3px">Subtotal:</h5>
                                    <div style="display: flex; justify-content: end; margin-left: auto">
                                        <asp:Label runat="server" type="text" ID="lbl_subtotal" CssClass="h5"></asp:Label>
                                    </div>
                                </div>
                                <div style="display: flex; flex-direction: row; margin-bottom: 3px">
                                    <h5 style="margin: 3px">Taxes (7%):</h5>
                                    <div style="display: flex; justify-content: end; margin-left: auto">
                                        <asp:Label runat="server" type="text" ID="lbl_taxes" CssClass="h5"></asp:Label>
                                    </div>
                                </div>
                                <div style="display: flex; flex-direction: row; margin-bottom: 3px">
                                    <h3 style="margin: 3px">Total:</h3>
                                    <div style="display: flex; justify-content: end; margin-left: auto">
                                        <asp:Label runat="server" type="text" ID="lbl_total" CssClass="h3"></asp:Label>
                                    </div>
                                </div>
                                <div class="form-group row" style="margin-bottom: 5px">
                                    <div class="col-lg-6 col-sm-6 col-xs-6">
                                        <asp:Button Text="Submit Order" ID="btn_submit" runat="server" CssClass="btn btn-primary" title="Submit Order" OnClick="btn_submit_Click" />
                                    </div>
                                    <div class="col-lg-6 col-sm-6 col-xs-6">
                                        <asp:Button Text="Cancel Order" ID="btn_cancel" runat="server" CssClass="btn btn-primary" title="Cancel Order" OnClick="btn_cancel_Click" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </asp:View>
    </asp:MultiView>



</asp:Content>
