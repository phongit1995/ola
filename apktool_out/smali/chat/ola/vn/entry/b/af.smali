.class public Lchat/ola/vn/entry/b/af;
.super Lchat/ola/vn/entry/b/f;


# instance fields
.field private t:Landroid/widget/ImageView;

.field private u:Landroid/widget/TextView;

.field private v:Landroid/widget/TextView;

.field private w:Landroid/widget/TextView;

.field private x:Landroid/widget/TextView;


# direct methods
.method public constructor <init>(Landroid/view/View;I)V
    .locals 1

    invoke-direct {p0, p1}, Lchat/ola/vn/entry/b/f;-><init>(Landroid/view/View;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/af;->q:Landroid/view/ViewStub;

    invoke-virtual {v0, p2}, Landroid/view/ViewStub;->setLayoutResource(I)V

    iget-object p2, p0, Lchat/ola/vn/entry/b/af;->q:Landroid/view/ViewStub;

    invoke-virtual {p2}, Landroid/view/ViewStub;->inflate()Landroid/view/View;

    iget-object p2, p0, Lchat/ola/vn/entry/b/af;->q:Landroid/view/ViewStub;

    const/4 v0, 0x0

    invoke-virtual {p2, v0}, Landroid/view/ViewStub;->setVisibility(I)V

    const p2, 0x7f0905ef

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/ImageView;

    iput-object p2, p0, Lchat/ola/vn/entry/b/af;->t:Landroid/widget/ImageView;

    const p2, 0x7f0905f7

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, p0, Lchat/ola/vn/entry/b/af;->u:Landroid/widget/TextView;

    const p2, 0x7f0905ee

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, p0, Lchat/ola/vn/entry/b/af;->v:Landroid/widget/TextView;

    const p2, 0x7f0902c2

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, p0, Lchat/ola/vn/entry/b/af;->w:Landroid/widget/TextView;

    const p2, 0x7f090497

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/entry/b/af;->x:Landroid/widget/TextView;

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/entry/b/af;->i:Lcom/mg/ola/common/widget/OlaTextView;

    const/16 p2, 0x8

    invoke-virtual {p1, p2}, Lcom/mg/ola/common/widget/OlaTextView;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/message/d;Lchat/ola/vn/message/d;Lchat/ola/vn/message/d;)V
    .locals 2

    :try_start_0
    invoke-super {p0, p1, p2, p3}, Lchat/ola/vn/entry/b/f;->a(Lchat/ola/vn/message/d;Lchat/ola/vn/message/d;Lchat/ola/vn/message/d;)V

    check-cast p1, Lchat/ola/vn/message/s;

    invoke-virtual {p1}, Lchat/ola/vn/message/s;->a()Lchat/ola/vn/entity/ah;

    move-result-object p2

    if-eqz p2, :cond_0

    iget-object p2, p0, Lchat/ola/vn/entry/b/af;->t:Landroid/widget/ImageView;

    invoke-static {}, Lchat/ola/vn/j;->a()Lchat/ola/vn/j;

    move-result-object p3

    invoke-virtual {p1}, Lchat/ola/vn/message/s;->a()Lchat/ola/vn/entity/ah;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/entity/ah;->b()I

    move-result v0

    invoke-virtual {p3, v0}, Lchat/ola/vn/j;->a(I)Landroid/graphics/Bitmap;

    move-result-object p3

    invoke-virtual {p2, p3}, Landroid/widget/ImageView;->setImageBitmap(Landroid/graphics/Bitmap;)V

    iget-object p2, p0, Lchat/ola/vn/entry/b/af;->u:Landroid/widget/TextView;

    invoke-virtual {p1}, Lchat/ola/vn/message/s;->a()Lchat/ola/vn/entity/ah;

    move-result-object p3

    invoke-virtual {p3}, Lchat/ola/vn/entity/ah;->d()Ljava/lang/String;

    move-result-object p3

    invoke-virtual {p2, p3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :cond_0
    invoke-virtual {p1}, Lchat/ola/vn/message/s;->D()I

    move-result p2

    const/4 p3, 0x1

    if-le p2, p3, :cond_1

    iget-object p2, p0, Lchat/ola/vn/entry/b/af;->v:Landroid/widget/TextView;

    new-instance p3, Ljava/lang/StringBuilder;

    invoke-direct {p3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p1}, Lchat/ola/vn/message/s;->D()I

    move-result v0

    int-to-long v0, v0

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v0, " "

    invoke-virtual {p3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v0, 0x7f0f04a4

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v0

    sget-object v1, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v0, v1}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p3

    :goto_0
    invoke-virtual {p2, p3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_1

    :cond_1
    iget-object p2, p0, Lchat/ola/vn/entry/b/af;->v:Landroid/widget/TextView;

    new-instance p3, Ljava/lang/StringBuilder;

    invoke-direct {p3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p1}, Lchat/ola/vn/message/s;->D()I

    move-result v0

    int-to-long v0, v0

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v0, " "

    invoke-virtual {p3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v0, 0x7f0f04a3

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v0

    sget-object v1, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v0, v1}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p3

    goto :goto_0

    :goto_1
    iget-object p2, p0, Lchat/ola/vn/entry/b/af;->w:Landroid/widget/TextView;

    new-instance p3, Ljava/lang/StringBuilder;

    invoke-direct {p3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p1}, Lchat/ola/vn/message/s;->C()J

    move-result-wide v0

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v0, " KEN"

    invoke-virtual {p3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p3

    invoke-virtual {p2, p3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    invoke-virtual {p1}, Lchat/ola/vn/message/s;->E()B

    move-result p2

    packed-switch p2, :pswitch_data_0

    return-void

    :pswitch_0
    iget-object p1, p0, Lchat/ola/vn/entry/b/af;->x:Landroid/widget/TextView;

    sget p2, Lchat/ola/vn/f;->L:I

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/af;->x:Landroid/widget/TextView;

    const p2, 0x7f0f0654

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setText(I)V

    return-void

    :pswitch_1
    iget-object p1, p0, Lchat/ola/vn/entry/b/af;->x:Landroid/widget/TextView;

    sget p2, Lchat/ola/vn/f;->D:I

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/af;->x:Landroid/widget/TextView;

    const p2, 0x7f0f04b6

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setText(I)V

    return-void

    :pswitch_2
    iget-object p1, p0, Lchat/ola/vn/entry/b/af;->x:Landroid/widget/TextView;

    sget p2, Lchat/ola/vn/f;->C:I

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/af;->x:Landroid/widget/TextView;

    const p2, 0x7f0f03aa

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setText(I)V

    return-void

    :pswitch_3
    iget-object p2, p0, Lchat/ola/vn/entry/b/af;->x:Landroid/widget/TextView;

    sget p3, Lchat/ola/vn/f;->k:I

    invoke-virtual {p2, p3}, Landroid/widget/TextView;->setTextColor(I)V

    invoke-virtual {p1}, Lchat/ola/vn/message/s;->F()Ljava/lang/String;

    move-result-object p2

    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p2

    const p3, 0x7f0f0248

    if-nez p2, :cond_2

    iget-object p2, p0, Lchat/ola/vn/entry/b/af;->x:Landroid/widget/TextView;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {p3}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object p3

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p3, ": "

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Lchat/ola/vn/message/s;->F()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_2
    iget-object p1, p0, Lchat/ola/vn/entry/b/af;->x:Landroid/widget/TextView;

    invoke-virtual {p1, p3}, Landroid/widget/TextView;->setText(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
