.class Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity$3;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnFocusChangeListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->F()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity$3;->a:Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onFocusChange(Landroid/view/View;Z)V
    .locals 0

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity$3;->a:Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;

    invoke-static {p1}, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->b(Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;)Landroid/widget/EditText;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/EditText;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object p1

    check-cast p1, Landroid/widget/LinearLayout$LayoutParams;

    if-eqz p2, :cond_0

    const/4 p2, 0x0

    iput p2, p1, Landroid/widget/LinearLayout$LayoutParams;->width:I

    const/high16 p2, 0x3f800000    # 1.0f

    iput p2, p1, Landroid/widget/LinearLayout$LayoutParams;->weight:F

    iget-object p2, p0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity$3;->a:Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;

    :goto_0
    invoke-static {p2}, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->b(Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;)Landroid/widget/EditText;

    move-result-object p2

    invoke-virtual {p2, p1}, Landroid/widget/EditText;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    return-void

    :cond_0
    const/4 p2, -0x2

    iput p2, p1, Landroid/widget/LinearLayout$LayoutParams;->width:I

    const/4 p2, 0x0

    iput p2, p1, Landroid/widget/LinearLayout$LayoutParams;->weight:F

    iget-object p2, p0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity$3;->a:Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    return-void
.end method
