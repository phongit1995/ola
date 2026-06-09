.class public Lchat/ola/vn/entry/b/p;
.super Lchat/ola/vn/entry/b/l;


# instance fields
.field private a:Landroid/view/View;

.field private e:Lchat/ola/vn/view/OlaCachedImageView;

.field private f:Landroid/widget/TextView;

.field private g:Landroid/widget/TextView;

.field private h:Landroid/view/View;

.field private i:Lchat/ola/vn/entry/c;


# direct methods
.method public constructor <init>(Landroid/view/View;)V
    .locals 1

    invoke-direct {p0, p1}, Lchat/ola/vn/entry/b/l;-><init>(Landroid/view/View;)V

    const v0, 0x7f090370

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/entry/b/p;->a:Landroid/view/View;

    const v0, 0x7f09029f

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object v0, p0, Lchat/ola/vn/entry/b/p;->e:Lchat/ola/vn/view/OlaCachedImageView;

    const v0, 0x7f09036f

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/entry/b/p;->h:Landroid/view/View;

    const v0, 0x7f090371

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/entry/b/p;->f:Landroid/widget/TextView;

    const v0, 0x7f09036e

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/entry/b/p;->g:Landroid/widget/TextView;

    return-void
.end method

.method private a()V
    .locals 3

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/entry/b/p;->i:Lchat/ola/vn/entry/c;

    invoke-virtual {v1}, Lchat/ola/vn/entry/c;->d()Ljava/lang/CharSequence;

    move-result-object v1

    invoke-interface {v1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/entry/b/p;->e:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/p;->i:Lchat/ola/vn/entry/c;

    invoke-virtual {v0}, Lchat/ola/vn/entry/c;->f()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/entry/b/p;->h:Landroid/view/View;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/p;->f:Landroid/widget/TextView;

    iget-object v1, p0, Lchat/ola/vn/entry/b/p;->i:Lchat/ola/vn/entry/c;

    invoke-virtual {v1}, Lchat/ola/vn/entry/c;->f()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/p;->g:Landroid/widget/TextView;

    iget-object v1, p0, Lchat/ola/vn/entry/b/p;->i:Lchat/ola/vn/entry/c;

    invoke-virtual {v1}, Lchat/ola/vn/entry/c;->g()Ljava/lang/String;

    move-result-object v1

    :goto_0
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/p;->h:Landroid/view/View;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/p;->f:Landroid/widget/TextView;

    const-string v1, ""

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/p;->g:Landroid/widget/TextView;

    const-string v1, ""

    goto :goto_0

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/entry/c;I)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entry/b/p;->i:Lchat/ola/vn/entry/c;

    iget-object p2, p0, Lchat/ola/vn/entry/b/p;->e:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {p2, p1}, Lchat/ola/vn/view/OlaCachedImageView;->setTag(Ljava/lang/Object;)V

    iget-object p2, p0, Lchat/ola/vn/entry/b/p;->h:Landroid/view/View;

    invoke-virtual {p2, p1}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/p;->e:Lchat/ola/vn/view/OlaCachedImageView;

    iget-object p2, p0, Lchat/ola/vn/entry/b/p;->b:Landroid/view/View$OnClickListener;

    invoke-virtual {p1, p2}, Lchat/ola/vn/view/OlaCachedImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/p;->h:Landroid/view/View;

    iget-object p2, p0, Lchat/ola/vn/entry/b/p;->b:Landroid/view/View$OnClickListener;

    invoke-virtual {p1, p2}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    invoke-direct {p0}, Lchat/ola/vn/entry/b/p;->a()V

    return-void
.end method
