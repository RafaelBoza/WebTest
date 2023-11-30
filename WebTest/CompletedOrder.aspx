<%@ Page Title="Order Completed" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CompletedOrder.aspx.cs" Inherits="WebTest.CompletedOrder" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div style="display: flex; flex-direction: column; align-items: center">
        <div style="margin:5px">
            <asp:Image runat="server" ID="check" ImageUrl="~/pngegg.png" Width="50px" Height="50px" />
        </div>

        <h5 style="margin:5px">Your order has been submited successfully</h5>
        <div style="margin:5px">
            <asp:Button Text="Create Another Order" ID="btn_createOrder" runat="server" CssClass="btn btn-primary" title="Create Another Order" OnClick="btn_createOrder_Click" />
        </div>
        <div style="margin:5px">
            <asp:Button Text="Change Account" ID="btn_changeAccount" runat="server" CssClass="btn btn-primary" title="Change Account" OnClick="btn_changeAccount_Click" />
        </div>
    </div>
</asp:Content>
