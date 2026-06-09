.class Lchat/ola/vn/entry/b/a/c$3;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/p/l;


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

    iput-object p1, p0, Lchat/ola/vn/entry/b/a/c$3;->b:Lchat/ola/vn/entry/b/a/c;

    iput-object p2, p0, Lchat/ola/vn/entry/b/a/c$3;->a:Lchat/ola/vn/entry/b/ab;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/entity/u;)V
    .locals 6

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c$3;->b:Lchat/ola/vn/entry/b/a/c;

    iget-object v0, v0, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->C()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "rss://"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Lchat/ola/vn/entity/u;->g()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_3

    invoke-virtual {p1}, Lchat/ola/vn/entity/u;->g()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x1

    if-nez v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c$3;->b:Lchat/ola/vn/entry/b/a/c;

    invoke-static {v0}, Lchat/ola/vn/entry/b/a/c;->a(Lchat/ola/vn/entry/b/a/c;)Landroid/view/View;

    move-result-object v0

    const/4 v2, 0x0

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_2

    :try_start_1
    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c$3;->b:Lchat/ola/vn/entry/b/a/c;

    iget-object v0, v0, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    invoke-virtual {v0}, Lchat/ola/vn/entity/f;->a()Z

    move-result v0
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    :catch_0
    const/4 v0, 0x0

    :goto_0
    :try_start_2
    iget-object v3, p0, Lchat/ola/vn/entry/b/a/c$3;->b:Lchat/ola/vn/entry/b/a/c;

    iget-object v3, v3, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    new-instance v4, Lchat/ola/vn/entity/f;

    invoke-direct {v4}, Lchat/ola/vn/entity/f;-><init>()V

    iput-object v4, v3, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget-object v3, p0, Lchat/ola/vn/entry/b/a/c$3;->b:Lchat/ola/vn/entry/b/a/c;

    iget-object v3, v3, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object v3, v3, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    new-instance v4, Lchat/ola/vn/entity/d;

    const-string v5, "rss"

    invoke-direct {v4, v5}, Lchat/ola/vn/entity/d;-><init>(Ljava/lang/String;)V

    iput-object v4, v3, Lchat/ola/vn/entity/f;->b:Lchat/ola/vn/entity/d;

    iget-object v3, p0, Lchat/ola/vn/entry/b/a/c$3;->b:Lchat/ola/vn/entry/b/a/c;

    iget-object v3, v3, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object v3, v3, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget-object v3, v3, Lchat/ola/vn/entity/f;->b:Lchat/ola/vn/entity/d;

    invoke-virtual {p1}, Lchat/ola/vn/entity/u;->g()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Lchat/ola/vn/entity/d;->b(Ljava/lang/String;)V

    iget-object v3, p0, Lchat/ola/vn/entry/b/a/c$3;->b:Lchat/ola/vn/entry/b/a/c;

    iget-object v3, v3, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object v3, v3, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    invoke-virtual {p1}, Lchat/ola/vn/entity/u;->d()Ljava/lang/String;

    move-result-object v4

    iput-object v4, v3, Lchat/ola/vn/entity/f;->e:Ljava/lang/String;

    iget-object v3, p0, Lchat/ola/vn/entry/b/a/c$3;->b:Lchat/ola/vn/entry/b/a/c;

    iget-object v3, v3, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object v3, v3, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    invoke-virtual {p1}, Lchat/ola/vn/entity/u;->a()J

    move-result-wide v4

    iput-wide v4, v3, Lchat/ola/vn/entity/f;->c:J

    iget-object v3, p0, Lchat/ola/vn/entry/b/a/c$3;->b:Lchat/ola/vn/entry/b/a/c;

    iget-object v3, v3, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object v3, v3, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    invoke-virtual {p1}, Lchat/ola/vn/entity/u;->c()Ljava/lang/String;

    move-result-object v4

    iput-object v4, v3, Lchat/ola/vn/entity/f;->l:Ljava/lang/String;

    iget-object v3, p0, Lchat/ola/vn/entry/b/a/c$3;->b:Lchat/ola/vn/entry/b/a/c;

    iget-object v3, v3, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object v3, v3, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    invoke-virtual {p1}, Lchat/ola/vn/entity/u;->f()I

    move-result v4

    iput v4, v3, Lchat/ola/vn/entity/f;->r:I

    if-nez v0, :cond_0

    invoke-virtual {p1}, Lchat/ola/vn/entity/u;->h()Z

    move-result v0

    :cond_0
    iget-object v3, p0, Lchat/ola/vn/entry/b/a/c$3;->b:Lchat/ola/vn/entry/b/a/c;

    iget-object v3, v3, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object v3, v3, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    if-eqz v0, :cond_1

    const/4 v0, 0x1

    goto :goto_1

    :cond_1
    const/4 v0, 0x0

    :goto_1
    invoke-virtual {v3, v0}, Lchat/ola/vn/entity/f;->a(S)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c$3;->b:Lchat/ola/vn/entry/b/a/c;

    iget-object v0, v0, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    invoke-virtual {p1}, Lchat/ola/vn/entity/u;->e()I

    move-result p1

    iput p1, v0, Lchat/ola/vn/entity/f;->t:I

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$3;->b:Lchat/ola/vn/entry/b/a/c;

    invoke-static {p1}, Lchat/ola/vn/entry/b/a/c;->b(Lchat/ola/vn/entry/b/a/c;)Landroid/widget/ProgressBar;

    move-result-object p1

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/widget/ProgressBar;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$3;->b:Lchat/ola/vn/entry/b/a/c;

    iget-object p1, p1, Lchat/ola/vn/entry/b/a/c;->c:Landroid/view/View;

    invoke-virtual {p1, v2}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$3;->b:Lchat/ola/vn/entry/b/a/c;

    invoke-static {p1}, Lchat/ola/vn/entry/b/a/c;->c(Lchat/ola/vn/entry/b/a/c;)Landroid/widget/TextView;

    move-result-object p1

    iget-object v3, p0, Lchat/ola/vn/entry/b/a/c$3;->b:Lchat/ola/vn/entry/b/a/c;

    iget-object v3, v3, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object v3, v3, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget-object v3, v3, Lchat/ola/vn/entity/f;->l:Ljava/lang/String;

    invoke-virtual {p1, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$3;->b:Lchat/ola/vn/entry/b/a/c;

    iget-object p1, p1, Lchat/ola/vn/entry/b/a/c;->c:Landroid/view/View;

    iget-object v3, p0, Lchat/ola/vn/entry/b/a/c$3;->b:Lchat/ola/vn/entry/b/a/c;

    iget-object v3, v3, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object v3, v3, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    invoke-virtual {p1, v3}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$3;->b:Lchat/ola/vn/entry/b/a/c;

    iget-object p1, p1, Lchat/ola/vn/entry/b/a/c;->c:Landroid/view/View;

    iget-object v3, p0, Lchat/ola/vn/entry/b/a/c$3;->b:Lchat/ola/vn/entry/b/a/c;

    iget-object v3, v3, Lchat/ola/vn/entry/b/a/c;->d:Landroid/view/View$OnClickListener;

    invoke-virtual {p1, v3}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    :try_start_3
    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$3;->b:Lchat/ola/vn/entry/b/a/c;

    invoke-static {p1}, Lchat/ola/vn/entry/b/a/c;->f(Lchat/ola/vn/entry/b/a/c;)[Lchat/ola/vn/view/OlaCachedImageView;

    move-result-object p1

    aget-object p1, p1, v2

    invoke-virtual {p1, v0}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$3;->b:Lchat/ola/vn/entry/b/a/c;

    invoke-static {p1}, Lchat/ola/vn/entry/b/a/c;->f(Lchat/ola/vn/entry/b/a/c;)[Lchat/ola/vn/view/OlaCachedImageView;

    move-result-object p1

    aget-object p1, p1, v1

    invoke-virtual {p1, v0}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$3;->b:Lchat/ola/vn/entry/b/a/c;

    invoke-static {p1}, Lchat/ola/vn/entry/b/a/c;->f(Lchat/ola/vn/entry/b/a/c;)[Lchat/ola/vn/view/OlaCachedImageView;

    move-result-object p1

    const/4 v1, 0x2

    aget-object p1, p1, v1

    invoke-virtual {p1, v0}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_1

    :catch_1
    :try_start_4
    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$3;->b:Lchat/ola/vn/entry/b/a/c;

    invoke-static {p1}, Lchat/ola/vn/entry/b/a/c;->j(Lchat/ola/vn/entry/b/a/c;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$3;->b:Lchat/ola/vn/entry/b/a/c;

    invoke-static {p1}, Lchat/ola/vn/entry/b/a/c;->i(Lchat/ola/vn/entry/b/a/c;)V

    return-void

    :cond_2
    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$3;->b:Lchat/ola/vn/entry/b/a/c;

    iget-object p1, p1, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    new-instance v0, Lchat/ola/vn/entity/f;

    invoke-direct {v0}, Lchat/ola/vn/entity/f;-><init>()V

    iput-object v0, p1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$3;->b:Lchat/ola/vn/entry/b/a/c;

    iget-object p1, p1, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object p1, p1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iput-boolean v1, p1, Lchat/ola/vn/entity/f;->a:Z

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$3;->a:Lchat/ola/vn/entry/b/ab;

    invoke-virtual {p1}, Lchat/ola/vn/entry/b/ab;->g()V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_2

    :catch_2
    :cond_3
    return-void
.end method

.method public a(SLjava/lang/String;)V
    .locals 0

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$3;->b:Lchat/ola/vn/entry/b/a/c;

    iget-object p1, p1, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    new-instance p2, Lchat/ola/vn/entity/f;

    invoke-direct {p2}, Lchat/ola/vn/entity/f;-><init>()V

    iput-object p2, p1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$3;->b:Lchat/ola/vn/entry/b/a/c;

    iget-object p1, p1, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object p1, p1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    const/4 p2, 0x1

    iput-boolean p2, p1, Lchat/ola/vn/entity/f;->a:Z

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$3;->a:Lchat/ola/vn/entry/b/ab;

    invoke-virtual {p1}, Lchat/ola/vn/entry/b/ab;->g()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
