<%@ Page Title="Accounts" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Accounts.aspx.cs" Inherits="WebTest.Accounts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script src="../Scripts/sweetalert.min.js" type="text/javascript"></script>
    <link href="../Content/bootstrap.css" rel="stylesheet" />
    <link href="../Content/bootstrap.min.css" rel="stylesheet" />
    <script src="../Scripts/bootstrap.js"></script>
    <script src="../Scripts/bootstrap.min.js"></script>
    <script>
        function alert(campo) {
            $(campo).show("slow").delay(3000).hide("slow")
            return true;
        }
    </script>
    <script>
        function alertme(titulo, mesaje, Tipo) {
            debugger;
            swal(titulo, mesaje, Tipo)
        }
    </script>

    <asp:MultiView ID="mv" runat="server">
        <asp:View ID="v1" runat="server">
            <div class="col-lg-12 col-sm-12 col-12">
                <h3>Accounts</h3>
            </div>

            <asp:UpdatePanel ID="up1" runat="server" UpdateMode="Conditional">
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="GvAccounts" EventName="RowCommand" />
                </Triggers>
                <ContentTemplate>
                    <div class="form-group row" style="border-radius: 20px; border: 2px solid black; padding: 10px; display: flex; justify-content: space-between">
                        <div class="row" style="margin: 10px">
                            <div class="col-xs-4 col-sm-4 col-md-4">
                                <div class="form-group row">
                                    <label class="col-form-label col-sm-4">Name*</label>
                                    <div class="col-sm-8">
                                        <asp:TextBox runat="server" type="text" AutoComplete="off" AutoCompleteType="Disabled" MaxLength="80" ID="tbx_name" class="form-control" TabIndex="0" />
                                    </div>
                                </div>
                            </div>
                            <div class="col-xs-4 col-sm-4 col-md-4">
                                <div class="form-group row">
                                    <label class="col-form-label col-sm-4">Phone</label>
                                    <div class="col-sm-8">
                                        <asp:TextBox runat="server" type="text" AutoComplete="off" AutoCompleteType="Disabled" MaxLength="80" ID="tbx_phone" class="form-control" TabIndex="1" TextMode="Phone" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row" style="margin: 10px">
                            <div class="col-xs-4 col-sm-4 col-md-4">
                                <div class="form-group row">
                                    <label class="col-form-label col-sm-4">Adress1*</label>
                                    <div class="col-sm-8">
                                        <asp:TextBox runat="server" type="text" AutoComplete="off" AutoCompleteType="Disabled" MaxLength="80" ID="tbx_address1" class="form-control" TabIndex="3" />
                                    </div>
                                </div>
                            </div>
                            <div class="col-xs-4 col-sm-4 col-md-4">
                                <div class="form-group row">
                                    <label class="col-form-label col-sm-4">Adress2</label>
                                    <div class="col-sm-8">
                                        <asp:TextBox runat="server" type="text" AutoComplete="off" AutoCompleteType="Disabled" MaxLength="80" ID="tbx_address2" class="form-control" TabIndex="2" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row" style="margin: 10px">
                            <div class="col-xs-4 col-sm-4 col-md-4">
                                <div class="form-group row">
                                    <label class="col-form-label col-sm-4">City*</label>
                                    <div class="col-sm-8">
                                        <asp:TextBox runat="server" type="text" AutoComplete="off" AutoCompleteType="Disabled" MaxLength="80" ID="tbx_city" class="form-control" TabIndex="4" />
                                    </div>
                                </div>
                            </div>
                            <div class="col-xs-4 col-sm-4 col-md-4">
                                <div class="form-group row">
                                    <label class="col-form-label col-sm-4">ZipCode</label>
                                    <div class="col-sm-8">
                                        <asp:TextBox runat="server" type="text" AutoComplete="off" AutoCompleteType="Disabled" MaxLength="80" ID="tbx_zipcode" class="form-control" TabIndex="4" />
                                    </div>
                                </div>
                            </div>
                            <div class="col-xs-3 col-sm-3 col-md-3">
                                <div class="form-group row">
                                    <label class="col-form-label col-sm-4">State*</label>
                                    <div class="col-sm-8">
                                        <asp:DropDownList ID="drop_states" class="selectpicker show-tick form-control" data-live-search="true" data-style="btn-primary" runat="server">
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row" style="margin: 10px">
                            <div class="col-xs-3 col-sm-3 col-md-3">
                                <div class="form-group row">
                                    <label class="col-form-label col-sm-4"></label>
                                    <div class="col-sm-8">
                                        <asp:Button Text="Save" ID="btnSave" runat="server" CssClass="btn btn-primary" title="Save Account" OnClick="btnSave_Click" />
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
                    </div>
                    <br />
                    <br />
                    <div>
                        <asp:HiddenField ID="todelete" runat="server" ClientIDMode="Static"  />
                        <div style="overflow-y: scroll; max-height: 500px;">
                            <asp:GridView ID="GvAccounts" runat="server"
                                CssClass="table border-bottom bs-table"
                                margin-left="auto" margin-right="auto"
                                OnRowCommand="GvAccounts_RowCommand"
                                AutoGenerateColumns="False">
                                <Columns>
                                    <asp:BoundField DataField="Name" HeaderText="Name" ReadOnly="True" SortExpression="Name" />
                                    <asp:BoundField DataField="Phone" HeaderText="Phone" ReadOnly="True" SortExpression="Phone" />
                                    <asp:BoundField DataField="Address" HeaderText="Address" ReadOnly="True" SortExpression="Address" />
                                    <asp:BoundField DataField="City" HeaderText="" ReadOnly="True" SortExpression="City" />
                                    <asp:BoundField DataField="State" HeaderText="State" ReadOnly="True" SortExpression="State" />
                                    <asp:BoundField DataField="ZipCode" HeaderText="Zip Code" ReadOnly="True" SortExpression="ZipCode" />
                                    <asp:CommandField ShowSelectButton="True" ControlStyle-CssClass="btn btn-primary" ButtonType="Button" SelectText="Edit">
                                        <ControlStyle CssClass="btn btn-primary" />
                                    </asp:CommandField>
                                    <asp:TemplateField>
                                        <ItemTemplate>                                            
                                            <button type="button" id="false_delete" class="btn btn-primary" onclick="var cc = $('#todelete')[0]; $(cc).val($('#false_delete:hover').parent().prev().prev().prev().prev().prev().prev().prev().text()) ;var x = $('#MyModal')[0]; $(x).modal('toggle');">
                                                Delete
                                            </button>
                                            <div class="modal" id="MyModal" tabindex="-1" role="dialog">
                                                <div class="modal-dialog" role="document">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title">Confirmation</h5>                                                            
                                                        </div>
                                                        <div class="modal-body">
                                                            <p>Do you want to delete this Account?</p>
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
                <h5 style="margin: 5px">This Account is being used in an Order, cannot be deleted</h5>
                <div style="margin: 5px">
                    <asp:Button Text="Return" ID="btn_return" runat="server" CssClass="btn btn-primary" title="Return" OnClick="btn_return_Click" />
                </div>
            </div>
        </asp:View>
    </asp:MultiView>


</asp:Content>
