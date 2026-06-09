.class public abstract Lchat/ola/vn/m/a;
.super Lchat/ola/vn/m/f;

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Lchat/ola/vn/f/a;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/m/f;-><init>()V

    return-void
.end method


# virtual methods
.method public a()Lchat/ola/vn/activity/OlaBottomTabActivity;
    .locals 1

    invoke-virtual {p0}, Lchat/ola/vn/m/a;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    if-nez v0, :cond_0

    const/4 v0, 0x0

    return-object v0

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/m/a;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/activity/OlaBottomTabActivity;

    return-object v0
.end method

.method protected a(Landroid/os/Bundle;)V
    .locals 0

    return-void
.end method
