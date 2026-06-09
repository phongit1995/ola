.class public Lchat/ola/vn/entry/b/w;
.super Lchat/ola/vn/entry/b/j;


# instance fields
.field private A:Landroid/widget/LinearLayout;

.field private B:Lchat/ola/vn/view/OlaCachedImageView;

.field private C:Lchat/ola/vn/view/OlaCachedImageView;

.field private D:Lchat/ola/vn/view/OlaCachedImageView;

.field private i:Lchat/ola/vn/view/OlaCachedImageView;

.field private j:Landroid/view/View;

.field private k:Landroid/widget/TextView;

.field private l:Landroid/widget/TextView;

.field private m:Landroid/widget/TextView;

.field private n:Landroid/widget/TextView;

.field private o:Lcom/mg/ola/common/widget/CommpressTextView;

.field private p:Landroid/view/View;

.field private q:Landroid/view/View;

.field private r:Landroid/view/View;

.field private s:Landroid/widget/TextView;

.field private t:Landroid/widget/ImageView;

.field private u:Landroid/view/View;

.field private v:Landroid/widget/TextView;

.field private w:Landroid/widget/ImageView;

.field private x:Landroid/view/View;

.field private y:Landroid/widget/TextView;

.field private z:Landroid/widget/ImageView;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/entry/b/j;-><init>()V

    return-void
.end method

.method private a(Landroid/view/View;Landroid/widget/ImageView;Landroid/widget/TextView;Lchat/ola/vn/entity/d;)V
    .locals 4

    invoke-virtual {p4}, Lchat/ola/vn/entity/d;->a()Ljava/lang/String;

    move-result-object v0

    const-string v1, "like"

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    const/16 v1, 0x8

    const/4 v2, 0x0

    if-nez v0, :cond_1

    invoke-virtual {p4}, Lchat/ola/vn/entity/d;->a()Ljava/lang/String;

    move-result-object v0

    const-string v3, "likeadme"

    invoke-static {v0, v3}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    invoke-virtual {p3, v2}, Landroid/widget/TextView;->setVisibility(I)V

    sget v0, Lchat/ola/vn/f;->A:I

    invoke-virtual {p3, v0}, Landroid/widget/TextView;->setTextColor(I)V

    invoke-virtual {p4}, Lchat/ola/vn/entity/d;->d()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p3, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    invoke-virtual {p1, p4}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    invoke-virtual {p1, v2}, Landroid/view/View;->setVisibility(I)V

    invoke-virtual {p2, v1}, Landroid/widget/ImageView;->setVisibility(I)V

    invoke-virtual {p1, v2}, Landroid/view/View;->setSelected(Z)V

    return-void

    :cond_1
    :goto_0
    invoke-virtual {p1, p4}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    invoke-virtual {p1, v2}, Landroid/view/View;->setVisibility(I)V

    invoke-virtual {p2, v2}, Landroid/widget/ImageView;->setVisibility(I)V

    const p1, 0x7f0f0536

    invoke-virtual {p3, p1}, Landroid/widget/TextView;->setText(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/w;->b:Lchat/ola/vn/entry/b;

    iget-object p1, p1, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {p1}, Lchat/ola/vn/entity/g;->f()I

    move-result p1

    const/4 p4, 0x1

    if-lez p1, :cond_3

    iget-object p1, p0, Lchat/ola/vn/entry/b/w;->n:Landroid/widget/TextView;

    invoke-virtual {p1, v2}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/w;->b:Lchat/ola/vn/entry/b;

    iget-object p1, p1, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {p1}, Lchat/ola/vn/entity/g;->f()I

    move-result p1

    if-le p1, p4, :cond_2

    iget-object p1, p0, Lchat/ola/vn/entry/b/w;->n:Landroid/widget/TextView;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lchat/ola/vn/entry/b/w;->b:Lchat/ola/vn/entry/b;

    iget-object v1, v1, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v1}, Lchat/ola/vn/entity/g;->f()I

    move-result v1

    int-to-long v1, v1

    invoke-static {v1, v2}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, " "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v1, 0x7f0f0538

    :goto_1
    invoke-static {v1}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_2

    :cond_2
    iget-object p1, p0, Lchat/ola/vn/entry/b/w;->n:Landroid/widget/TextView;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lchat/ola/vn/entry/b/w;->b:Lchat/ola/vn/entry/b;

    iget-object v1, v1, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v1}, Lchat/ola/vn/entity/g;->f()I

    move-result v1

    int-to-long v1, v1

    invoke-static {v1, v2}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, " "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v1, 0x7f0f0539

    goto :goto_1

    :cond_3
    iget-object p1, p0, Lchat/ola/vn/entry/b/w;->n:Landroid/widget/TextView;

    invoke-virtual {p1, v1}, Landroid/widget/TextView;->setVisibility(I)V

    :goto_2
    iget-object p1, p0, Lchat/ola/vn/entry/b/w;->b:Lchat/ola/vn/entry/b;

    iget-object p1, p1, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {p1}, Lchat/ola/vn/entity/g;->i()S

    move-result p1

    if-ne p1, p4, :cond_4

    const p1, 0x7f080701

    invoke-virtual {p2, p1}, Landroid/widget/ImageView;->setImageResource(I)V

    sget p1, Lchat/ola/vn/f;->H:I

    :goto_3
    invoke-virtual {p3, p1}, Landroid/widget/TextView;->setTextColor(I)V

    return-void

    :cond_4
    const p1, 0x7f080700

    invoke-virtual {p2, p1}, Landroid/widget/ImageView;->setImageResource(I)V

    sget p1, Lchat/ola/vn/f;->A:I

    goto :goto_3

    return-void
.end method

.method private e()V
    .locals 4

    :try_start_0
    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/entry/b/w;->b:Lchat/ola/vn/entry/b;

    iget-object v1, v1, Lchat/ola/vn/entry/b;->i:Ljava/util/List;

    const/4 v2, 0x0

    invoke-interface {v1, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    iget-object v2, p0, Lchat/ola/vn/entry/b/w;->i:Lchat/ola/vn/view/OlaCachedImageView;

    iget v3, p0, Lchat/ola/vn/entry/b/w;->h:I

    invoke-virtual {v0, v1, v2, v3}, Lchat/ola/vn/c/t;->b(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/w;->i:Lchat/ola/vn/view/OlaCachedImageView;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    return-void
.end method

.method private f()V
    .locals 7

    iget-object v0, p0, Lchat/ola/vn/entry/b/w;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->r()Ljava/util/List;

    move-result-object v0

    const/16 v1, 0x8

    if-eqz v0, :cond_1

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v2

    if-nez v2, :cond_0

    goto :goto_4

    :cond_0
    iget-object v2, p0, Lchat/ola/vn/entry/b/w;->q:Landroid/view/View;

    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Landroid/view/View;->setVisibility(I)V

    :goto_0
    const/4 v2, 0x3

    if-ge v3, v2, :cond_2

    :try_start_0
    invoke-interface {v0, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/entity/d;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    iget-object v4, p0, Lchat/ola/vn/entry/b/w;->b:Lchat/ola/vn/entry/b;

    iget-object v4, v4, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    iput-object v4, v2, Lchat/ola/vn/entity/d;->a:Lchat/ola/vn/entity/g;

    iget-object v4, p0, Lchat/ola/vn/entry/b/w;->b:Lchat/ola/vn/entry/b;

    iget-object v4, v4, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v4}, Lchat/ola/vn/entity/g;->u()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v4}, Lchat/ola/vn/entity/d;->i(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    packed-switch v3, :pswitch_data_0

    goto :goto_3

    :pswitch_0
    :try_start_2
    iget-object v4, p0, Lchat/ola/vn/entry/b/w;->x:Landroid/view/View;

    iget-object v5, p0, Lchat/ola/vn/entry/b/w;->z:Landroid/widget/ImageView;

    iget-object v6, p0, Lchat/ola/vn/entry/b/w;->y:Landroid/widget/TextView;

    :goto_1
    invoke-direct {p0, v4, v5, v6, v2}, Lchat/ola/vn/entry/b/w;->a(Landroid/view/View;Landroid/widget/ImageView;Landroid/widget/TextView;Lchat/ola/vn/entity/d;)V

    goto :goto_3

    :pswitch_1
    iget-object v4, p0, Lchat/ola/vn/entry/b/w;->u:Landroid/view/View;

    iget-object v5, p0, Lchat/ola/vn/entry/b/w;->w:Landroid/widget/ImageView;

    iget-object v6, p0, Lchat/ola/vn/entry/b/w;->v:Landroid/widget/TextView;

    goto :goto_1

    :pswitch_2
    iget-object v4, p0, Lchat/ola/vn/entry/b/w;->r:Landroid/view/View;

    iget-object v5, p0, Lchat/ola/vn/entry/b/w;->t:Landroid/widget/ImageView;

    iget-object v6, p0, Lchat/ola/vn/entry/b/w;->s:Landroid/widget/TextView;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    goto :goto_1

    :catch_1
    packed-switch v3, :pswitch_data_1

    goto :goto_3

    :pswitch_3
    iget-object v2, p0, Lchat/ola/vn/entry/b/w;->x:Landroid/view/View;

    goto :goto_2

    :pswitch_4
    iget-object v2, p0, Lchat/ola/vn/entry/b/w;->u:Landroid/view/View;

    goto :goto_2

    :pswitch_5
    iget-object v2, p0, Lchat/ola/vn/entry/b/w;->r:Landroid/view/View;

    :goto_2
    invoke-virtual {v2, v1}, Landroid/view/View;->setVisibility(I)V

    :goto_3
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :cond_1
    :goto_4
    iget-object v0, p0, Lchat/ola/vn/entry/b/w;->q:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    :cond_2
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch

    :pswitch_data_1
    .packed-switch 0x0
        :pswitch_5
        :pswitch_4
        :pswitch_3
    .end packed-switch
.end method

.method private g()V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/w;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->t()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/entry/b/w;->k:Landroid/widget/TextView;

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/w;->k:Landroid/widget/TextView;

    const v1, 0x7f0f0633

    invoke-static {v1}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private h()V
    .locals 10

    const/4 v0, 0x0

    const/16 v1, 0x8

    :try_start_0
    iget-object v2, p0, Lchat/ola/vn/entry/b/w;->b:Lchat/ola/vn/entry/b;

    iget-object v2, v2, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v2}, Lchat/ola/vn/entity/g;->A()J

    move-result-wide v2

    const-wide/16 v4, 0x3e8

    cmp-long v6, v2, v4

    if-lez v6, :cond_2

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, ""

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {v2, v3}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    const-wide/32 v7, 0x3b9aca00

    cmp-long v9, v2, v7

    const-wide/32 v7, 0xf4240

    if-ltz v9, :cond_0

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    div-long/2addr v2, v7

    invoke-static {v2, v3}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, "M"

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    goto :goto_0

    :cond_0
    cmp-long v9, v2, v7

    if-ltz v9, :cond_1

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    div-long/2addr v2, v4

    invoke-static {v2, v3}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, "K"

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    :cond_1
    :goto_0
    iget-object v2, p0, Lchat/ola/vn/entry/b/w;->m:Landroid/widget/TextView;

    invoke-virtual {v2, v0}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v2, p0, Lchat/ola/vn/entry/b/w;->m:Landroid/widget/TextView;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v4, " "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v4, 0x7f0f0699

    invoke-static {v4}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_1

    :cond_2
    iget-object v2, p0, Lchat/ola/vn/entry/b/w;->m:Landroid/widget/TextView;

    invoke-virtual {v2, v1}, Landroid/widget/TextView;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    iget-object v2, p0, Lchat/ola/vn/entry/b/w;->m:Landroid/widget/TextView;

    invoke-virtual {v2, v1}, Landroid/widget/TextView;->setVisibility(I)V

    :goto_1
    :try_start_1
    iget-object v2, p0, Lchat/ola/vn/entry/b/w;->b:Lchat/ola/vn/entry/b;

    iget-object v2, v2, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v2}, Lchat/ola/vn/entity/g;->s()Lchat/ola/vn/entity/d;

    move-result-object v2

    iget-object v3, p0, Lchat/ola/vn/entry/b/w;->b:Lchat/ola/vn/entry/b;

    invoke-virtual {v3}, Lchat/ola/vn/entry/b;->b()Ljava/lang/CharSequence;

    move-result-object v3

    invoke-interface {v3}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v3

    if-eqz v2, :cond_3

    invoke-virtual {v2}, Lchat/ola/vn/entity/d;->d()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_3

    invoke-virtual {v2}, Lchat/ola/vn/entity/d;->d()Ljava/lang/String;

    move-result-object v3

    :cond_3
    iget-object v2, p0, Lchat/ola/vn/entry/b/w;->l:Landroid/widget/TextView;

    invoke-virtual {v2, v0}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/w;->l:Landroid/widget/TextView;

    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    return-void

    :catch_1
    iget-object v0, p0, Lchat/ola/vn/entry/b/w;->l:Landroid/widget/TextView;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    return-void
.end method

.method private i()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/entry/b/w;->o:Lcom/mg/ola/common/widget/CommpressTextView;

    iget-object v1, p0, Lchat/ola/vn/entry/b/w;->b:Lchat/ola/vn/entry/b;

    iget-object v1, v1, Lchat/ola/vn/entry/b;->c:Ljava/lang/CharSequence;

    invoke-virtual {v0, v1}, Lcom/mg/ola/common/widget/CommpressTextView;->setFullText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/w;->o:Lcom/mg/ola/common/widget/CommpressTextView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/mg/ola/common/widget/CommpressTextView;->setOnEclipesizeListener(Lcom/mg/ola/common/widget/CommpressTextView$a;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/w;->b:Lchat/ola/vn/entry/b;

    invoke-virtual {v0}, Lchat/ola/vn/entry/b;->e()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/entry/b/w;->o:Lcom/mg/ola/common/widget/CommpressTextView;

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/CommpressTextView;->a()V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/w;->o:Lcom/mg/ola/common/widget/CommpressTextView;

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/CommpressTextView;->b()V

    :goto_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/w;->o:Lcom/mg/ola/common/widget/CommpressTextView;

    new-instance v1, Lchat/ola/vn/entry/b/w$2;

    invoke-direct {v1, p0}, Lchat/ola/vn/entry/b/w$2;-><init>(Lchat/ola/vn/entry/b/w;)V

    invoke-virtual {v0, v1}, Lcom/mg/ola/common/widget/CommpressTextView;->setOnEclipesizeListener(Lcom/mg/ola/common/widget/CommpressTextView$a;)V

    return-void
.end method

.method private j()V
    .locals 7

    iget-object v0, p0, Lchat/ola/vn/entry/b/w;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->E()[Ljava/lang/String;

    move-result-object v0

    const/16 v1, 0x8

    if-eqz v0, :cond_0

    array-length v2, v0

    if-lez v2, :cond_0

    iget-object v2, p0, Lchat/ola/vn/entry/b/w;->A:Landroid/widget/LinearLayout;

    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Landroid/widget/LinearLayout;->setVisibility(I)V

    array-length v2, v0

    const/4 v4, 0x1

    packed-switch v2, :pswitch_data_0

    iget-object v1, p0, Lchat/ola/vn/entry/b/w;->A:Landroid/widget/LinearLayout;

    invoke-virtual {v1, v3}, Landroid/widget/LinearLayout;->setVisibility(I)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/w;->B:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v1, v3}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v1

    aget-object v2, v0, v3

    iget-object v5, p0, Lchat/ola/vn/entry/b/w;->B:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v1, v2, v5}, Lchat/ola/vn/c/t;->f(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/w;->C:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v1, v3}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v1

    aget-object v2, v0, v4

    iget-object v4, p0, Lchat/ola/vn/entry/b/w;->C:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v1, v2, v4}, Lchat/ola/vn/c/t;->f(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/w;->D:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v1, v3}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v1

    const/4 v2, 0x2

    aget-object v0, v0, v2

    iget-object v2, p0, Lchat/ola/vn/entry/b/w;->D:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v1, v0, v2}, Lchat/ola/vn/c/t;->f(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V

    return-void

    :pswitch_0
    iget-object v2, p0, Lchat/ola/vn/entry/b/w;->A:Landroid/widget/LinearLayout;

    invoke-virtual {v2, v3}, Landroid/widget/LinearLayout;->setVisibility(I)V

    iget-object v2, p0, Lchat/ola/vn/entry/b/w;->B:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v2, v3}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v2

    aget-object v5, v0, v3

    iget-object v6, p0, Lchat/ola/vn/entry/b/w;->B:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v2, v5, v6}, Lchat/ola/vn/c/t;->f(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V

    iget-object v2, p0, Lchat/ola/vn/entry/b/w;->C:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v2, v3}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v2

    aget-object v0, v0, v4

    iget-object v3, p0, Lchat/ola/vn/entry/b/w;->C:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v2, v0, v3}, Lchat/ola/vn/c/t;->f(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V

    goto :goto_0

    :pswitch_1
    iget-object v2, p0, Lchat/ola/vn/entry/b/w;->A:Landroid/widget/LinearLayout;

    invoke-virtual {v2, v3}, Landroid/widget/LinearLayout;->setVisibility(I)V

    iget-object v2, p0, Lchat/ola/vn/entry/b/w;->B:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v2, v3}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v2

    aget-object v0, v0, v3

    iget-object v3, p0, Lchat/ola/vn/entry/b/w;->B:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v2, v0, v3}, Lchat/ola/vn/c/t;->f(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/w;->C:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    :goto_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/w;->D:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    return-void

    :pswitch_2
    iget-object v0, p0, Lchat/ola/vn/entry/b/w;->A:Landroid/widget/LinearLayout;

    const/4 v1, 0x4

    goto :goto_1

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/w;->A:Landroid/widget/LinearLayout;

    :goto_1
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setVisibility(I)V

    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method


# virtual methods
.method public a()V
    .locals 3
    .annotation build Landroid/annotation/TargetApi;
        value = 0xb
    .end annotation

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/w;->b:Lchat/ola/vn/entry/b;

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/w;->a:Landroid/view/View$OnClickListener;

    const/16 v1, 0x8

    if-eqz v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/entry/b/w;->j:Landroid/view/View;

    iget-object v2, p0, Lchat/ola/vn/entry/b/w;->b:Lchat/ola/vn/entry/b;

    invoke-virtual {v0, v2}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/w;->j:Landroid/view/View;

    iget-object v2, p0, Lchat/ola/vn/entry/b/w;->a:Landroid/view/View$OnClickListener;

    invoke-virtual {v0, v2}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/w;->l:Landroid/widget/TextView;

    iget-object v2, p0, Lchat/ola/vn/entry/b/w;->b:Lchat/ola/vn/entry/b;

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setTag(Ljava/lang/Object;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/w;->l:Landroid/widget/TextView;

    iget-object v2, p0, Lchat/ola/vn/entry/b/w;->a:Landroid/view/View$OnClickListener;

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/w;->m:Landroid/widget/TextView;

    iget-object v2, p0, Lchat/ola/vn/entry/b/w;->b:Lchat/ola/vn/entry/b;

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setTag(Ljava/lang/Object;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/w;->m:Landroid/widget/TextView;

    iget-object v2, p0, Lchat/ola/vn/entry/b/w;->a:Landroid/view/View$OnClickListener;

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/w;->q:Landroid/view/View;

    iget-object v2, p0, Lchat/ola/vn/entry/b/w;->b:Lchat/ola/vn/entry/b;

    invoke-virtual {v0, v2}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/w;->q:Landroid/view/View;

    iget-object v2, p0, Lchat/ola/vn/entry/b/w;->a:Landroid/view/View$OnClickListener;

    invoke-virtual {v0, v2}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/w;->r:Landroid/view/View;

    iget-object v2, p0, Lchat/ola/vn/entry/b/w;->b:Lchat/ola/vn/entry/b;

    invoke-virtual {v0, v2}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/w;->r:Landroid/view/View;

    iget-object v2, p0, Lchat/ola/vn/entry/b/w;->a:Landroid/view/View$OnClickListener;

    invoke-virtual {v0, v2}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/w;->u:Landroid/view/View;

    iget-object v2, p0, Lchat/ola/vn/entry/b/w;->b:Lchat/ola/vn/entry/b;

    invoke-virtual {v0, v2}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/w;->u:Landroid/view/View;

    iget-object v2, p0, Lchat/ola/vn/entry/b/w;->a:Landroid/view/View$OnClickListener;

    invoke-virtual {v0, v2}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/w;->x:Landroid/view/View;

    iget-object v2, p0, Lchat/ola/vn/entry/b/w;->b:Lchat/ola/vn/entry/b;

    invoke-virtual {v0, v2}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/w;->x:Landroid/view/View;

    iget-object v2, p0, Lchat/ola/vn/entry/b/w;->a:Landroid/view/View$OnClickListener;

    invoke-virtual {v0, v2}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/w;->A:Landroid/widget/LinearLayout;

    iget-object v2, p0, Lchat/ola/vn/entry/b/w;->b:Lchat/ola/vn/entry/b;

    invoke-virtual {v0, v2}, Landroid/widget/LinearLayout;->setTag(Ljava/lang/Object;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/w;->A:Landroid/widget/LinearLayout;

    iget-object v2, p0, Lchat/ola/vn/entry/b/w;->a:Landroid/view/View$OnClickListener;

    invoke-virtual {v0, v2}, Landroid/widget/LinearLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    new-instance v0, Lchat/ola/vn/entry/b/w$1;

    invoke-direct {v0, p0}, Lchat/ola/vn/entry/b/w$1;-><init>(Lchat/ola/vn/entry/b/w;)V

    iget-object v2, p0, Lchat/ola/vn/entry/b/w;->i:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v2, v0}, Lchat/ola/vn/view/OlaCachedImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v2, p0, Lchat/ola/vn/entry/b/w;->p:Landroid/view/View;

    invoke-virtual {v2, v0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    sget-short v0, Lchat/ola/vn/h;->H:S

    if-lez v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/entry/b/w;->p:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/entry/b/w;->p:Landroid/view/View;

    const/4 v2, 0x0

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    :cond_2
    :goto_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/w;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->i:Ljava/util/List;

    if-eqz v0, :cond_4

    iget-object v0, p0, Lchat/ola/vn/entry/b/w;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->i:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-nez v0, :cond_3

    goto :goto_1

    :cond_3
    invoke-direct {p0}, Lchat/ola/vn/entry/b/w;->e()V

    goto :goto_2

    :cond_4
    :goto_1
    iget-object v0, p0, Lchat/ola/vn/entry/b/w;->i:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    :goto_2
    invoke-direct {p0}, Lchat/ola/vn/entry/b/w;->g()V

    invoke-direct {p0}, Lchat/ola/vn/entry/b/w;->h()V

    invoke-direct {p0}, Lchat/ola/vn/entry/b/w;->i()V

    invoke-direct {p0}, Lchat/ola/vn/entry/b/w;->f()V

    invoke-direct {p0}, Lchat/ola/vn/entry/b/w;->j()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(Landroid/view/View;)V
    .locals 2

    invoke-super {p0, p1}, Lchat/ola/vn/entry/b/j;->a(Landroid/view/View;)V

    const/4 v0, 0x1

    invoke-virtual {p1, v0}, Landroid/view/View;->setClickable(Z)V

    const v0, 0x7f0904eb

    :try_start_0
    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/entry/b/w;->j:Landroid/view/View;

    const v0, 0x7f0904ea

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/entry/b/w;->k:Landroid/widget/TextView;

    const v0, 0x7f090045

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object v0, p0, Lchat/ola/vn/entry/b/w;->i:Lchat/ola/vn/view/OlaCachedImageView;

    const v0, 0x7f090047

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/entry/b/w;->l:Landroid/widget/TextView;

    const v0, 0x7f090056

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/entry/b/w;->m:Landroid/widget/TextView;

    const v0, 0x7f090046

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/entry/b/w;->n:Landroid/widget/TextView;

    const v0, 0x7f090055

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lcom/mg/ola/common/widget/CommpressTextView;

    iput-object v0, p0, Lchat/ola/vn/entry/b/w;->o:Lcom/mg/ola/common/widget/CommpressTextView;

    iget-object v0, p0, Lchat/ola/vn/entry/b/w;->o:Lcom/mg/ola/common/widget/CommpressTextView;

    const v1, 0x7f0f06a1

    invoke-static {v1}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mg/ola/common/widget/CommpressTextView;->setMoreText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/w;->o:Lcom/mg/ola/common/widget/CommpressTextView;

    const/16 v1, 0x10

    invoke-virtual {v0, v1}, Lcom/mg/ola/common/widget/CommpressTextView;->setEclipesizeMaxLine(I)V

    const v0, 0x7f0900a5

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/entry/b/w;->p:Landroid/view/View;

    const v0, 0x7f090041

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/entry/b/w;->q:Landroid/view/View;

    const v0, 0x7f09003b

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/entry/b/w;->r:Landroid/view/View;

    const v0, 0x7f090042

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/entry/b/w;->s:Landroid/widget/TextView;

    const v0, 0x7f09003e

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    iput-object v0, p0, Lchat/ola/vn/entry/b/w;->t:Landroid/widget/ImageView;

    const v0, 0x7f09003c

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/entry/b/w;->u:Landroid/view/View;

    const v0, 0x7f090043

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/entry/b/w;->v:Landroid/widget/TextView;

    const v0, 0x7f09003f

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    iput-object v0, p0, Lchat/ola/vn/entry/b/w;->w:Landroid/widget/ImageView;

    const v0, 0x7f09003d

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/entry/b/w;->x:Landroid/view/View;

    const v0, 0x7f090044

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/entry/b/w;->y:Landroid/widget/TextView;

    const v0, 0x7f090040

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    iput-object v0, p0, Lchat/ola/vn/entry/b/w;->z:Landroid/widget/ImageView;

    iget-object v0, p0, Lchat/ola/vn/entry/b/w;->i:Lchat/ola/vn/view/OlaCachedImageView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1, v1}, Lchat/ola/vn/view/OlaCachedImageView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    const v0, 0x7f0900a6

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    iput-object v0, p0, Lchat/ola/vn/entry/b/w;->A:Landroid/widget/LinearLayout;

    const v0, 0x7f09028f

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object v0, p0, Lchat/ola/vn/entry/b/w;->B:Lchat/ola/vn/view/OlaCachedImageView;

    const v0, 0x7f090290

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object v0, p0, Lchat/ola/vn/entry/b/w;->C:Lchat/ola/vn/view/OlaCachedImageView;

    const v0, 0x7f090291

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object p1, p0, Lchat/ola/vn/entry/b/w;->D:Lchat/ola/vn/view/OlaCachedImageView;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(Z)V
    .locals 0

    invoke-super {p0, p1}, Lchat/ola/vn/entry/b/j;->a(Z)V

    return-void
.end method
