.class Lchat/ola/vn/entry/b/q$1;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/p/o;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/entry/b/q;->a()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/entry/b/q;


# direct methods
.method constructor <init>(Lchat/ola/vn/entry/b/q;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entry/b/q$1;->a:Lchat/ola/vn/entry/b/q;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/entry/b/q$1;->a:Lchat/ola/vn/entry/b/q;

    invoke-static {v0}, Lchat/ola/vn/entry/b/q;->a(Lchat/ola/vn/entry/b/q;)Lchat/ola/vn/entry/c;

    move-result-object v0

    const-string v1, ""

    invoke-virtual {v0, v1}, Lchat/ola/vn/entry/c;->a(Ljava/lang/String;)V

    return-void
.end method

.method public a(Lchat/ola/vn/entity/ai;)V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/q$1;->a:Lchat/ola/vn/entry/b/q;

    invoke-static {v0}, Lchat/ola/vn/entry/b/q;->a(Lchat/ola/vn/entry/b/q;)Lchat/ola/vn/entry/c;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/entry/c;->d()Ljava/lang/CharSequence;

    move-result-object v0

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p1, Lchat/ola/vn/entity/ai;->c:Ljava/lang/String;

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_3

    iget-object v0, p1, Lchat/ola/vn/entity/ai;->a:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/entry/b/q$1;->a:Lchat/ola/vn/entry/b/q;

    invoke-static {v0}, Lchat/ola/vn/entry/b/q;->a(Lchat/ola/vn/entry/b/q;)Lchat/ola/vn/entry/c;

    move-result-object v0

    iget-object v1, p1, Lchat/ola/vn/entity/ai;->a:Ljava/lang/String;

    :goto_0
    invoke-virtual {v0, v1}, Lchat/ola/vn/entry/c;->a(Ljava/lang/String;)V

    goto :goto_1

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/q$1;->a:Lchat/ola/vn/entry/b/q;

    invoke-static {v0}, Lchat/ola/vn/entry/b/q;->a(Lchat/ola/vn/entry/b/q;)Lchat/ola/vn/entry/c;

    move-result-object v0

    const-string v1, ""

    goto :goto_0

    :goto_1
    iget-object v0, p1, Lchat/ola/vn/entity/ai;->d:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/entry/b/q$1;->a:Lchat/ola/vn/entry/b/q;

    invoke-static {v0}, Lchat/ola/vn/entry/b/q;->a(Lchat/ola/vn/entry/b/q;)Lchat/ola/vn/entry/c;

    move-result-object v0

    iget-object p1, p1, Lchat/ola/vn/entity/ai;->d:Ljava/lang/String;

    invoke-virtual {v0, p1}, Lchat/ola/vn/entry/c;->b(Ljava/lang/String;)V

    goto :goto_2

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/entry/b/q$1;->a:Lchat/ola/vn/entry/b/q;

    invoke-static {p1}, Lchat/ola/vn/entry/b/q;->a(Lchat/ola/vn/entry/b/q;)Lchat/ola/vn/entry/c;

    move-result-object p1

    const-string v0, ""

    invoke-virtual {p1, v0}, Lchat/ola/vn/entry/c;->b(Ljava/lang/String;)V

    :goto_2
    iget-object p1, p0, Lchat/ola/vn/entry/b/q$1;->a:Lchat/ola/vn/entry/b/q;

    invoke-static {p1}, Lchat/ola/vn/entry/b/q;->a(Lchat/ola/vn/entry/b/q;)Lchat/ola/vn/entry/c;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/entry/c;->f()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/entry/b/q$1;->a:Lchat/ola/vn/entry/b/q;

    invoke-static {p1}, Lchat/ola/vn/entry/b/q;->b(Lchat/ola/vn/entry/b/q;)Landroid/view/View;

    move-result-object p1

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/q$1;->a:Lchat/ola/vn/entry/b/q;

    invoke-static {p1}, Lchat/ola/vn/entry/b/q;->c(Lchat/ola/vn/entry/b/q;)Landroid/widget/TextView;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/entry/b/q$1;->a:Lchat/ola/vn/entry/b/q;

    invoke-static {v0}, Lchat/ola/vn/entry/b/q;->a(Lchat/ola/vn/entry/b/q;)Lchat/ola/vn/entry/c;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/entry/c;->f()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/q$1;->a:Lchat/ola/vn/entry/b/q;

    invoke-static {p1}, Lchat/ola/vn/entry/b/q;->d(Lchat/ola/vn/entry/b/q;)Landroid/widget/TextView;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/entry/b/q$1;->a:Lchat/ola/vn/entry/b/q;

    invoke-static {v0}, Lchat/ola/vn/entry/b/q;->a(Lchat/ola/vn/entry/b/q;)Lchat/ola/vn/entry/c;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/entry/c;->g()Ljava/lang/String;

    move-result-object v0

    :goto_3
    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_2
    iget-object p1, p0, Lchat/ola/vn/entry/b/q$1;->a:Lchat/ola/vn/entry/b/q;

    invoke-static {p1}, Lchat/ola/vn/entry/b/q;->b(Lchat/ola/vn/entry/b/q;)Landroid/view/View;

    move-result-object p1

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/q$1;->a:Lchat/ola/vn/entry/b/q;

    invoke-static {p1}, Lchat/ola/vn/entry/b/q;->c(Lchat/ola/vn/entry/b/q;)Landroid/widget/TextView;

    move-result-object p1

    const-string v0, ""

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/q$1;->a:Lchat/ola/vn/entry/b/q;

    invoke-static {p1}, Lchat/ola/vn/entry/b/q;->d(Lchat/ola/vn/entry/b/q;)Landroid/widget/TextView;

    move-result-object p1

    const-string v0, ""
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_3

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_3
    return-void
.end method
