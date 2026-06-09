.class Lchat/ola/vn/b/i$a;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/b/i;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "a"
.end annotation


# instance fields
.field a:Lchat/ola/vn/view/OlaCachedImageView;

.field b:Landroid/widget/ProgressBar;

.field c:Landroid/widget/TextView;

.field d:Landroid/widget/TextView;

.field e:Landroid/widget/TextView;

.field f:Landroid/widget/TextView;

.field g:Landroid/view/View;

.field h:Landroid/view/View;

.field final synthetic i:Lchat/ola/vn/b/i;


# direct methods
.method constructor <init>(Lchat/ola/vn/b/i;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/b/i$a;->i:Lchat/ola/vn/b/i;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private a(Lchat/ola/vn/entry/e;)V
    .locals 3

    invoke-virtual {p1}, Lchat/ola/vn/entry/e;->c()Z

    move-result v0

    const/4 v1, 0x0

    const/16 v2, 0x8

    if-eqz v0, :cond_1

    invoke-virtual {p1}, Lchat/ola/vn/entry/e;->h()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/b/i$a;->e:Landroid/widget/TextView;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/b/i$a;->e:Landroid/widget/TextView;

    invoke-virtual {p1}, Lchat/ola/vn/entry/e;->h()Ljava/lang/String;

    move-result-object p1

    :goto_0
    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/b/i$a;->e:Landroid/widget/TextView;

    invoke-virtual {p1, v2}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/b/i$a;->e:Landroid/widget/TextView;

    :goto_1
    const-string v0, ""

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/b/i$a;->e:Landroid/widget/TextView;

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setVisibility(I)V

    invoke-virtual {p1}, Lchat/ola/vn/entry/e;->p()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/b/i$a;->f:Landroid/widget/TextView;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/b/i$a;->f:Landroid/widget/TextView;

    invoke-virtual {p1}, Lchat/ola/vn/entry/e;->p()Ljava/lang/String;

    move-result-object p1

    goto :goto_0

    :cond_2
    iget-object p1, p0, Lchat/ola/vn/b/i$a;->f:Landroid/widget/TextView;

    invoke-virtual {p1, v2}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/b/i$a;->f:Landroid/widget/TextView;

    goto :goto_1

    return-void
.end method

.method private a(Lchat/ola/vn/view/OlaCachedImageView;Landroid/view/View;Ljava/lang/String;)V
    .locals 1

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    invoke-virtual {v0, p3, p1, p2}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Landroid/view/View;)V

    return-void
.end method

.method private b(Lchat/ola/vn/entry/e;)V
    .locals 4

    iget-object v0, p0, Lchat/ola/vn/b/i$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    if-eqz v0, :cond_2

    invoke-virtual {p1}, Lchat/ola/vn/entry/e;->b()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/b/i$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    iget-object v1, p0, Lchat/ola/vn/b/i$a;->b:Landroid/widget/ProgressBar;

    iget-object v2, p0, Lchat/ola/vn/b/i$a;->i:Lchat/ola/vn/b/i;

    invoke-virtual {p1}, Lchat/ola/vn/entry/e;->b()Ljava/lang/String;

    move-result-object p1

    iget-object v3, p0, Lchat/ola/vn/b/i$a;->i:Lchat/ola/vn/b/i;

    invoke-static {v3}, Lchat/ola/vn/b/i;->a(Lchat/ola/vn/b/i;)I

    move-result v3

    invoke-static {v2, p1, v3}, Lchat/ola/vn/b/i;->a(Lchat/ola/vn/b/i;Ljava/lang/String;I)Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, v0, v1, p1}, Lchat/ola/vn/b/i$a;->a(Lchat/ola/vn/view/OlaCachedImageView;Landroid/view/View;Ljava/lang/String;)V

    return-void

    :cond_0
    invoke-virtual {p1}, Lchat/ola/vn/entry/e;->i()I

    move-result v0

    const/4 v1, 0x0

    if-lez v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/b/i$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setLoadingUrl(Ljava/lang/String;)V

    iget-object v0, p0, Lchat/ola/vn/b/i$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {p1}, Lchat/ola/vn/entry/e;->i()I

    move-result p1

    invoke-virtual {v0, p1}, Lchat/ola/vn/view/OlaCachedImageView;->setImageResource(I)V

    return-void

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/b/i$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {p1, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setLoadingUrl(Ljava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/b/i$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    const v0, 0x7f080818

    invoke-virtual {p1, v0}, Lchat/ola/vn/view/OlaCachedImageView;->setImageResource(I)V

    :cond_2
    return-void
.end method


# virtual methods
.method a(Lchat/ola/vn/entry/e;Lchat/ola/vn/entry/e;Lchat/ola/vn/entry/e;)V
    .locals 2

    :try_start_0
    invoke-virtual {p1}, Lchat/ola/vn/entry/e;->o()B

    move-result p2

    const/16 v0, 0x8

    if-nez p2, :cond_3

    const/4 p2, 0x0

    if-eqz p3, :cond_0

    invoke-virtual {p3}, Lchat/ola/vn/entry/e;->o()B

    move-result p3

    const/4 v1, 0x1

    if-ne p3, v1, :cond_0

    iget-object p3, p0, Lchat/ola/vn/b/i$a;->h:Landroid/view/View;

    invoke-virtual {p3, v0}, Landroid/view/View;->setVisibility(I)V

    goto :goto_0

    :cond_0
    iget-object p3, p0, Lchat/ola/vn/b/i$a;->h:Landroid/view/View;

    invoke-virtual {p3, p2}, Landroid/view/View;->setVisibility(I)V

    :goto_0
    iget-object p3, p0, Lchat/ola/vn/b/i$a;->d:Landroid/widget/TextView;

    invoke-virtual {p1}, Lchat/ola/vn/entry/e;->f()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p3, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    invoke-virtual {p1}, Lchat/ola/vn/entry/e;->n()Ljava/lang/String;

    move-result-object p3

    invoke-static {p3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    iget-object p2, p0, Lchat/ola/vn/b/i$a;->c:Landroid/widget/TextView;

    if-eqz p2, :cond_2

    iget-object p2, p0, Lchat/ola/vn/b/i$a;->c:Landroid/widget/TextView;

    invoke-virtual {p2, v0}, Landroid/widget/TextView;->setVisibility(I)V

    goto :goto_1

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/b/i$a;->c:Landroid/widget/TextView;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/b/i$a;->c:Landroid/widget/TextView;

    invoke-virtual {v0, p2}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p2, p0, Lchat/ola/vn/b/i$a;->c:Landroid/widget/TextView;

    invoke-virtual {p2, p3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :cond_2
    :goto_1
    invoke-direct {p0, p1}, Lchat/ola/vn/b/i$a;->b(Lchat/ola/vn/entry/e;)V

    invoke-direct {p0, p1}, Lchat/ola/vn/b/i$a;->a(Lchat/ola/vn/entry/e;)V

    return-void

    :cond_3
    iget-object p2, p0, Lchat/ola/vn/b/i$a;->f:Landroid/widget/TextView;

    if-eqz p2, :cond_4

    iget-object p2, p0, Lchat/ola/vn/b/i$a;->f:Landroid/widget/TextView;

    invoke-virtual {p2, v0}, Landroid/widget/TextView;->setVisibility(I)V

    :cond_4
    iget-object p2, p0, Lchat/ola/vn/b/i$a;->d:Landroid/widget/TextView;

    invoke-virtual {p1}, Lchat/ola/vn/entry/e;->f()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
