.class Lchat/ola/vn/b/w$a;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/b/w;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "a"
.end annotation


# instance fields
.field a:Lchat/ola/vn/view/OlaCachedImageView;

.field b:Landroid/widget/TextView;

.field c:Landroid/view/View;

.field final synthetic d:Lchat/ola/vn/b/w;


# direct methods
.method public constructor <init>(Lchat/ola/vn/b/w;Landroid/view/View;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/b/w$a;->d:Lchat/ola/vn/b/w;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const p1, 0x7f0903e7

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object p1, p0, Lchat/ola/vn/b/w$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    const p1, 0x7f0901b9

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/b/w$a;->b:Landroid/widget/TextView;

    const p1, 0x7f09002f

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/b/w$a;->c:Landroid/view/View;

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/message/f;)V
    .locals 4

    iget-object v0, p0, Lchat/ola/vn/b/w$a;->d:Lchat/ola/vn/b/w;

    invoke-static {v0}, Lchat/ola/vn/b/w;->a(Lchat/ola/vn/b/w;)Landroid/view/View$OnClickListener;

    move-result-object v0

    if-eqz v0, :cond_0

    new-instance v0, Lchat/ola/vn/b/w$a$1;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/b/w$a$1;-><init>(Lchat/ola/vn/b/w$a;Lchat/ola/vn/message/f;)V

    iget-object v1, p0, Lchat/ola/vn/b/w$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v1, v0}, Lchat/ola/vn/view/OlaCachedImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v1, p0, Lchat/ola/vn/b/w$a;->b:Landroid/widget/TextView;

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/b/w$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, p1}, Lchat/ola/vn/view/OlaCachedImageView;->setTag(Ljava/lang/Object;)V

    iget-object v0, p0, Lchat/ola/vn/b/w$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    iget-object v1, p0, Lchat/ola/vn/b/w$a;->d:Lchat/ola/vn/b/w;

    invoke-static {v1}, Lchat/ola/vn/b/w;->b(Lchat/ola/vn/b/w;)Landroid/view/View$OnLongClickListener;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setOnLongClickListener(Landroid/view/View$OnLongClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/b/w$a;->b:Landroid/widget/TextView;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setTag(Ljava/lang/Object;)V

    iget-object v0, p0, Lchat/ola/vn/b/w$a;->b:Landroid/widget/TextView;

    iget-object v1, p0, Lchat/ola/vn/b/w$a;->d:Lchat/ola/vn/b/w;

    invoke-static {v1}, Lchat/ola/vn/b/w;->b(Lchat/ola/vn/b/w;)Landroid/view/View$OnLongClickListener;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setOnLongClickListener(Landroid/view/View$OnLongClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/b/w$a;->c:Landroid/view/View;

    invoke-virtual {v0, p1}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object v0, p0, Lchat/ola/vn/b/w$a;->c:Landroid/view/View;

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/b/w$a;->b:Landroid/widget/TextView;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->L()Ljava/lang/CharSequence;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v0

    const-string v1, "#"

    invoke-virtual {v0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    const/16 v1, 0x8

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/b/w$a;->c:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->k(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iget-object v1, p0, Lchat/ola/vn/b/w$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, p1, v1}, Lchat/ola/vn/c/t;->i(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V

    return-void

    :cond_1
    const/4 v0, 0x0

    :try_start_0
    sget-object v2, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3, v0}, Lchat/ola/vn/message/g;->e(Ljava/lang/String;S)Lchat/ola/vn/message/f;

    move-result-object v2

    if-nez v2, :cond_2

    iget-object v2, p0, Lchat/ola/vn/b/w$a;->c:Landroid/view/View;

    invoke-virtual {v2, v0}, Landroid/view/View;->setVisibility(I)V

    goto :goto_0

    :cond_2
    iget-object v2, p0, Lchat/ola/vn/b/w$a;->c:Landroid/view/View;

    invoke-virtual {v2, v1}, Landroid/view/View;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    iget-object v2, p0, Lchat/ola/vn/b/w$a;->c:Landroid/view/View;

    invoke-virtual {v2, v1}, Landroid/view/View;->setVisibility(I)V

    :goto_0
    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v1

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object p1

    iget-object v2, p0, Lchat/ola/vn/b/w$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v1, p1, v0, v2}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;ZLchat/ola/vn/view/OlaCachedImageView;)V

    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 4

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v0

    const v1, 0x7f09002f

    if-eq v0, v1, :cond_0

    return-void

    :cond_0
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    const-string v2, "#"

    invoke-virtual {v1, v2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    return-void

    :cond_1
    sget-object v1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lchat/ola/vn/message/g;->d(Ljava/lang/String;)Lchat/ola/vn/message/f;

    move-result-object v1

    if-nez v1, :cond_3

    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v1, v0}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/message/f;)V

    sget-object v1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v1, v0}, Lchat/ola/vn/message/g;->e(Lchat/ola/vn/message/f;)Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->p()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_2

    sget-object v1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->p()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Lchat/ola/vn/message/g;->a(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    :cond_2
    sget-object v1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lchat/ola/vn/message/g;->a(Ljava/lang/String;)V

    :cond_3
    :goto_0
    const/16 v1, 0x8

    invoke-virtual {p1, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/b/w$a;->d:Lchat/ola/vn/b/w;

    invoke-static {p1}, Lchat/ola/vn/b/w;->c(Lchat/ola/vn/b/w;)Ljava/util/List;

    move-result-object p1

    invoke-interface {p1, v0}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    iget-object p1, p0, Lchat/ola/vn/b/w$a;->d:Lchat/ola/vn/b/w;

    invoke-virtual {p1}, Lchat/ola/vn/b/w;->notifyDataSetChanged()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
