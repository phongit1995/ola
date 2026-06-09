.class Lchat/ola/vn/activity/OlaUserProfileActivity$2;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnTouchListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaUserProfileActivity;->onCreate(Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/OlaUserProfileActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaUserProfileActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity$2;->a:Lchat/ola/vn/activity/OlaUserProfileActivity;

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

    const/4 p1, 0x0

    :try_start_0
    iget-object p2, p0, Lchat/ola/vn/activity/OlaUserProfileActivity$2;->a:Lchat/ola/vn/activity/OlaUserProfileActivity;

    invoke-static {p2}, Lchat/ola/vn/activity/OlaUserProfileActivity;->b(Lchat/ola/vn/activity/OlaUserProfileActivity;)Landroid/widget/EditText;

    move-result-object p2

    invoke-virtual {p2}, Landroid/widget/EditText;->isFocused()Z

    move-result p2

    if-eqz p2, :cond_0

    iget-object p2, p0, Lchat/ola/vn/activity/OlaUserProfileActivity$2;->a:Lchat/ola/vn/activity/OlaUserProfileActivity;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity$2;->a:Lchat/ola/vn/activity/OlaUserProfileActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/OlaUserProfileActivity;->b(Lchat/ola/vn/activity/OlaUserProfileActivity;)Landroid/widget/EditText;

    move-result-object v0

    invoke-static {p2, v0, p1}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;Landroid/view/View;Z)V

    iget-object p2, p0, Lchat/ola/vn/activity/OlaUserProfileActivity$2;->a:Lchat/ola/vn/activity/OlaUserProfileActivity;

    invoke-static {p2}, Lchat/ola/vn/activity/OlaUserProfileActivity;->b(Lchat/ola/vn/activity/OlaUserProfileActivity;)Landroid/widget/EditText;

    move-result-object p2

    :goto_0
    invoke-virtual {p2, p1}, Landroid/widget/EditText;->setEnabled(Z)V

    return p1

    :cond_0
    iget-object p2, p0, Lchat/ola/vn/activity/OlaUserProfileActivity$2;->a:Lchat/ola/vn/activity/OlaUserProfileActivity;

    invoke-static {p2}, Lchat/ola/vn/activity/OlaUserProfileActivity;->c(Lchat/ola/vn/activity/OlaUserProfileActivity;)Landroid/widget/EditText;

    move-result-object p2

    invoke-virtual {p2}, Landroid/widget/EditText;->isFocused()Z

    move-result p2

    if-eqz p2, :cond_1

    iget-object p2, p0, Lchat/ola/vn/activity/OlaUserProfileActivity$2;->a:Lchat/ola/vn/activity/OlaUserProfileActivity;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity$2;->a:Lchat/ola/vn/activity/OlaUserProfileActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/OlaUserProfileActivity;->c(Lchat/ola/vn/activity/OlaUserProfileActivity;)Landroid/widget/EditText;

    move-result-object v0

    invoke-static {p2, v0, p1}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;Landroid/view/View;Z)V

    iget-object p2, p0, Lchat/ola/vn/activity/OlaUserProfileActivity$2;->a:Lchat/ola/vn/activity/OlaUserProfileActivity;

    invoke-static {p2}, Lchat/ola/vn/activity/OlaUserProfileActivity;->c(Lchat/ola/vn/activity/OlaUserProfileActivity;)Landroid/widget/EditText;

    move-result-object p2
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    :cond_1
    return p1
.end method
