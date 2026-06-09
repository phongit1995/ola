.class Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity$6;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/TextView$OnEditorActionListener;


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

    iput-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity$6;->a:Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onEditorAction(Landroid/widget/TextView;ILandroid/view/KeyEvent;)Z
    .locals 0

    const/4 p1, 0x6

    if-eq p2, p1, :cond_0

    const/4 p1, 0x3

    if-ne p2, p1, :cond_1

    :cond_0
    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity$6;->a:Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;

    iget-object p2, p0, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity$6;->a:Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;

    invoke-static {p2}, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->b(Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;)Landroid/widget/EditText;

    move-result-object p2

    invoke-virtual {p2}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;->a(Lchat/ola/vn/checkin/OlaCheckInSelectOrCreateItemActivity;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    const/4 p1, 0x1

    return p1

    :catch_0
    :cond_1
    const/4 p1, 0x0

    return p1
.end method
