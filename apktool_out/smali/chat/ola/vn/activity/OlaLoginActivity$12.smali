.class Lchat/ola/vn/activity/OlaLoginActivity$12;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnTouchListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaLoginActivity;->onCreate(Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/OlaLoginActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaLoginActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity$12;->a:Lchat/ola/vn/activity/OlaLoginActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onTouch(Landroid/view/View;Landroid/view/MotionEvent;)Z
    .locals 1

    const/4 p2, 0x0

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const v0, 0x7f0903a6

    if-ne p1, v0, :cond_2

    iget-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity$12;->a:Lchat/ola/vn/activity/OlaLoginActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/OlaLoginActivity;->c(Lchat/ola/vn/activity/OlaLoginActivity;)Landroid/widget/EditText;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/EditText;->isFocused()Z

    move-result p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity$12;->a:Lchat/ola/vn/activity/OlaLoginActivity;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity$12;->a:Lchat/ola/vn/activity/OlaLoginActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/OlaLoginActivity;->c(Lchat/ola/vn/activity/OlaLoginActivity;)Landroid/widget/EditText;

    move-result-object v0

    :goto_0
    invoke-static {p1, v0, p2}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;Landroid/view/View;Z)V

    return p2

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity$12;->a:Lchat/ola/vn/activity/OlaLoginActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/OlaLoginActivity;->d(Lchat/ola/vn/activity/OlaLoginActivity;)Landroid/widget/EditText;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/EditText;->isFocused()Z

    move-result p1

    if-eqz p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity$12;->a:Lchat/ola/vn/activity/OlaLoginActivity;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity$12;->a:Lchat/ola/vn/activity/OlaLoginActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/OlaLoginActivity;->d(Lchat/ola/vn/activity/OlaLoginActivity;)Landroid/widget/EditText;

    move-result-object v0

    goto :goto_0

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity$12;->a:Lchat/ola/vn/activity/OlaLoginActivity;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity$12;->a:Lchat/ola/vn/activity/OlaLoginActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/OlaLoginActivity;->e(Lchat/ola/vn/activity/OlaLoginActivity;)Landroid/widget/EditText;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    :cond_2
    return p2
.end method
