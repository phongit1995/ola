.class public Lchat/ola/vn/i/k;
.super Lchat/ola/vn/i/n;

# interfaces
.implements Landroid/view/View$OnClickListener;


# instance fields
.field private a:Lchat/ola/vn/view/OlaCachedImageView;

.field private b:Lchat/ola/vn/view/OlaCachedImageView;

.field private c:Landroid/widget/TextView;

.field private d:Landroid/widget/TextView;

.field private e:Landroid/widget/TextView;

.field private f:Landroid/widget/TextView;

.field private g:Ljava/lang/String;

.field private h:Lchat/ola/vn/entity/l;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1

    invoke-direct {p0, p1}, Lchat/ola/vn/i/n;-><init>(Landroid/content/Context;)V

    invoke-virtual {p0}, Lchat/ola/vn/i/k;->getWindow()Landroid/view/Window;

    move-result-object p1

    const/4 v0, -0x2

    invoke-virtual {p1, v0, v0}, Landroid/view/Window;->setLayout(II)V

    const p1, 0x7f0b00fb

    invoke-virtual {p0, p1}, Lchat/ola/vn/i/k;->setContentView(I)V

    const/4 p1, 0x0

    iput-boolean p1, p0, Lchat/ola/vn/i/k;->j:Z

    const p1, 0x7f0902a3

    invoke-virtual {p0, p1}, Lchat/ola/vn/i/k;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object p1, p0, Lchat/ola/vn/i/k;->a:Lchat/ola/vn/view/OlaCachedImageView;

    const p1, 0x7f0902a2

    invoke-virtual {p0, p1}, Lchat/ola/vn/i/k;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object p1, p0, Lchat/ola/vn/i/k;->b:Lchat/ola/vn/view/OlaCachedImageView;

    const p1, 0x7f090575

    invoke-virtual {p0, p1}, Lchat/ola/vn/i/k;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/i/k;->f:Landroid/widget/TextView;

    const p1, 0x7f09055c

    invoke-virtual {p0, p1}, Lchat/ola/vn/i/k;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/i/k;->c:Landroid/widget/TextView;

    const p1, 0x7f09055a

    invoke-virtual {p0, p1}, Lchat/ola/vn/i/k;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/i/k;->d:Landroid/widget/TextView;

    iget-object p1, p0, Lchat/ola/vn/i/k;->d:Landroid/widget/TextView;

    sget-object v0, Landroid/graphics/Typeface;->DEFAULT_BOLD:Landroid/graphics/Typeface;

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V

    iget-object p1, p0, Lchat/ola/vn/i/k;->d:Landroid/widget/TextView;

    sget v0, Lchat/ola/vn/f;->a:I

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setTextColor(I)V

    const p1, 0x7f09055b

    invoke-virtual {p0, p1}, Lchat/ola/vn/i/k;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/i/k;->e:Landroid/widget/TextView;

    iget-object p1, p0, Lchat/ola/vn/i/k;->d:Landroid/widget/TextView;

    invoke-virtual {p1, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f0900f9

    invoke-virtual {p0, p1}, Lchat/ola/vn/i/k;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f0900fa

    invoke-virtual {p0, p1}, Lchat/ola/vn/i/k;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f0900fb

    invoke-virtual {p0, p1}, Lchat/ola/vn/i/k;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const/4 p1, 0x1

    invoke-virtual {p0, p1}, Lchat/ola/vn/i/k;->setCanceledOnTouchOutside(Z)V

    return-void
.end method

.method private a(Ljava/lang/String;)V
    .locals 3

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/i/k;->b:Lchat/ola/vn/view/OlaCachedImageView;

    const/4 v2, 0x0

    invoke-virtual {v0, p1, v2, v1}, Lchat/ola/vn/c/t;->b(Ljava/lang/String;ZLchat/ola/vn/view/OlaCachedImageView;)V

    return-void
.end method

.method private b(Ljava/lang/String;)V
    .locals 2

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/i/k;->a:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, p1, v1}, Lchat/ola/vn/c/t;->h(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V

    return-void
.end method


# virtual methods
.method public a(Ljava/lang/String;CLchat/ola/vn/entity/l;Ljava/lang/Long;)V
    .locals 4

    iput-object p1, p0, Lchat/ola/vn/i/k;->g:Ljava/lang/String;

    iput-object p3, p0, Lchat/ola/vn/i/k;->h:Lchat/ola/vn/entity/l;

    iget-object v0, p0, Lchat/ola/vn/i/k;->f:Landroid/widget/TextView;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    const v0, 0x7f0f0673

    packed-switch p2, :pswitch_data_0

    iget-object p2, p0, Lchat/ola/vn/i/k;->c:Landroid/widget/TextView;

    invoke-virtual {p2, v0}, Landroid/widget/TextView;->setText(I)V

    goto :goto_1

    :pswitch_0
    iget-object p2, p0, Lchat/ola/vn/i/k;->c:Landroid/widget/TextView;

    const v1, 0x7f0f0567

    goto :goto_0

    :pswitch_1
    iget-object p2, p0, Lchat/ola/vn/i/k;->c:Landroid/widget/TextView;

    const v1, 0x7f0f06b3

    goto :goto_0

    :pswitch_2
    iget-object p2, p0, Lchat/ola/vn/i/k;->c:Landroid/widget/TextView;

    const v1, 0x7f0f05a4

    :goto_0
    invoke-virtual {p2, v1}, Landroid/widget/TextView;->setText(I)V

    :goto_1
    if-eqz p4, :cond_0

    new-instance p2, Ljava/text/SimpleDateFormat;

    const-string v0, "dd/MM/yyyy"

    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v1

    invoke-direct {p2, v0, v1}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;Ljava/util/Locale;)V

    iget-object v0, p0, Lchat/ola/vn/i/k;->e:Landroid/widget/TextView;

    new-instance v1, Ljava/util/Date;

    invoke-virtual {p4}, Ljava/lang/Long;->longValue()J

    move-result-wide v2

    invoke-direct {v1, v2, v3}, Ljava/util/Date;-><init>(J)V

    invoke-virtual {p2, v1}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {v0, p2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_2

    :cond_0
    iget-object p2, p0, Lchat/ola/vn/i/k;->e:Landroid/widget/TextView;

    invoke-virtual {p2, v0}, Landroid/widget/TextView;->setText(I)V

    :goto_2
    if-eqz p3, :cond_1

    iget-object p2, p3, Lchat/ola/vn/entity/l;->a:Ljava/lang/String;

    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p2

    if-nez p2, :cond_1

    iget-object p2, p0, Lchat/ola/vn/i/k;->d:Landroid/widget/TextView;

    iget-object p3, p3, Lchat/ola/vn/entity/l;->a:Ljava/lang/String;

    invoke-virtual {p2, p3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_3

    :cond_1
    iget-object p2, p0, Lchat/ola/vn/i/k;->d:Landroid/widget/TextView;

    const p3, 0x7f0f0692

    invoke-virtual {p2, p3}, Landroid/widget/TextView;->setText(I)V

    :goto_3
    invoke-direct {p0, p1}, Lchat/ola/vn/i/k;->a(Ljava/lang/String;)V

    invoke-direct {p0, p1}, Lchat/ola/vn/i/k;->b(Ljava/lang/String;)V

    sget-object p2, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    if-eqz p2, :cond_3

    sget-object p2, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    const/4 p3, 0x0

    invoke-virtual {p2, p1, p3}, Lchat/ola/vn/message/g;->e(Ljava/lang/String;S)Lchat/ola/vn/message/f;

    move-result-object p1

    const p2, 0x7f0900fa

    if-eqz p1, :cond_2

    invoke-virtual {p0, p2}, Lchat/ola/vn/i/k;->findViewById(I)Landroid/view/View;

    move-result-object p1

    const/16 p2, 0x8

    invoke-virtual {p1, p2}, Landroid/view/View;->setVisibility(I)V

    return-void

    :cond_2
    invoke-virtual {p0, p2}, Lchat/ola/vn/i/k;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p3}, Landroid/view/View;->setVisibility(I)V

    :cond_3
    return-void

    :pswitch_data_0
    .packed-switch 0x30
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public onClick(Landroid/view/View;)V
    .locals 3

    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const v0, 0x7f09055a

    if-eq p1, v0, :cond_0

    packed-switch p1, :pswitch_data_0

    goto :goto_0

    :pswitch_0
    invoke-virtual {p0}, Lchat/ola/vn/i/k;->getContext()Landroid/content/Context;

    move-result-object p1

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v1, p0, Lchat/ola/vn/i/k;->g:Ljava/lang/String;

    invoke-static {p1, v0, v1}, Lchat/ola/vn/me/c;->a(Landroid/content/Context;Lchat/ola/vn/network/OlaNetworkService;Ljava/lang/String;)V

    goto :goto_0

    :pswitch_1
    iget-object p1, p0, Lchat/ola/vn/i/k;->g:Ljava/lang/String;

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0, p1}, Lchat/ola/vn/network/OlaNetworkService;->d(Ljava/lang/String;)V

    goto :goto_0

    :pswitch_2
    invoke-virtual {p0}, Lchat/ola/vn/i/k;->getContext()Landroid/content/Context;

    move-result-object p1

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v1, p0, Lchat/ola/vn/i/k;->g:Ljava/lang/String;

    const/4 v2, 0x0

    invoke-static {p1, v0, v1, v2}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Landroid/content/Context;Lchat/ola/vn/network/OlaNetworkService;Ljava/lang/String;S)V

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/i/k;->h:Lchat/ola/vn/entity/l;

    if-eqz p1, :cond_1

    invoke-virtual {p0}, Lchat/ola/vn/i/k;->getContext()Landroid/content/Context;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/i/k;->g:Ljava/lang/String;

    iget-object v1, p0, Lchat/ola/vn/i/k;->h:Lchat/ola/vn/entity/l;

    invoke-static {p1, v0, v1}, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->a(Landroid/content/Context;Ljava/lang/String;Lchat/ola/vn/entity/l;)V

    goto :goto_0

    :cond_1
    invoke-virtual {p0}, Lchat/ola/vn/i/k;->getContext()Landroid/content/Context;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/i/k;->g:Ljava/lang/String;

    invoke-static {p1, v0}, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->a(Landroid/content/Context;Ljava/lang/String;)V

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/i/k;->g:Ljava/lang/String;

    invoke-static {p1, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_2

    invoke-virtual {p0}, Lchat/ola/vn/i/k;->getContext()Landroid/content/Context;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/cloud/OlaCloudAlbumListActivity;->a(Landroid/content/Context;)V

    goto :goto_0

    :cond_2
    invoke-virtual {p0}, Lchat/ola/vn/i/k;->getContext()Landroid/content/Context;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/i/k;->g:Ljava/lang/String;

    invoke-static {p1, v0}, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->a(Landroid/content/Context;Ljava/lang/String;)V

    :goto_0
    invoke-virtual {p0}, Lchat/ola/vn/i/k;->dismiss()V

    return-void

    :pswitch_data_0
    .packed-switch 0x7f0900f9
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
