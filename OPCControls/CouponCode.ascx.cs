// --------------------------------------------------------------------------------
// Copyright AspDotNetStorefront.com. All Rights Reserved.
// http://www.aspdotnetstorefront.com
// For details on this license please visit the product homepage at the URL above.
// THE ABOVE NOTICE MUST REMAIN INTACT. 
// --------------------------------------------------------------------------------
using System;
using System.Web.UI;
using AspDotNetStorefront;
using AspDotNetStorefrontCore;

public partial class OPCControls_CouponCode : System.Web.UI.UserControl
{
    public Customer ThisCustomer
    {
        get
        {
            return ((SkinBase)Page).OPCCustomer;
        }
    }

    public ShoppingCart ShoppingCart
    {
        get
        {
            return ((SkinBase)Page).OPCShoppingCart;
        }
    }

    public event EventHandler CouponCodeChanged;

    public void Initialize()
    {
        lblCouponError.Text = string.Empty;
		lblCouponError.Visible = false;
        BindPromotions();
    }
    #region Private Methods

    private void FireCouponCodeChanged()
    {
        if (CouponCodeChanged != null)
        {
            CouponCodeChanged(this, null);
        }
    }

    private void BindPromotions()
    {
        CouponCode.Text = ShoppingCart.HasCoupon() ? ShoppingCart.Coupon.CouponCode : string.Empty;
        btnRemoveGiftCard.Visible = ShoppingCart.HasCoupon();
    }

    #endregion

    protected void btnAddGiftCard_Click(object sender, EventArgs e)
    {
        Page.Validate("AddGiftCard");
        if (Page.IsValid)
        {
            ShoppingCart.SetCoupon(CouponCode.Text.ToUpperInvariant(), true);
            ((SkinBase)Page).RefreshCart();
            if ((ShoppingCart.HasCoupon() && ShoppingCart.CouponIsValid) ||
                (ShoppingCart.Coupon != null && 
                ShoppingCart.Coupon.CouponType == CouponTypeEnum.GiftCard &&
                ShoppingCart.ContainsGiftCard() &&
                ShoppingCart.HasGiftCards))
            {
                FireCouponCodeChanged();
            }
            else
            {
				lblCouponError.Text = ShoppingCart.CouponStatusMessage;
				lblCouponError.Visible = true;
                ShoppingCart.SetCoupon("", true);
            }
        }
    }

    protected void btnRemoveGiftCard_Click(object sender, EventArgs e)
    {
        ShoppingCart.SetCoupon("", true);

        FireCouponCodeChanged();
    }
}
