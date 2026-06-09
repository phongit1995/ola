.class Lchat/ola/vn/entry/b/a/c$4;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/network/a/a/aj$a;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/entry/b/a/c;->a(Lchat/ola/vn/entry/b/ab;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/entry/b/ab;

.field final synthetic b:Lchat/ola/vn/entry/b/a/c;


# direct methods
.method constructor <init>(Lchat/ola/vn/entry/b/a/c;Lchat/ola/vn/entry/b/ab;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entry/b/a/c$4;->b:Lchat/ola/vn/entry/b/a/c;

    iput-object p2, p0, Lchat/ola/vn/entry/b/a/c$4;->a:Lchat/ola/vn/entry/b/ab;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/entity/z;)V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c$4;->b:Lchat/ola/vn/entry/b/a/c;

    iget-object v0, v0, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    new-instance v1, Lchat/ola/vn/entity/f;

    invoke-direct {v1}, Lchat/ola/vn/entity/f;-><init>()V

    iput-object v1, v0, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c$4;->b:Lchat/ola/vn/entry/b/a/c;

    iget-object v0, v0, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    new-instance v1, Lchat/ola/vn/entity/d;

    const-string v2, "wap"

    invoke-direct {v1, v2}, Lchat/ola/vn/entity/d;-><init>(Ljava/lang/String;)V

    iput-object v1, v0, Lchat/ola/vn/entity/f;->b:Lchat/ola/vn/entity/d;

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c$4;->b:Lchat/ola/vn/entry/b/a/c;

    iget-object v0, v0, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget-object v0, v0, Lchat/ola/vn/entity/f;->b:Lchat/ola/vn/entity/d;

    iget-object v1, p1, Lchat/ola/vn/entity/z;->b:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/d;->b(Ljava/lang/String;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c$4;->b:Lchat/ola/vn/entry/b/a/c;

    iget-object v0, v0, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget-object v1, p1, Lchat/ola/vn/entity/z;->f:Ljava/lang/String;

    iput-object v1, v0, Lchat/ola/vn/entity/f;->e:Ljava/lang/String;

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c$4;->b:Lchat/ola/vn/entry/b/a/c;

    iget-object v0, v0, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget-object p1, p1, Lchat/ola/vn/entity/z;->c:Ljava/lang/String;

    iput-object p1, v0, Lchat/ola/vn/entity/f;->l:Ljava/lang/String;

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$4;->b:Lchat/ola/vn/entry/b/a/c;

    invoke-static {p1}, Lchat/ola/vn/entry/b/a/c;->b(Lchat/ola/vn/entry/b/a/c;)Landroid/widget/ProgressBar;

    move-result-object p1

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/widget/ProgressBar;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$4;->b:Lchat/ola/vn/entry/b/a/c;

    iget-object p1, p1, Lchat/ola/vn/entry/b/a/c;->c:Landroid/view/View;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$4;->b:Lchat/ola/vn/entry/b/a/c;

    invoke-static {p1}, Lchat/ola/vn/entry/b/a/c;->c(Lchat/ola/vn/entry/b/a/c;)Landroid/widget/TextView;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c$4;->b:Lchat/ola/vn/entry/b/a/c;

    iget-object v0, v0, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget-object v0, v0, Lchat/ola/vn/entity/f;->l:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$4;->b:Lchat/ola/vn/entry/b/a/c;

    iget-object p1, p1, Lchat/ola/vn/entry/b/a/c;->c:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c$4;->b:Lchat/ola/vn/entry/b/a/c;

    iget-object v0, v0, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    invoke-virtual {p1, v0}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$4;->b:Lchat/ola/vn/entry/b/a/c;

    iget-object p1, p1, Lchat/ola/vn/entry/b/a/c;->c:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c$4;->b:Lchat/ola/vn/entry/b/a/c;

    iget-object v0, v0, Lchat/ola/vn/entry/b/a/c;->d:Landroid/view/View$OnClickListener;

    invoke-virtual {p1, v0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$4;->b:Lchat/ola/vn/entry/b/a/c;

    invoke-static {p1}, Lchat/ola/vn/entry/b/a/c;->j(Lchat/ola/vn/entry/b/a/c;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$4;->b:Lchat/ola/vn/entry/b/a/c;

    invoke-static {p1}, Lchat/ola/vn/entry/b/a/c;->i(Lchat/ola/vn/entry/b/a/c;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(Ljava/lang/String;)V
    .locals 1

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$4;->b:Lchat/ola/vn/entry/b/a/c;

    iget-object p1, p1, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    new-instance v0, Lchat/ola/vn/entity/f;

    invoke-direct {v0}, Lchat/ola/vn/entity/f;-><init>()V

    iput-object v0, p1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$4;->b:Lchat/ola/vn/entry/b/a/c;

    iget-object p1, p1, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object p1, p1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    const/4 v0, 0x1

    iput-boolean v0, p1, Lchat/ola/vn/entity/f;->a:Z

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$4;->a:Lchat/ola/vn/entry/b/ab;

    invoke-virtual {p1}, Lchat/ola/vn/entry/b/ab;->g()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
