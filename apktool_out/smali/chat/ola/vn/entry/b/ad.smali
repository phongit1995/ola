.class public Lchat/ola/vn/entry/b/ad;
.super Lchat/ola/vn/entry/b/f;


# instance fields
.field protected t:I

.field protected u:I

.field protected v:I

.field private w:Landroid/widget/TextView;

.field private x:Landroid/view/View;

.field private y:[Lchat/ola/vn/view/OlaCachedImageView;


# direct methods
.method public constructor <init>(Landroid/view/View;I)V
    .locals 4

    invoke-direct {p0, p1}, Lchat/ola/vn/entry/b/f;-><init>(Landroid/view/View;)V

    sget v0, Lchat/ola/vn/e;->c:I

    const/4 v1, 0x3

    div-int/2addr v0, v1

    iput v0, p0, Lchat/ola/vn/entry/b/ad;->t:I

    sget v0, Lchat/ola/vn/e;->c:I

    const/4 v2, 0x2

    mul-int/lit8 v0, v0, 0x2

    div-int/2addr v0, v1

    iput v0, p0, Lchat/ola/vn/entry/b/ad;->u:I

    sget v0, Lchat/ola/vn/e;->c:I

    iput v0, p0, Lchat/ola/vn/entry/b/ad;->v:I

    iget-object v0, p0, Lchat/ola/vn/entry/b/ad;->q:Landroid/view/ViewStub;

    invoke-virtual {v0, p2}, Landroid/view/ViewStub;->setLayoutResource(I)V

    iget-object p2, p0, Lchat/ola/vn/entry/b/ad;->q:Landroid/view/ViewStub;

    invoke-virtual {p2}, Landroid/view/ViewStub;->inflate()Landroid/view/View;

    iget-object p2, p0, Lchat/ola/vn/entry/b/ad;->q:Landroid/view/ViewStub;

    const/4 v0, 0x0

    invoke-virtual {p2, v0}, Landroid/view/ViewStub;->setVisibility(I)V

    const/4 p2, 0x5

    new-array p2, p2, [Lchat/ola/vn/view/OlaCachedImageView;

    iput-object p2, p0, Lchat/ola/vn/entry/b/ad;->y:[Lchat/ola/vn/view/OlaCachedImageView;

    :try_start_0
    iget-object p2, p0, Lchat/ola/vn/entry/b/ad;->y:[Lchat/ola/vn/view/OlaCachedImageView;

    const v3, 0x7f090348

    invoke-virtual {p1, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Lchat/ola/vn/view/OlaCachedImageView;

    aput-object v3, p2, v0

    iget-object p2, p0, Lchat/ola/vn/entry/b/ad;->y:[Lchat/ola/vn/view/OlaCachedImageView;

    const/4 v0, 0x1

    const v3, 0x7f090349

    invoke-virtual {p1, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Lchat/ola/vn/view/OlaCachedImageView;

    aput-object v3, p2, v0

    iget-object p2, p0, Lchat/ola/vn/entry/b/ad;->y:[Lchat/ola/vn/view/OlaCachedImageView;

    const v0, 0x7f09034a

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaCachedImageView;

    aput-object v0, p2, v2

    iget-object p2, p0, Lchat/ola/vn/entry/b/ad;->y:[Lchat/ola/vn/view/OlaCachedImageView;

    const v0, 0x7f09034b

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaCachedImageView;

    aput-object v0, p2, v1

    iget-object p2, p0, Lchat/ola/vn/entry/b/ad;->y:[Lchat/ola/vn/view/OlaCachedImageView;

    const/4 v0, 0x4

    const v1, 0x7f09034c

    invoke-virtual {p1, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/view/OlaCachedImageView;

    aput-object v1, p2, v0

    const p2, 0x7f090361

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, p0, Lchat/ola/vn/entry/b/ad;->w:Landroid/widget/TextView;

    const p2, 0x7f0904c4

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/entry/b/ad;->x:Landroid/view/View;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :try_start_1
    iget-object p1, p0, Lchat/ola/vn/entry/b/ad;->d:Landroid/view/View;

    invoke-virtual {p1}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object p1

    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p1

    const p2, 0x7f07013c

    invoke-virtual {p1, p2}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result p1

    iput p1, p0, Lchat/ola/vn/entry/b/ad;->e:I
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/message/d;Lchat/ola/vn/message/d;Lchat/ola/vn/message/d;)V
    .locals 0

    :try_start_0
    invoke-super {p0, p1, p2, p3}, Lchat/ola/vn/entry/b/f;->a(Lchat/ola/vn/message/d;Lchat/ola/vn/message/d;Lchat/ola/vn/message/d;)V

    check-cast p1, Lchat/ola/vn/message/p;

    invoke-virtual {p0, p1}, Lchat/ola/vn/entry/b/ad;->a(Lchat/ola/vn/message/p;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public a(Lchat/ola/vn/message/p;)V
    .locals 13

    if-nez p1, :cond_0

    return-void

    :cond_0
    const/4 v0, 0x0

    const/4 v1, 0x0

    :goto_0
    const/16 v2, 0x8

    :try_start_0
    iget-object v3, p0, Lchat/ola/vn/entry/b/ad;->y:[Lchat/ola/vn/view/OlaCachedImageView;

    array-length v3, v3

    if-ge v1, v3, :cond_2

    iget-object v3, p0, Lchat/ola/vn/entry/b/ad;->y:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v3, v3, v1

    if-eqz v3, :cond_1

    iget-object v3, p0, Lchat/ola/vn/entry/b/ad;->y:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v3, v3, v1

    invoke-virtual {v3, v2}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    iget-object v3, p0, Lchat/ola/vn/entry/b/ad;->y:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v3, v3, v1

    invoke-virtual {v3, p1}, Lchat/ola/vn/view/OlaCachedImageView;->setTag(Ljava/lang/Object;)V

    iget-object v3, p0, Lchat/ola/vn/entry/b/ad;->y:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v3, v3, v1

    invoke-static {}, Lchat/ola/vn/q/a;->a()Lchat/ola/vn/q/a;

    move-result-object v4

    invoke-virtual {v3, v4}, Lchat/ola/vn/view/OlaCachedImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v3, p0, Lchat/ola/vn/entry/b/ad;->b:Landroid/view/View$OnLongClickListener;

    if-eqz v3, :cond_1

    iget-object v3, p0, Lchat/ola/vn/entry/b/ad;->y:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v3, v3, v1

    iget-object v4, p0, Lchat/ola/vn/entry/b/ad;->b:Landroid/view/View$OnLongClickListener;

    invoke-virtual {v3, v4}, Lchat/ola/vn/view/OlaCachedImageView;->setOnLongClickListener(Landroid/view/View$OnLongClickListener;)V

    :cond_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_2
    iget-object v1, p0, Lchat/ola/vn/entry/b/ad;->x:Landroid/view/View;

    invoke-virtual {v1, v2}, Landroid/view/View;->setVisibility(I)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/ad;->w:Landroid/widget/TextView;

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setVisibility(I)V

    invoke-virtual {p1}, Lchat/ola/vn/message/p;->a()Ljava/util/List;

    move-result-object p1

    if-eqz p1, :cond_12

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v1

    if-lez v1, :cond_12

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v1

    const/4 v3, 0x5

    if-le v1, v3, :cond_4

    iget-object v4, p0, Lchat/ola/vn/entry/b/ad;->x:Landroid/view/View;

    if-eqz v4, :cond_3

    iget-object v4, p0, Lchat/ola/vn/entry/b/ad;->x:Landroid/view/View;

    invoke-virtual {v4, v0}, Landroid/view/View;->setVisibility(I)V

    :cond_3
    iget-object v4, p0, Lchat/ola/vn/entry/b/ad;->w:Landroid/widget/TextView;

    invoke-virtual {v4, v0}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v4, p0, Lchat/ola/vn/entry/b/ad;->w:Landroid/widget/TextView;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "+"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    add-int/lit8 v6, v1, -0x5

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_1

    :cond_4
    if-ne v1, v3, :cond_5

    iget-object v4, p0, Lchat/ola/vn/entry/b/ad;->x:Landroid/view/View;

    if-eqz v4, :cond_6

    iget-object v4, p0, Lchat/ola/vn/entry/b/ad;->x:Landroid/view/View;

    invoke-virtual {v4, v0}, Landroid/view/View;->setVisibility(I)V

    goto :goto_1

    :cond_5
    iget-object v4, p0, Lchat/ola/vn/entry/b/ad;->w:Landroid/widget/TextView;

    invoke-virtual {v4, v2}, Landroid/widget/TextView;->setVisibility(I)V

    :cond_6
    :goto_1
    const/4 v4, 0x0

    :goto_2
    iget-object v5, p0, Lchat/ola/vn/entry/b/ad;->y:[Lchat/ola/vn/view/OlaCachedImageView;

    array-length v5, v5

    if-ge v4, v5, :cond_12

    if-ge v4, v1, :cond_12

    invoke-interface {p1, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lchat/ola/vn/entity/ab;

    iget-object v6, v5, Lchat/ola/vn/entity/ab;->c:Ljava/lang/String;

    iget-object v7, p0, Lchat/ola/vn/entry/b/ad;->y:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v7, v7, v4

    if-eqz v7, :cond_10

    iget-object v7, p0, Lchat/ola/vn/entry/b/ad;->y:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v7, v7, v4

    invoke-virtual {v7, v0}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    iget-byte v5, v5, Lchat/ola/vn/entity/ab;->b:B

    const/4 v7, 0x2

    const-wide/high16 v8, 0x3ff0000000000000L    # 1.0

    const/4 v10, 0x1

    if-nez v5, :cond_f

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v5

    iget-object v11, p0, Lchat/ola/vn/entry/b/ad;->y:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v11, v11, v4

    iget v12, p0, Lchat/ola/vn/entry/b/ad;->u:I

    invoke-virtual {v5, v6, v11, v12}, Lchat/ola/vn/c/t;->b(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;I)V

    if-eq v1, v3, :cond_c

    packed-switch v1, :pswitch_data_0

    if-nez v4, :cond_7

    iget-object v5, p0, Lchat/ola/vn/entry/b/ad;->y:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v5, v5, v0

    check-cast v5, Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v5, v8, v9}, Lchat/ola/vn/view/OlaRatioImageView;->setRatio(D)V

    :cond_7
    if-ne v4, v10, :cond_8

    iget-object v5, p0, Lchat/ola/vn/entry/b/ad;->y:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v5, v5, v10

    check-cast v5, Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v5, v8, v9}, Lchat/ola/vn/view/OlaRatioImageView;->setRatio(D)V

    :cond_8
    if-ne v4, v7, :cond_10

    iget-object v5, p0, Lchat/ola/vn/entry/b/ad;->y:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v5, v5, v7

    check-cast v5, Lchat/ola/vn/view/OlaRatioImageView;

    :goto_3
    invoke-virtual {v5, v8, v9}, Lchat/ola/vn/view/OlaRatioImageView;->setRatio(D)V

    goto/16 :goto_4

    :pswitch_0
    if-nez v4, :cond_9

    iget-object v5, p0, Lchat/ola/vn/entry/b/ad;->y:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v5, v5, v0

    check-cast v5, Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v5, v8, v9}, Lchat/ola/vn/view/OlaRatioImageView;->setRatio(D)V

    :cond_9
    if-ne v4, v10, :cond_a

    iget-object v5, p0, Lchat/ola/vn/entry/b/ad;->y:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v5, v5, v10

    check-cast v5, Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v5, v8, v9}, Lchat/ola/vn/view/OlaRatioImageView;->setRatio(D)V

    :cond_a
    if-ne v4, v7, :cond_10

    iget-object v5, p0, Lchat/ola/vn/entry/b/ad;->y:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v5, v5, v7

    check-cast v5, Lchat/ola/vn/view/OlaRatioImageView;

    const-wide v6, 0x3ffc71c71c71c71cL    # 1.7777777777777777

    invoke-virtual {v5, v6, v7}, Lchat/ola/vn/view/OlaRatioImageView;->setRatio(D)V

    goto :goto_4

    :pswitch_1
    const-wide/high16 v5, 0x3fe2000000000000L    # 0.5625

    if-nez v4, :cond_b

    iget-object v7, p0, Lchat/ola/vn/entry/b/ad;->y:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v7, v7, v0

    check-cast v7, Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v7, v5, v6}, Lchat/ola/vn/view/OlaRatioImageView;->setRatio(D)V

    :cond_b
    if-ne v4, v10, :cond_10

    iget-object v7, p0, Lchat/ola/vn/entry/b/ad;->y:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v7, v7, v10

    check-cast v7, Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v7, v5, v6}, Lchat/ola/vn/view/OlaRatioImageView;->setRatio(D)V

    goto :goto_4

    :cond_c
    if-nez v4, :cond_d

    iget-object v5, p0, Lchat/ola/vn/entry/b/ad;->y:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v5, v5, v0

    check-cast v5, Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v5, v8, v9}, Lchat/ola/vn/view/OlaRatioImageView;->setRatio(D)V

    :cond_d
    if-ne v4, v10, :cond_e

    iget-object v5, p0, Lchat/ola/vn/entry/b/ad;->y:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v5, v5, v10

    check-cast v5, Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v5, v8, v9}, Lchat/ola/vn/view/OlaRatioImageView;->setRatio(D)V

    :cond_e
    if-ne v4, v7, :cond_10

    iget-object v5, p0, Lchat/ola/vn/entry/b/ad;->y:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v5, v5, v7

    check-cast v5, Lchat/ola/vn/view/OlaRatioImageView;

    goto :goto_3

    :cond_f
    iget-object v5, p0, Lchat/ola/vn/entry/b/ad;->y:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v5, v5, v0

    check-cast v5, Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v5, v8, v9}, Lchat/ola/vn/view/OlaRatioImageView;->setRatio(D)V

    iget-object v5, p0, Lchat/ola/vn/entry/b/ad;->y:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v5, v5, v10

    check-cast v5, Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v5, v8, v9}, Lchat/ola/vn/view/OlaRatioImageView;->setRatio(D)V

    iget-object v5, p0, Lchat/ola/vn/entry/b/ad;->y:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v5, v5, v7

    check-cast v5, Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v5, v8, v9}, Lchat/ola/vn/view/OlaRatioImageView;->setRatio(D)V

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v5

    iget-object v7, p0, Lchat/ola/vn/entry/b/ad;->y:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v7, v7, v4

    invoke-virtual {v5, v6, v7}, Lchat/ola/vn/c/t;->e(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :cond_10
    :goto_4
    :pswitch_2
    add-int/lit8 v4, v4, 0x1

    goto/16 :goto_2

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :try_start_1
    iget-object p1, p0, Lchat/ola/vn/entry/b/ad;->y:[Lchat/ola/vn/view/OlaCachedImageView;

    if-eqz p1, :cond_12

    :goto_5
    iget-object p1, p0, Lchat/ola/vn/entry/b/ad;->y:[Lchat/ola/vn/view/OlaCachedImageView;

    array-length p1, p1

    if-ge v0, p1, :cond_12

    iget-object p1, p0, Lchat/ola/vn/entry/b/ad;->y:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object p1, p1, v0

    if-eqz p1, :cond_11

    iget-object p1, p0, Lchat/ola/vn/entry/b/ad;->y:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object p1, p1, v0

    invoke-virtual {p1, v2}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :cond_11
    add-int/lit8 v0, v0, 0x1

    goto :goto_5

    :catch_1
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_12
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
