.class Lchat/ola/vn/activity/BuyVipActivity$17;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnTouchListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/BuyVipActivity;->F()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/BuyVipActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/BuyVipActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/BuyVipActivity$17;->a:Lchat/ola/vn/activity/BuyVipActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onTouch(Landroid/view/View;Landroid/view/MotionEvent;)Z
    .locals 0

    invoke-virtual {p2}, Landroid/view/MotionEvent;->getAction()I

    move-result p1

    if-eqz p1, :cond_0

    const/4 p1, 0x0

    return p1

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/activity/BuyVipActivity$17;->a:Lchat/ola/vn/activity/BuyVipActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/BuyVipActivity;->f(Lchat/ola/vn/activity/BuyVipActivity;)Lchat/ola/vn/view/OlaSuggestEditText;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/view/OlaSuggestEditText;->isPopupShowing()Z

    move-result p1

    if-nez p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/activity/BuyVipActivity$17;->a:Lchat/ola/vn/activity/BuyVipActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/BuyVipActivity;->f(Lchat/ola/vn/activity/BuyVipActivity;)Lchat/ola/vn/view/OlaSuggestEditText;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/view/OlaSuggestEditText;->showDropDown()V

    goto :goto_0

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/activity/BuyVipActivity$17;->a:Lchat/ola/vn/activity/BuyVipActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/BuyVipActivity;->f(Lchat/ola/vn/activity/BuyVipActivity;)Lchat/ola/vn/view/OlaSuggestEditText;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/view/OlaSuggestEditText;->dismissDropDown()V

    :goto_0
    const/4 p1, 0x1

    return p1
.end method
