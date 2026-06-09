.class Lchat/ola/vn/entry/b/a/a$2;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/p/b;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/entry/b/a/a;->d()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/entry/b/a/a;


# direct methods
.method constructor <init>(Lchat/ola/vn/entry/b/a/a;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entry/b/a/a$2;->a:Lchat/ola/vn/entry/b/a/a;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a$2;->a:Lchat/ola/vn/entry/b/a/a;

    iget-object p1, p1, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object p1, p1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    const-string p2, ""

    iput-object p2, p1, Lchat/ola/vn/entity/f;->d:Ljava/lang/CharSequence;

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a$2;->a:Lchat/ola/vn/entry/b/a/a;

    iget-object p1, p1, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object p1, p1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    const-string p2, ""

    iput-object p2, p1, Lchat/ola/vn/entity/f;->m:Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/entity/e;)V
    .locals 2

    :try_start_0
    iget-object p2, p0, Lchat/ola/vn/entry/b/a/a$2;->a:Lchat/ola/vn/entry/b/a/a;

    iget-object p2, p2, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object p2, p2, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget-object p2, p2, Lchat/ola/vn/entity/f;->o:Ljava/lang/String;

    invoke-static {p2, p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_7

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a$2;->a:Lchat/ola/vn/entry/b/a/a;

    invoke-static {p1}, Lchat/ola/vn/entry/b/a/a;->k(Lchat/ola/vn/entry/b/a/a;)Lchat/ola/vn/view/OlaRatioImageView;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/view/OlaRatioImageView;->getWidth()I

    move-result p1

    const/16 p2, 0x190

    if-le p1, p2, :cond_1

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a$2;->a:Lchat/ola/vn/entry/b/a/a;

    iget-object p1, p1, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object p1, p1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    invoke-virtual {p3}, Lchat/ola/vn/entity/e;->q()Ljava/lang/String;

    move-result-object p2

    iput-object p2, p1, Lchat/ola/vn/entity/f;->p:Ljava/lang/String;

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a$2;->a:Lchat/ola/vn/entry/b/a/a;

    iget-object p1, p1, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object p1, p1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget-object p1, p1, Lchat/ola/vn/entity/f;->p:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a$2;->a:Lchat/ola/vn/entry/b/a/a;

    iget-object p1, p1, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object p1, p1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    invoke-virtual {p3}, Lchat/ola/vn/entity/e;->r()Ljava/lang/String;

    move-result-object p2

    iput-object p2, p1, Lchat/ola/vn/entity/f;->p:Ljava/lang/String;

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a$2;->a:Lchat/ola/vn/entry/b/a/a;

    iget-object p1, p1, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object p1, p1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget-object p1, p1, Lchat/ola/vn/entity/f;->p:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_3

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a$2;->a:Lchat/ola/vn/entry/b/a/a;

    iget-object p1, p1, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object p1, p1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    invoke-virtual {p3}, Lchat/ola/vn/entity/e;->s()Ljava/lang/String;

    move-result-object p2

    :goto_0
    iput-object p2, p1, Lchat/ola/vn/entity/f;->p:Ljava/lang/String;

    goto :goto_1

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a$2;->a:Lchat/ola/vn/entry/b/a/a;

    iget-object p1, p1, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object p1, p1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    invoke-virtual {p3}, Lchat/ola/vn/entity/e;->r()Ljava/lang/String;

    move-result-object p2

    iput-object p2, p1, Lchat/ola/vn/entity/f;->p:Ljava/lang/String;

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a$2;->a:Lchat/ola/vn/entry/b/a/a;

    iget-object p1, p1, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object p1, p1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget-object p1, p1, Lchat/ola/vn/entity/f;->p:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a$2;->a:Lchat/ola/vn/entry/b/a/a;

    iget-object p1, p1, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object p1, p1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    invoke-virtual {p3}, Lchat/ola/vn/entity/e;->s()Ljava/lang/String;

    move-result-object p2

    iput-object p2, p1, Lchat/ola/vn/entity/f;->p:Ljava/lang/String;

    :cond_2
    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a$2;->a:Lchat/ola/vn/entry/b/a/a;

    iget-object p1, p1, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object p1, p1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget-object p1, p1, Lchat/ola/vn/entity/f;->p:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_3

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a$2;->a:Lchat/ola/vn/entry/b/a/a;

    iget-object p1, p1, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object p1, p1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    invoke-virtual {p3}, Lchat/ola/vn/entity/e;->q()Ljava/lang/String;

    move-result-object p2

    goto :goto_0

    :cond_3
    :goto_1
    invoke-virtual {p3}, Lchat/ola/vn/entity/e;->z()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_4

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a$2;->a:Lchat/ola/vn/entry/b/a/a;

    iget-object p1, p1, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object p1, p1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    invoke-virtual {p3}, Lchat/ola/vn/entity/e;->z()Ljava/lang/String;

    move-result-object p2

    :goto_2
    iput-object p2, p1, Lchat/ola/vn/entity/f;->l:Ljava/lang/String;

    goto :goto_3

    :cond_4
    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a$2;->a:Lchat/ola/vn/entry/b/a/a;

    iget-object p1, p1, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object p1, p1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    const-string p2, ""

    goto :goto_2

    :goto_3
    invoke-virtual {p3}, Lchat/ola/vn/entity/e;->C()I

    move-result p1

    if-ltz p1, :cond_5

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a$2;->a:Lchat/ola/vn/entry/b/a/a;

    iget-object p1, p1, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object p1, p1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    invoke-virtual {p3}, Lchat/ola/vn/entity/e;->C()I

    move-result p2

    int-to-long p2, p2

    const-string v0, ":"

    const-string v1, ":"

    invoke-static {p2, p3, v0, v1}, Lcom/mg/ola/common/d/i;->a(JLjava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    :goto_4
    iput-object p2, p1, Lchat/ola/vn/entity/f;->m:Ljava/lang/String;

    goto :goto_5

    :cond_5
    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a$2;->a:Lchat/ola/vn/entry/b/a/a;

    iget-object p1, p1, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object p1, p1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    const-string p2, ""

    goto :goto_4

    :goto_5
    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a$2;->a:Lchat/ola/vn/entry/b/a/a;

    iget-object p1, p1, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object p1, p1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget-object p1, p1, Lchat/ola/vn/entity/f;->l:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_6

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a$2;->a:Lchat/ola/vn/entry/b/a/a;

    invoke-static {p1}, Lchat/ola/vn/entry/b/a/a;->l(Lchat/ola/vn/entry/b/a/a;)Landroid/widget/TextView;

    move-result-object p1

    iget-object p2, p0, Lchat/ola/vn/entry/b/a/a$2;->a:Lchat/ola/vn/entry/b/a/a;

    iget-object p2, p2, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object p2, p2, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget-object p2, p2, Lchat/ola/vn/entity/f;->l:Ljava/lang/String;

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a$2;->a:Lchat/ola/vn/entry/b/a/a;

    invoke-static {p1}, Lchat/ola/vn/entry/b/a/a;->m(Lchat/ola/vn/entry/b/a/a;)Landroid/widget/TextView;

    move-result-object p1

    iget-object p2, p0, Lchat/ola/vn/entry/b/a/a$2;->a:Lchat/ola/vn/entry/b/a/a;

    iget-object p2, p2, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object p2, p2, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget-object p2, p2, Lchat/ola/vn/entity/f;->m:Ljava/lang/String;

    :goto_6
    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_6
    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a$2;->a:Lchat/ola/vn/entry/b/a/a;

    invoke-static {p1}, Lchat/ola/vn/entry/b/a/a;->m(Lchat/ola/vn/entry/b/a/a;)Landroid/widget/TextView;

    move-result-object p1

    const-string p2, "--:--"

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a$2;->a:Lchat/ola/vn/entry/b/a/a;

    invoke-static {p1}, Lchat/ola/vn/entry/b/a/a;->l(Lchat/ola/vn/entry/b/a/a;)Landroid/widget/TextView;

    move-result-object p1

    const-string p2, "--:--"
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_6

    :catch_0
    :cond_7
    return-void
.end method
