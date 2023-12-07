<%@ Page Title="Products" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Products.aspx.cs" Inherits="WebTest.AddItem" %>

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
    <asp:MultiView ID="mv" runat="server">
        <asp:View ID="v1" runat="server">
            <div class="col-lg-12 col-sm-12 col-12">
                <h3>Products</h3>
            </div>
            <asp:UpdatePanel ID="up1" runat="server" UpdateMode="Always">
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="GvItems" EventName="RowCommand" />
                    <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />
                </Triggers>
                <ContentTemplate>
                    <div class="form-group row" style="border-radius: 20px; border: 2px solid black; padding: 10px">
                        <div class="col-xs-3 col-sm-3 col-md-3">
                            <div class="form-group row">
                                <label class="col-form-label col-sm-4 ">Name*</label>
                                <div class="col-sm-8">
                                    <asp:TextBox runat="server" type="text" AutoComplete="off" AutoCompleteType="Disabled" MaxLength="80" ID="Name" class="form-control" TabIndex="0" />
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-3 col-sm-3 col-md-3">
                            <div class="form-group row">
                                <label class="col-form-label col-sm-4">Price*</label>
                                <div class="col-sm-8">
                                    <asp:TextBox runat="server" type="money" AutoComplete="off" AutoCompleteType="Disabled" MaxLength="80" ID="Price" class="form-control" TabIndex="1" />
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-3 col-sm-3 col-md-3">
                            <div class="form-group row">
                                <label class="col-form-label col-sm-4"></label>
                                <div class="col-sm-8">
                                    <asp:Button Text="Save" ID="btnSave" runat="server" CssClass="btn btn-primary" title="Save Product" OnClick="btnSave_Click" />
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-3 col-sm-3 col-md-3">
                            <div class="form-group row">
                                <label class="col-form-label col-sm-4"></label>
                                <div class="col-sm-8">
                                    <asp:Button Text="Clear Controls" ID="btm_clear" runat="server" CssClass="btn btn-primary" title="Clear Controls" OnClick="btm_clear_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <br />
                    <br />
                    <div>
                        <asp:HiddenField ID="todelete" runat="server" ClientIDMode="Static" />
                        <div style="overflow-y: scroll; max-height: 500px;">
                            <asp:GridView ID="GvItems" runat="server"
                                CssClass="table border-bottom bs-table"
                                margin-left="auto" margin-right="auto"
                                OnRowCommand="GvItems_RowCommand"
                                AutoGenerateColumns="False">
                                <Columns>
                                    <asp:BoundField DataField="Name" HeaderText="Name" ReadOnly="True" SortExpression="Name" />
                                    <asp:BoundField DataField="Price" HeaderText="Price" ReadOnly="True" SortExpression="Price" />
                                    <asp:CommandField ShowSelectButton="True" ControlStyle-CssClass="btn btn-primary" ButtonType="Button" SelectText="Edit">
                                        <ControlStyle CssClass="btn btn-primary" />
                                    </asp:CommandField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <button type="button" id="false_delete" class="btn btn-primary" onclick="var cc = $('#todelete')[0]; $(cc).val($('#false_delete:hover').parent().prev().prev().prev().text()) ;var x = $('#MyModal')[0]; $(x).modal('toggle');">
                                                Delete
                                            </button>
                                            <div class="modal" id="MyModal" tabindex="-1" role="dialog">
                                                <div class="modal-dialog" role="document">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title">Confirmation</h5>
                                                        </div>
                                                        <div class="modal-body">
                                                            <p>Do you want to delete this Product?</p>
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
        </asp:View>
        <asp:View ID="v2" runat="server">
            <div style="display: flex; flex-direction: column; align-items: center">
                <div style="margin: 5px">
                    <asp:Image runat="server" ID="check" ImageUrl="~/Attention-sign-icon.png" Width="50px" Height="50px" />
                </div>
                <h5 style="margin: 5px">This Product is being used in an Order, cannot be deleted</h5>
                <div style="margin: 5px">
                    <asp:Button Text="Return" ID="btn_return" runat="server" CssClass="btn btn-primary" title="Return" OnClick="btn_return_Click" />
                </div>
            </div>
        </asp:View>
    </asp:MultiView>

</asp:Content>
