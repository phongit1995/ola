.class Lchat/ola/vn/signup/fb/d$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/text/TextWatcher;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/signup/fb/d;->a(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/signup/fb/d;


# direct methods
.method constructor <init>(Lchat/ola/vn/signup/fb/d;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/signup/fb/d$1;->a:Lchat/ola/vn/signup/fb/d;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public afterTextChanged(Landroid/text/Editable;)V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/signup/fb/d$1;->a:Lchat/ola/vn/signup/fb/d;

    invoke-static {v0}, Lchat/ola/vn/signup/fb/d;->a(Lchat/ola/vn/signup/fb/d;)Ljava/lang/Runnable;

    move-result-object v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/signup/fb/d$1;->a:Lchat/ola/vn/signup/fb/d;

    new-instance v1, Lchat/ola/vn/signup/fb/d$1$1;

    invoke-direct {v1, p0}, Lchat/ola/vn/signup/fb/d$1$1;-><init>(Lchat/ola/vn/signup/fb/d$1;)V

    invoke-static {v0, v1}, Lchat/ola/vn/signup/fb/d;->a(Lchat/ola/vn/signup/fb/d;Ljava/lang/Runnable;)Ljava/lang/Runnable;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/signup/fb/d$1;->a:Lchat/ola/vn/signup/fb/d;

    invoke-static {v0}, Lchat/ola/vn/signup/fb/d;->a(Lchat/ola/vn/signup/fb/d;)Ljava/lang/Runnable;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->c(Ljava/lang/Runnable;)V

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result p1

    const/4 v0, 0x6

    const/4 v1, 0x0

    const/4 v2, 0x4

    if-lt p1, v0, :cond_1

    iget-object p1, p0, Lchat/ola/vn/signup/fb/d$1;->a:Lchat/ola/vn/signup/fb/d;

    invoke-static {p1}, Lchat/ola/vn/signup/fb/d;->e(Lchat/ola/vn/signup/fb/d;)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, v2}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/signup/fb/d$1;->a:Lchat/ola/vn/signup/fb/d;

    invoke-static {p1}, Lchat/ola/vn/signup/fb/d;->f(Lchat/ola/vn/signup/fb/d;)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/signup/fb/d$1;->a:Lchat/ola/vn/signup/fb/d;

    invoke-static {p1}, Lchat/ola/vn/signup/fb/d;->a(Lchat/ola/vn/signup/fb/d;)Ljava/lang/Runnable;

    move-result-object p1

    const-wide/16 v0, 0x3e8

    invoke-static {p1, v0, v1}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;J)V

    return-void

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/signup/fb/d$1;->a:Lchat/ola/vn/signup/fb/d;

    invoke-static {p1}, Lchat/ola/vn/signup/fb/d;->c(Lchat/ola/vn/signup/fb/d;)Landroid/widget/TextView;

    move-result-object p1

    invoke-virtual {p1, v2}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/signup/fb/d$1;->a:Lchat/ola/vn/signup/fb/d;

    invoke-static {p1}, Lchat/ola/vn/signup/fb/d;->e(Lchat/ola/vn/signup/fb/d;)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/signup/fb/d$1;->a:Lchat/ola/vn/signup/fb/d;

    invoke-static {p1}, Lchat/ola/vn/signup/fb/d;->f(Lchat/ola/vn/signup/fb/d;)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, v2}, Landroid/view/View;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public beforeTextChanged(Ljava/lang/CharSequence;III)V
    .locals 0

    return-void
.end method

.method public onTextChanged(Ljava/lang/CharSequence;III)V
    .locals 0

    return-void
.end method
