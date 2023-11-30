<%@ Page Title="Add Item" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AddItem.aspx.cs" Inherits="WebTest.AddItem" %>

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
    <div class="col-lg-12 col-sm-12 col-12">
        <h3>Add New Item</h3>
    </div>
    <asp:UpdatePanel ID="up1" runat="server" UpdateMode="Conditional">
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />
        </Triggers>
        <ContentTemplate>
            <div class="form-group row">
                <div class="col-xs-3 col-sm-3 col-md-3">
                    <div class="form-group row">
                        <label class="col-form-label col-sm-4">Name:</label>
                        <div class="col-sm-8">
                            <asp:TextBox runat="server" type="text" AutoComplete="off" AutoCompleteType="Disabled" MaxLength="80" ID="Name" class="form-control" TabIndex="0" />
                        </div>
                    </div>
                </div>
                <div class="col-xs-3 col-sm-3 col-md-3">
                    <div class="form-group row">
                        <label class="col-form-label col-sm-4">Price:</label>
                        <div class="col-sm-8">
                            <asp:TextBox runat="server" type="money" AutoComplete="off" AutoCompleteType="Disabled" MaxLength="80" ID="Price" class="form-control" TabIndex="1" />
                        </div>
                    </div>
                </div>
                <div class="col-xs-3 col-sm-3 col-md-3">
                    <div class="form-group row">
                        <label class="col-form-label col-sm-4"></label>
                        <div class="col-sm-8">
                            <asp:Button Text="Save" ID="btnSave" runat="server" CssClass="btn btn-primary" title="Save Item" OnClick="btnSave_Click" />
                        </div>
                    </div>
                </div>
            </div>
            <br />
            <br />
            <div>
                <div style="overflow-y: scroll; max-height: 500px;">
                    <asp:GridView ID="GvItems" runat="server"
                        CssClass="table border-bottom bs-table"
                        margin-left="auto" margin-right="auto"
                        AutoGenerateColumns="False">
                        <Columns>
                            <asp:BoundField DataField="Name" ReadOnly="True" SortExpression="Name" />
                            <asp:BoundField DataField="Price" ReadOnly="True" SortExpression="Price" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
