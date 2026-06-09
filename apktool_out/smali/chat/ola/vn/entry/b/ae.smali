.class public Lchat/ola/vn/entry/b/ae;
.super Lchat/ola/vn/entry/b/f;

# interfaces
.implements Landroid/view/View$OnClickListener;


# instance fields
.field private t:Landroid/widget/ImageView;

.field private u:Landroid/widget/TextView;

.field private v:Landroid/widget/TextView;

.field private w:Landroid/widget/TextView;

.field private x:Landroid/widget/TextView;

.field private y:Landroid/view/View;

.field private z:Lchat/ola/vn/message/q;


# direct methods
.method public constructor <init>(Landroid/view/View;I)V
    .locals 1

    invoke-direct {p0, p1}, Lchat/ola/vn/entry/b/f;-><init>(Landroid/view/View;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ae;->q:Landroid/view/ViewStub;

    invoke-virtual {v0, p2}, Landroid/view/ViewStub;->setLayoutResource(I)V

    iget-object p2, p0, Lchat/ola/vn/entry/b/ae;->q:Landroid/view/ViewStub;

    invoke-virtual {p2}, Landroid/view/ViewStub;->inflate()Landroid/view/View;

    iget-object p2, p0, Lchat/ola/vn/entry/b/ae;->q:Landroid/view/ViewStub;

    const/4 v0, 0x0

    invoke-virtual {p2, v0}, Landroid/view/ViewStub;->setVisibility(I)V

    const p2, 0x7f0905ef

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/ImageView;

    iput-object p2, p0, Lchat/ola/vn/entry/b/ae;->t:Landroid/widget/ImageView;

    const p2, 0x7f0905f7

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, p0, Lchat/ola/vn/entry/b/ae;->u:Landroid/widget/TextView;

    const p2, 0x7f0905ee

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, p0, Lchat/ola/vn/entry/b/ae;->v:Landroid/widget/TextView;

    const p2, 0x7f0902c2

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, p0, Lchat/ola/vn/entry/b/ae;->w:Landroid/widget/TextView;

    const p2, 0x7f090497

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, p0, Lchat/ola/vn/entry/b/ae;->x:Landroid/widget/TextView;

    const p2, 0x7f09041d

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    iput-object p2, p0, Lchat/ola/vn/entry/b/ae;->y:Landroid/view/View;

    const p2, 0x7f090374

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    invoke-virtual {p2, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p2, 0x7f090399

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/entry/b/ae;->i:Lcom/mg/ola/common/widget/OlaTextView;

    const/16 p2, 0x8

    invoke-virtual {p1, p2}, Lcom/mg/ola/common/widget/OlaTextView;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic a(Lchat/ola/vn/entry/b/ae;)Lchat/ola/vn/message/q;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/entry/b/ae;->z:Lchat/ola/vn/message/q;

    return-object p0
.end method

.method static synthetic b(Lchat/ola/vn/entry/b/ae;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/entry/b/ae;->h()V

    return-void
.end method

.method private g()V
    .locals 8

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/ae;->z:Lchat/ola/vn/message/q;

    invoke-virtual {v0}, Lchat/ola/vn/message/q;->a()Lchat/ola/vn/entity/ah;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/entry/b/ae;->t:Landroid/widget/ImageView;

    invoke-static {}, Lchat/ola/vn/j;->a()Lchat/ola/vn/j;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/entry/b/ae;->z:Lchat/ola/vn/message/q;

    invoke-virtual {v2}, Lchat/ola/vn/message/q;->a()Lchat/ola/vn/entity/ah;

    move-result-object v2

    invoke-virtual {v2}, Lchat/ola/vn/entity/ah;->b()I

    move-result v2

    invoke-virtual {v1, v2}, Lchat/ola/vn/j;->a(I)Landroid/graphics/Bitmap;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageBitmap(Landroid/graphics/Bitmap;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ae;->u:Landroid/widget/TextView;

    iget-object v1, p0, Lchat/ola/vn/entry/b/ae;->z:Lchat/ola/vn/message/q;

    invoke-virtual {v1}, Lchat/ola/vn/message/q;->a()Lchat/ola/vn/entity/ah;

    move-result-object v1

    invoke-virtual {v1}, Lchat/ola/vn/entity/ah;->d()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/ae;->z:Lchat/ola/vn/message/q;

    invoke-virtual {v0}, Lchat/ola/vn/message/q;->D()I

    move-result v0

    const/4 v1, 0x1

    if-le v0, v1, :cond_1

    iget-object v0, p0, Lchat/ola/vn/entry/b/ae;->v:Landroid/widget/TextView;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v3, p0, Lchat/ola/vn/entry/b/ae;->z:Lchat/ola/vn/message/q;

    invoke-virtual {v3}, Lchat/ola/vn/message/q;->D()I

    move-result v3

    int-to-long v3, v3

    invoke-static {v3, v4}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v3, " "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v3, 0x7f0f04a4

    invoke-static {v3}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v3

    sget-object v4, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v3, v4}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    :goto_0
    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_1

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/entry/b/ae;->v:Landroid/widget/TextView;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v3, p0, Lchat/ola/vn/entry/b/ae;->z:Lchat/ola/vn/message/q;

    invoke-virtual {v3}, Lchat/ola/vn/message/q;->D()I

    move-result v3

    int-to-long v3, v3

    invoke-static {v3, v4}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v3, " "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v3, 0x7f0f04a3

    invoke-static {v3}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v3

    sget-object v4, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v3, v4}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    goto :goto_0

    :goto_1
    iget-object v0, p0, Lchat/ola/vn/entry/b/ae;->w:Landroid/widget/TextView;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v3, p0, Lchat/ola/vn/entry/b/ae;->z:Lchat/ola/vn/message/q;

    invoke-virtual {v3}, Lchat/ola/vn/message/q;->C()J

    move-result-wide v3

    invoke-static {v3, v4}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v3, " KEN"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    iget-object v0, p0, Lchat/ola/vn/entry/b/ae;->z:Lchat/ola/vn/message/q;

    invoke-virtual {v0}, Lchat/ola/vn/message/q;->m()J

    move-result-wide v4

    const/4 v0, 0x0

    sub-long v6, v2, v4

    const-wide/32 v2, 0x493e0

    cmp-long v0, v6, v2

    const/4 v2, 0x0

    const/16 v3, 0x8

    if-ltz v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/entry/b/ae;->z:Lchat/ola/vn/message/q;

    invoke-virtual {v0}, Lchat/ola/vn/message/q;->E()B

    move-result v0

    if-ne v0, v1, :cond_2

    iget-object v0, p0, Lchat/ola/vn/entry/b/ae;->y:Landroid/view/View;

    invoke-virtual {v0, v3}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ae;->z:Lchat/ola/vn/message/q;

    invoke-virtual {v0, v2}, Lchat/ola/vn/message/q;->c(B)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ae;->x:Landroid/widget/TextView;

    sget v1, Lchat/ola/vn/f;->k:I

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ae;->x:Landroid/widget/TextView;

    const v1, 0x7f0f0371

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    return-void

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/entry/b/ae;->z:Lchat/ola/vn/message/q;

    invoke-virtual {v0}, Lchat/ola/vn/message/q;->E()B

    move-result v0

    packed-switch v0, :pswitch_data_0

    return-void

    :pswitch_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/ae;->y:Landroid/view/View;

    invoke-virtual {v0, v3}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ae;->x:Landroid/widget/TextView;

    sget v1, Lchat/ola/vn/f;->L:I

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ae;->x:Landroid/widget/TextView;

    const v1, 0x7f0f0654

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    return-void

    :pswitch_1
    iget-object v0, p0, Lchat/ola/vn/entry/b/ae;->y:Landroid/view/View;

    invoke-virtual {v0, v3}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ae;->x:Landroid/widget/TextView;

    sget v1, Lchat/ola/vn/f;->z:I

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ae;->x:Landroid/widget/TextView;

    const v1, 0x7f0f04b6

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    return-void

    :pswitch_2
    iget-object v0, p0, Lchat/ola/vn/entry/b/ae;->y:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ae;->x:Landroid/widget/TextView;

    sget v1, Lchat/ola/vn/f;->y:I

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ae;->x:Landroid/widget/TextView;

    const v1, 0x7f0f03aa

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    return-void

    :pswitch_3
    iget-object v0, p0, Lchat/ola/vn/entry/b/ae;->y:Landroid/view/View;

    invoke-virtual {v0, v3}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ae;->x:Landroid/widget/TextView;

    sget v1, Lchat/ola/vn/f;->k:I

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ae;->z:Lchat/ola/vn/message/q;

    invoke-virtual {v0}, Lchat/ola/vn/message/q;->F()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    const v1, 0x7f0f0248

    if-nez v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/entry/b/ae;->x:Landroid/widget/TextView;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {v1}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, ": "

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lchat/ola/vn/entry/b/ae;->z:Lchat/ola/vn/message/q;

    invoke-virtual {v1}, Lchat/ola/vn/message/q;->F()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_3
    iget-object v0, p0, Lchat/ola/vn/entry/b/ae;->x:Landroid/widget/TextView;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private h()V
    .locals 4

    iget-object v0, p0, Lchat/ola/vn/entry/b/ae;->z:Lchat/ola/vn/message/q;

    const/4 v1, 0x3

    invoke-virtual {v0, v1}, Lchat/ola/vn/message/q;->c(B)V

    invoke-direct {p0}, Lchat/ola/vn/entry/b/ae;->g()V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ae;->z:Lchat/ola/vn/message/q;

    invoke-virtual {v0}, Lchat/ola/vn/message/q;->j()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/entry/b/ae;->z:Lchat/ola/vn/message/q;

    invoke-virtual {v1}, Lchat/ola/vn/message/q;->G()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_0

    sget-object v2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    new-instance v3, Lchat/ola/vn/entry/b/ae$2;

    invoke-direct {v3, p0, v0}, Lchat/ola/vn/entry/b/ae$2;-><init>(Lchat/ola/vn/entry/b/ae;Ljava/lang/String;)V

    invoke-static {v3}, Lchat/ola/vn/entry/c/f;->a(Lchat/ola/vn/entry/c/e;)S

    move-result v0

    invoke-virtual {v2, v1, v0}, Lchat/ola/vn/network/OlaNetworkService;->l(Ljava/lang/String;S)V

    return-void

    :cond_0
    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v1, v0}, Lchat/ola/vn/network/OlaNetworkService;->t(Ljava/lang/String;)V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/message/d;Lchat/ola/vn/message/d;Lchat/ola/vn/message/d;)V
    .locals 0

    :try_start_0
    invoke-super {p0, p1, p2, p3}, Lchat/ola/vn/entry/b/f;->a(Lchat/ola/vn/message/d;Lchat/ola/vn/message/d;Lchat/ola/vn/message/d;)V

    check-cast p1, Lchat/ola/vn/message/q;

    iput-object p1, p0, Lchat/ola/vn/entry/b/ae;->z:Lchat/ola/vn/message/q;

    invoke-direct {p0}, Lchat/ola/vn/entry/b/ae;->g()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 9

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const v0, 0x7f090374

    if-eq p1, v0, :cond_2

    const v0, 0x7f090399

    if-eq p1, v0, :cond_0

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/entry/b/ae;->z:Lchat/ola/vn/message/q;

    invoke-virtual {p1}, Lchat/ola/vn/message/q;->C()J

    move-result-wide v0

    const-wide/16 v2, 0x0

    cmp-long p1, v0, v2

    if-lez p1, :cond_1

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v0

    const/4 v1, 0x0

    const/4 v2, 0x0

    const v3, 0x7f0f033a

    const v4, 0x7f0f033a

    const v5, 0x7f0f044d

    const v6, 0x7f0f0585

    const/4 v7, 0x0

    new-instance v8, Lchat/ola/vn/entry/b/ae$1;

    invoke-direct {v8, p0}, Lchat/ola/vn/entry/b/ae$1;-><init>(Lchat/ola/vn/entry/b/ae;)V

    invoke-static/range {v0 .. v8}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;Ljava/lang/String;IIIIILjava/util/List;Landroid/content/DialogInterface$OnClickListener;)Lchat/ola/vn/i/p;

    move-result-object p1

    const/16 v0, 0x2000

    invoke-virtual {p1, v0}, Lchat/ola/vn/i/p;->b(I)V

    return-void

    :cond_1
    invoke-direct {p0}, Lchat/ola/vn/entry/b/ae;->h()V

    return-void

    :cond_2
    iget-object p1, p0, Lchat/ola/vn/entry/b/ae;->z:Lchat/ola/vn/message/q;

    const/4 v0, 0x2

    invoke-virtual {p1, v0}, Lchat/ola/vn/message/q;->c(B)V

    invoke-direct {p0}, Lchat/ola/vn/entry/b/ae;->g()V

    iget-object p1, p0, Lchat/ola/vn/entry/b/ae;->z:Lchat/ola/vn/message/q;

    invoke-virtual {p1}, Lchat/ola/vn/message/q;->j()Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/entry/b/ae;->z:Lchat/ola/vn/message/q;

    invoke-virtual {v0}, Lchat/ola/vn/message/q;->G()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_3

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    const/4 v1, 0x0

    invoke-virtual {p1, v0, v1}, Lchat/ola/vn/network/OlaNetworkService;->k(Ljava/lang/String;S)V

    return-void

    :cond_3
    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0, p1}, Lchat/ola/vn/network/OlaNetworkService;->u(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
