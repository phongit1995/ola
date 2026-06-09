.class Lchat/ola/vn/entry/b/x$3;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/p/o;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/entry/b/x;->e()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/entry/b/x;


# direct methods
.method constructor <init>(Lchat/ola/vn/entry/b/x;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entry/b/x$3;->a:Lchat/ola/vn/entry/b/x;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/entry/b/x$3;->a:Lchat/ola/vn/entry/b/x;

    invoke-static {v0}, Lchat/ola/vn/entry/b/x;->a(Lchat/ola/vn/entry/b/x;)Lchat/ola/vn/entity/k;

    move-result-object v0

    const-string v1, ""

    iput-object v1, v0, Lchat/ola/vn/entity/k;->c:Ljava/lang/String;

    return-void
.end method

.method public a(Lchat/ola/vn/entity/ai;)V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/x$3;->a:Lchat/ola/vn/entry/b/x;

    iget-object v0, v0, Lchat/ola/vn/entry/b/x;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->m:Ljava/lang/String;

    iget-object v1, p1, Lchat/ola/vn/entity/ai;->c:Ljava/lang/String;

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_3

    iget-object v0, p1, Lchat/ola/vn/entity/ai;->a:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/entry/b/x$3;->a:Lchat/ola/vn/entry/b/x;

    invoke-static {v0}, Lchat/ola/vn/entry/b/x;->a(Lchat/ola/vn/entry/b/x;)Lchat/ola/vn/entity/k;

    move-result-object v0

    iget-object v1, p1, Lchat/ola/vn/entity/ai;->a:Ljava/lang/String;

    :goto_0
    iput-object v1, v0, Lchat/ola/vn/entity/k;->c:Ljava/lang/String;

    goto :goto_1

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/x$3;->a:Lchat/ola/vn/entry/b/x;

    invoke-static {v0}, Lchat/ola/vn/entry/b/x;->a(Lchat/ola/vn/entry/b/x;)Lchat/ola/vn/entity/k;

    move-result-object v0

    const-string v1, ""

    goto :goto_0

    :goto_1
    iget-object v0, p1, Lchat/ola/vn/entity/ai;->d:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/entry/b/x$3;->a:Lchat/ola/vn/entry/b/x;

    invoke-static {v0}, Lchat/ola/vn/entry/b/x;->a(Lchat/ola/vn/entry/b/x;)Lchat/ola/vn/entity/k;

    move-result-object v0

    iget-object p1, p1, Lchat/ola/vn/entity/ai;->d:Ljava/lang/String;

    iput-object p1, v0, Lchat/ola/vn/entity/k;->d:Ljava/lang/String;

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/entry/b/x$3;->a:Lchat/ola/vn/entry/b/x;

    invoke-static {p1}, Lchat/ola/vn/entry/b/x;->a(Lchat/ola/vn/entry/b/x;)Lchat/ola/vn/entity/k;

    move-result-object p1

    iget-object p1, p1, Lchat/ola/vn/entity/k;->c:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/entry/b/x$3;->a:Lchat/ola/vn/entry/b/x;

    invoke-static {p1}, Lchat/ola/vn/entry/b/x;->b(Lchat/ola/vn/entry/b/x;)Landroid/view/View;

    move-result-object p1

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/x$3;->a:Lchat/ola/vn/entry/b/x;

    invoke-static {p1}, Lchat/ola/vn/entry/b/x;->c(Lchat/ola/vn/entry/b/x;)Landroid/widget/TextView;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/entry/b/x$3;->a:Lchat/ola/vn/entry/b/x;

    invoke-static {v0}, Lchat/ola/vn/entry/b/x;->a(Lchat/ola/vn/entry/b/x;)Lchat/ola/vn/entity/k;

    move-result-object v0

    iget-object v0, v0, Lchat/ola/vn/entity/k;->c:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/x$3;->a:Lchat/ola/vn/entry/b/x;

    invoke-static {p1}, Lchat/ola/vn/entry/b/x;->d(Lchat/ola/vn/entry/b/x;)Landroid/widget/TextView;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/entry/b/x$3;->a:Lchat/ola/vn/entry/b/x;

    invoke-static {v0}, Lchat/ola/vn/entry/b/x;->a(Lchat/ola/vn/entry/b/x;)Lchat/ola/vn/entity/k;

    move-result-object v0

    iget-object v0, v0, Lchat/ola/vn/entity/k;->d:Ljava/lang/String;

    :goto_2
    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_2
    iget-object p1, p0, Lchat/ola/vn/entry/b/x$3;->a:Lchat/ola/vn/entry/b/x;

    invoke-static {p1}, Lchat/ola/vn/entry/b/x;->b(Lchat/ola/vn/entry/b/x;)Landroid/view/View;

    move-result-object p1

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/x$3;->a:Lchat/ola/vn/entry/b/x;

    invoke-static {p1}, Lchat/ola/vn/entry/b/x;->c(Lchat/ola/vn/entry/b/x;)Landroid/widget/TextView;

    move-result-object p1

    const-string v0, ""

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/x$3;->a:Lchat/ola/vn/entry/b/x;

    invoke-static {p1}, Lchat/ola/vn/entry/b/x;->d(Lchat/ola/vn/entry/b/x;)Landroid/widget/TextView;

    move-result-object p1

    const-string v0, ""
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_2

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_3
    return-void
.end method
