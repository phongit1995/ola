.class public Lchat/ola/vn/entry/b/aj;
.super Ljava/lang/Object;


# instance fields
.field public a:Landroid/widget/CheckBox;

.field public b:Lchat/ola/vn/view/OlaCachedImageView;

.field public c:Landroid/widget/TextView;

.field public d:Landroid/widget/TextView;

.field public e:Lchat/ola/vn/message/f;

.field public f:Lchat/ola/vn/entity/x;

.field public g:Z


# direct methods
.method public constructor <init>(Landroid/view/View;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x1

    iput-boolean v0, p0, Lchat/ola/vn/entry/b/aj;->g:Z

    const v0, 0x7f090281

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object v0, p0, Lchat/ola/vn/entry/b/aj;->b:Lchat/ola/vn/view/OlaCachedImageView;

    const v0, 0x7f09052a

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/entry/b/aj;->c:Landroid/widget/TextView;

    const v0, 0x7f090529

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/entry/b/aj;->d:Landroid/widget/TextView;

    const v0, 0x7f090167

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/CheckBox;

    iput-object p1, p0, Lchat/ola/vn/entry/b/aj;->a:Landroid/widget/CheckBox;

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/entity/x;)V
    .locals 5

    iput-object p1, p0, Lchat/ola/vn/entry/b/aj;->f:Lchat/ola/vn/entity/x;

    iget-byte v0, p1, Lchat/ola/vn/entity/x;->a:B

    const v1, 0x7f0806a5

    const/16 v2, 0x8

    const/4 v3, 0x0

    packed-switch v0, :pswitch_data_0

    return-void

    :pswitch_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/aj;->c:Landroid/widget/TextView;

    iget-object p1, p1, Lchat/ola/vn/entity/x;->c:Ljava/lang/String;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-boolean p1, p0, Lchat/ola/vn/entry/b/aj;->g:Z

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/entry/b/aj;->d:Landroid/widget/TextView;

    invoke-virtual {p1, v3}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/aj;->d:Landroid/widget/TextView;

    const-string v0, ""

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/entry/b/aj;->d:Landroid/widget/TextView;

    invoke-virtual {p1, v2}, Landroid/widget/TextView;->setVisibility(I)V

    :goto_0
    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/entry/b/aj;->f:Lchat/ola/vn/entity/x;

    if-nez p1, :cond_1

    return-void

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/entry/b/aj;->f:Lchat/ola/vn/entity/x;

    iget-object p1, p1, Lchat/ola/vn/entity/x;->c:Ljava/lang/String;

    iget-boolean v0, p0, Lchat/ola/vn/entry/b/aj;->g:Z

    if-eqz v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/entry/b/aj;->b:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, v3}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    iget-object v2, p0, Lchat/ola/vn/entry/b/aj;->b:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, p1, v2}, Lchat/ola/vn/c/t;->k(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V

    return-void

    :cond_2
    iget-object p1, p0, Lchat/ola/vn/entry/b/aj;->b:Lchat/ola/vn/view/OlaCachedImageView;

    :goto_1
    invoke-virtual {p1, v2}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    iget-object p1, p0, Lchat/ola/vn/entry/b/aj;->b:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {p1, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setImageResource(I)V

    return-void

    :pswitch_1
    iget-object v0, p1, Lchat/ola/vn/entity/x;->b:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_4

    iget-object v0, p0, Lchat/ola/vn/entry/b/aj;->f:Lchat/ola/vn/entity/x;

    iget-object v0, v0, Lchat/ola/vn/entity/x;->c:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->j(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iget-object v4, p0, Lchat/ola/vn/entry/b/aj;->d:Landroid/widget/TextView;

    invoke-virtual {v4, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-boolean v0, p0, Lchat/ola/vn/entry/b/aj;->g:Z

    if-eqz v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/entry/b/aj;->c:Landroid/widget/TextView;

    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/aj;->c:Landroid/widget/TextView;

    iget-object p1, p1, Lchat/ola/vn/entity/x;->b:Ljava/lang/String;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_3

    :cond_3
    iget-object p1, p0, Lchat/ola/vn/entry/b/aj;->c:Landroid/widget/TextView;

    goto :goto_2

    :cond_4
    iget-object p1, p0, Lchat/ola/vn/entry/b/aj;->f:Lchat/ola/vn/entity/x;

    iget-object p1, p1, Lchat/ola/vn/entity/x;->c:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->j(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/entry/b/aj;->c:Landroid/widget/TextView;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-boolean p1, p0, Lchat/ola/vn/entry/b/aj;->g:Z

    if-eqz p1, :cond_5

    iget-object p1, p0, Lchat/ola/vn/entry/b/aj;->d:Landroid/widget/TextView;

    invoke-virtual {p1, v3}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/aj;->d:Landroid/widget/TextView;

    const-string v0, ""

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_3

    :cond_5
    iget-object p1, p0, Lchat/ola/vn/entry/b/aj;->d:Landroid/widget/TextView;

    :goto_2
    invoke-virtual {p1, v2}, Landroid/widget/TextView;->setVisibility(I)V

    :goto_3
    :try_start_1
    iget-object p1, p0, Lchat/ola/vn/entry/b/aj;->f:Lchat/ola/vn/entity/x;

    if-nez p1, :cond_6

    return-void

    :cond_6
    iget-object p1, p0, Lchat/ola/vn/entry/b/aj;->f:Lchat/ola/vn/entity/x;

    iget-object p1, p1, Lchat/ola/vn/entity/x;->c:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->j(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iget-boolean v0, p0, Lchat/ola/vn/entry/b/aj;->g:Z

    if-eqz v0, :cond_7

    iget-object v0, p0, Lchat/ola/vn/entry/b/aj;->b:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, v3}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/aj;->b:Lchat/ola/vn/view/OlaCachedImageView;

    sget-object v2, Landroid/widget/ImageView$ScaleType;->CENTER_CROP:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {v0, v2}, Lchat/ola/vn/view/OlaCachedImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    iget-object v2, p0, Lchat/ola/vn/entry/b/aj;->b:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, p1, v2}, Lchat/ola/vn/c/t;->f(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V

    return-void

    :cond_7
    iget-object p1, p0, Lchat/ola/vn/entry/b/aj;->b:Lchat/ola/vn/view/OlaCachedImageView;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_1

    return-void

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public a(Lchat/ola/vn/message/f;)V
    .locals 2

    if-nez p1, :cond_0

    return-void

    :cond_0
    iput-object p1, p0, Lchat/ola/vn/entry/b/aj;->e:Lchat/ola/vn/message/f;

    iget-object p1, p0, Lchat/ola/vn/entry/b/aj;->c:Landroid/widget/TextView;

    iget-object v0, p0, Lchat/ola/vn/entry/b/aj;->e:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->b()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/aj;->d:Landroid/widget/TextView;

    iget-object v0, p0, Lchat/ola/vn/entry/b/aj;->e:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/aj;->e:Lchat/ola/vn/message/f;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->k()S

    move-result p1

    const/4 v0, 0x2

    if-ne p1, v0, :cond_1

    iget-object p1, p0, Lchat/ola/vn/entry/b/aj;->b:Lchat/ola/vn/view/OlaCachedImageView;

    const v0, 0x7f080692

    invoke-virtual {p1, v0}, Lchat/ola/vn/view/OlaCachedImageView;->setImageResource(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/aj;->d:Landroid/widget/TextView;

    const v0, 0x7f0f0466

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(I)V

    return-void

    :cond_1
    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/entry/b/aj;->e:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/entry/b/aj;->b:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {p1, v0, v1}, Lchat/ola/vn/c/t;->f(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V

    return-void
.end method

.method public a(Z)V
    .locals 0

    iput-boolean p1, p0, Lchat/ola/vn/entry/b/aj;->g:Z

    return-void
.end method
