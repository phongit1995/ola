.class Lchat/ola/vn/activity/PurchaseKENActivity$7;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/TextView$OnEditorActionListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/PurchaseKENActivity;->onCreate(Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/PurchaseKENActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/PurchaseKENActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity$7;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onEditorAction(Landroid/widget/TextView;ILandroid/view/KeyEvent;)Z
    .locals 0

    const/4 p1, 0x5

    if-ne p2, p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/activity/PurchaseKENActivity$7;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    iget-object p2, p0, Lchat/ola/vn/activity/PurchaseKENActivity$7;->a:Lchat/ola/vn/activity/PurchaseKENActivity;

    invoke-static {p2}, Lchat/ola/vn/activity/PurchaseKENActivity;->m(Lchat/ola/vn/activity/PurchaseKENActivity;)Landroid/widget/EditText;

    move-result-object p2

    const/4 p3, 0x0

    invoke-static {p1, p2, p3}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;Landroid/view/View;Z)V

    :cond_0
    const/4 p1, 0x1

    return p1
.end method
