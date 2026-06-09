.class Lchat/ola/vn/entry/b/v$1;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/p/b;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/entry/b/v;->a(Lchat/ola/vn/message/l;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/message/l;

.field final synthetic b:Lchat/ola/vn/entry/b/v;


# direct methods
.method constructor <init>(Lchat/ola/vn/entry/b/v;Lchat/ola/vn/message/l;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entry/b/v$1;->b:Lchat/ola/vn/entry/b/v;

    iput-object p2, p0, Lchat/ola/vn/entry/b/v$1;->a:Lchat/ola/vn/message/l;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/entry/b/v$1;->a:Lchat/ola/vn/message/l;

    const/4 p2, 0x0

    invoke-virtual {p1, p2}, Lchat/ola/vn/message/l;->o(Ljava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/v$1;->a:Lchat/ola/vn/message/l;

    invoke-virtual {p1, p2}, Lchat/ola/vn/message/l;->n(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/entity/e;)V
    .locals 2

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/entry/b/v$1;->b:Lchat/ola/vn/entry/b/v;

    invoke-static {p1}, Lchat/ola/vn/entry/b/v;->a(Lchat/ola/vn/entry/b/v;)Lchat/ola/vn/view/OlaCachedImageView;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/view/OlaCachedImageView;->getWidth()I

    move-result p1

    const/16 p2, 0x190

    if-gt p1, p2, :cond_2

    sget-boolean p1, Lchat/ola/vn/h;->I:Z

    if-eqz p1, :cond_0

    goto :goto_1

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/entry/b/v$1;->a:Lchat/ola/vn/message/l;

    invoke-virtual {p3}, Lchat/ola/vn/entity/e;->r()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Lchat/ola/vn/message/l;->a(Ljava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/v$1;->a:Lchat/ola/vn/message/l;

    invoke-virtual {p1}, Lchat/ola/vn/message/l;->a()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/entry/b/v$1;->a:Lchat/ola/vn/message/l;

    invoke-virtual {p3}, Lchat/ola/vn/entity/e;->s()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Lchat/ola/vn/message/l;->a(Ljava/lang/String;)V

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/entry/b/v$1;->a:Lchat/ola/vn/message/l;

    invoke-virtual {p1}, Lchat/ola/vn/message/l;->a()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_4

    iget-object p1, p0, Lchat/ola/vn/entry/b/v$1;->a:Lchat/ola/vn/message/l;

    invoke-virtual {p3}, Lchat/ola/vn/entity/e;->q()Ljava/lang/String;

    move-result-object p2

    :goto_0
    invoke-virtual {p1, p2}, Lchat/ola/vn/message/l;->a(Ljava/lang/String;)V

    goto :goto_2

    :cond_2
    :goto_1
    iget-object p1, p0, Lchat/ola/vn/entry/b/v$1;->a:Lchat/ola/vn/message/l;

    invoke-virtual {p3}, Lchat/ola/vn/entity/e;->q()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Lchat/ola/vn/message/l;->a(Ljava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/v$1;->a:Lchat/ola/vn/message/l;

    invoke-virtual {p1}, Lchat/ola/vn/message/l;->a()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_3

    iget-object p1, p0, Lchat/ola/vn/entry/b/v$1;->a:Lchat/ola/vn/message/l;

    invoke-virtual {p3}, Lchat/ola/vn/entity/e;->r()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Lchat/ola/vn/message/l;->a(Ljava/lang/String;)V

    :cond_3
    iget-object p1, p0, Lchat/ola/vn/entry/b/v$1;->a:Lchat/ola/vn/message/l;

    invoke-virtual {p1}, Lchat/ola/vn/message/l;->a()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_4

    iget-object p1, p0, Lchat/ola/vn/entry/b/v$1;->a:Lchat/ola/vn/message/l;

    invoke-virtual {p3}, Lchat/ola/vn/entity/e;->s()Ljava/lang/String;

    move-result-object p2

    goto :goto_0

    :cond_4
    :goto_2
    iget-object p1, p0, Lchat/ola/vn/entry/b/v$1;->a:Lchat/ola/vn/message/l;

    invoke-virtual {p3}, Lchat/ola/vn/entity/e;->A()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Lchat/ola/vn/message/l;->b(Ljava/lang/String;)V

    invoke-virtual {p3}, Lchat/ola/vn/entity/e;->z()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_5

    iget-object p1, p0, Lchat/ola/vn/entry/b/v$1;->a:Lchat/ola/vn/message/l;

    invoke-virtual {p3}, Lchat/ola/vn/entity/e;->z()Ljava/lang/String;

    move-result-object p2

    :goto_3
    invoke-virtual {p1, p2}, Lchat/ola/vn/message/l;->n(Ljava/lang/String;)V

    goto :goto_4

    :cond_5
    iget-object p1, p0, Lchat/ola/vn/entry/b/v$1;->a:Lchat/ola/vn/message/l;

    const-string p2, ""

    goto :goto_3

    :goto_4
    invoke-virtual {p3}, Lchat/ola/vn/entity/e;->C()I

    move-result p1

    if-ltz p1, :cond_6

    iget-object p1, p0, Lchat/ola/vn/entry/b/v$1;->a:Lchat/ola/vn/message/l;

    invoke-virtual {p3}, Lchat/ola/vn/entity/e;->C()I

    move-result p2

    int-to-long p2, p2

    const-string v0, ":"

    const-string v1, ":"

    invoke-static {p2, p3, v0, v1}, Lcom/mg/ola/common/d/i;->a(JLjava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    :goto_5
    invoke-virtual {p1, p2}, Lchat/ola/vn/message/l;->o(Ljava/lang/String;)V

    goto :goto_6

    :cond_6
    iget-object p1, p0, Lchat/ola/vn/entry/b/v$1;->a:Lchat/ola/vn/message/l;

    const-string p2, ""

    goto :goto_5

    :goto_6
    iget-object p1, p0, Lchat/ola/vn/entry/b/v$1;->a:Lchat/ola/vn/message/l;

    invoke-virtual {p1}, Lchat/ola/vn/message/l;->C()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_7

    iget-object p1, p0, Lchat/ola/vn/entry/b/v$1;->b:Lchat/ola/vn/entry/b/v;

    invoke-static {p1}, Lchat/ola/vn/entry/b/v;->b(Lchat/ola/vn/entry/b/v;)Landroid/view/View;

    move-result-object p1

    const/4 p2, 0x0

    invoke-virtual {p1, p2}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/v$1;->b:Lchat/ola/vn/entry/b/v;

    invoke-static {p1}, Lchat/ola/vn/entry/b/v;->c(Lchat/ola/vn/entry/b/v;)Landroid/widget/TextView;

    move-result-object p1

    iget-object p2, p0, Lchat/ola/vn/entry/b/v$1;->a:Lchat/ola/vn/message/l;

    invoke-virtual {p2}, Lchat/ola/vn/message/l;->C()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/v$1;->b:Lchat/ola/vn/entry/b/v;

    invoke-static {p1}, Lchat/ola/vn/entry/b/v;->d(Lchat/ola/vn/entry/b/v;)Landroid/widget/TextView;

    move-result-object p1

    iget-object p2, p0, Lchat/ola/vn/entry/b/v$1;->a:Lchat/ola/vn/message/l;

    invoke-virtual {p2}, Lchat/ola/vn/message/l;->D()Ljava/lang/String;

    move-result-object p2

    :goto_7
    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_7
    iget-object p1, p0, Lchat/ola/vn/entry/b/v$1;->b:Lchat/ola/vn/entry/b/v;

    invoke-static {p1}, Lchat/ola/vn/entry/b/v;->b(Lchat/ola/vn/entry/b/v;)Landroid/view/View;

    move-result-object p1

    const/16 p2, 0x8

    invoke-virtual {p1, p2}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/v$1;->b:Lchat/ola/vn/entry/b/v;

    invoke-static {p1}, Lchat/ola/vn/entry/b/v;->c(Lchat/ola/vn/entry/b/v;)Landroid/widget/TextView;

    move-result-object p1

    const-string p2, ""

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/v$1;->b:Lchat/ola/vn/entry/b/v;

    invoke-static {p1}, Lchat/ola/vn/entry/b/v;->d(Lchat/ola/vn/entry/b/v;)Landroid/widget/TextView;

    move-result-object p1

    const-string p2, ""
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_7

    :catch_0
    return-void
.end method
