.class Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity$2;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnTouchListener;


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

    iput-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity$2;->a:Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onTouch(Landroid/view/View;Landroid/view/MotionEvent;)Z
    .locals 1
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "ClickableViewAccessibility"
        }
    .end annotation

    iget-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity$2;->a:Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;

    iget-object p2, p0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity$2;->a:Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;

    invoke-static {p2}, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->b(Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;)Landroid/widget/EditText;

    move-result-object p2

    const/4 v0, 0x0

    invoke-static {p1, p2, v0}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;Landroid/view/View;Z)V

    return v0
.end method
