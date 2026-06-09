.class public Lchat/ola/vn/entry/b/y;
.super Lchat/ola/vn/entry/b/ab;


# instance fields
.field private A:Landroid/view/View;

.field private B:Landroid/widget/TextView;

.field private C:Landroid/widget/TextView;

.field private D:Landroid/view/View;

.field private E:Landroid/widget/ProgressBar;

.field private F:Landroid/view/View;

.field private G:I

.field private H:Ljava/lang/String;

.field private I:Landroid/view/ViewStub;

.field private z:Lchat/ola/vn/view/OlaCachedImageView;


# direct methods
.method public constructor <init>(Landroid/view/View;I)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lchat/ola/vn/entry/b/ab;-><init>(Landroid/view/View;I)V

    const/16 p1, 0xa

    iput p1, p0, Lchat/ola/vn/entry/b/y;->G:I

    const/4 p1, 0x0

    iput-object p1, p0, Lchat/ola/vn/entry/b/y;->H:Ljava/lang/String;

    iput-object p1, p0, Lchat/ola/vn/entry/b/y;->I:Landroid/view/ViewStub;

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/entry/b/y;)Lchat/ola/vn/view/OlaCachedImageView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/entry/b/y;->z:Lchat/ola/vn/view/OlaCachedImageView;

    return-object p0
.end method

.method static synthetic b(Lchat/ola/vn/entry/b/y;)Landroid/view/View;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/entry/b/y;->F:Landroid/view/View;

    return-object p0
.end method

.method static synthetic c(Lchat/ola/vn/entry/b/y;)Landroid/widget/TextView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/entry/b/y;->B:Landroid/widget/TextView;

    return-object p0
.end method

.method static synthetic d(Lchat/ola/vn/entry/b/y;)Landroid/widget/TextView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/entry/b/y;->C:Landroid/widget/TextView;

    return-object p0
.end method

.method private h()V
    .locals 4

    iget-object v0, p0, Lchat/ola/vn/entry/b/y;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->m:Ljava/lang/String;

    const/16 v1, 0x8

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/entry/b/y;->z:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    return-void

    :cond_0
    :try_start_0
    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    iget-object v2, p0, Lchat/ola/vn/entry/b/y;->b:Lchat/ola/vn/entry/b;

    iget-object v2, v2, Lchat/ola/vn/entry/b;->p:Ljava/lang/String;

    iget-object v3, p0, Lchat/ola/vn/entry/b/y;->z:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, v2, v3}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/y;->A:Landroid/view/View;

    const/4 v2, 0x0

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/y;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->n:Ljava/lang/String;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/entry/b/y;->F:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/y;->B:Landroid/widget/TextView;

    iget-object v1, p0, Lchat/ola/vn/entry/b/y;->b:Lchat/ola/vn/entry/b;

    iget-object v1, v1, Lchat/ola/vn/entry/b;->n:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/y;->C:Landroid/widget/TextView;

    iget-object v1, p0, Lchat/ola/vn/entry/b/y;->b:Lchat/ola/vn/entry/b;

    iget-object v1, v1, Lchat/ola/vn/entry/b;->o:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/entry/b/y;->F:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/y;->B:Landroid/widget/TextView;

    const-string v1, ""

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/y;->C:Landroid/widget/TextView;

    const-string v1, ""

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v1, p0, Lchat/ola/vn/entry/b/y;->b:Lchat/ola/vn/entry/b;

    iget-object v1, v1, Lchat/ola/vn/entry/b;->m:Ljava/lang/String;

    new-instance v2, Lchat/ola/vn/entry/b/y$1;

    invoke-direct {v2, p0}, Lchat/ola/vn/entry/b/y$1;-><init>(Lchat/ola/vn/entry/b/y;)V

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Lchat/ola/vn/p/b;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private i()V
    .locals 4
    .annotation build Landroid/annotation/TargetApi;
        value = 0xb
    .end annotation

    iget-object v0, p0, Lchat/ola/vn/entry/b/y;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->m:Ljava/lang/String;

    const/16 v1, 0x8

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/entry/b/y;->z:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    return-void

    :cond_0
    :try_start_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "http://img.youtube.com/vi/"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, p0, Lchat/ola/vn/entry/b/y;->b:Lchat/ola/vn/entry/b;

    iget-object v2, v2, Lchat/ola/vn/entry/b;->m:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, "/mqdefault.jpg"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iget-object v2, p0, Lchat/ola/vn/entry/b/y;->z:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v2}, Lchat/ola/vn/view/OlaCachedImageView;->getWidth()I

    move-result v2

    const/16 v3, 0x190

    if-gt v2, v3, :cond_1

    sget-boolean v2, Lchat/ola/vn/h;->I:Z

    if-eqz v2, :cond_2

    :cond_1
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "http://img.youtube.com/vi/"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, p0, Lchat/ola/vn/entry/b/y;->b:Lchat/ola/vn/entry/b;

    iget-object v2, v2, Lchat/ola/vn/entry/b;->m:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, "/hqdefault.jpg"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    :cond_2
    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v2

    iget-object v3, p0, Lchat/ola/vn/entry/b/y;->z:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v2, v0, v3}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/y;->A:Landroid/view/View;

    const/4 v2, 0x0

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/y;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->n:Ljava/lang/String;

    if-eqz v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/entry/b/y;->F:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/y;->B:Landroid/widget/TextView;

    iget-object v1, p0, Lchat/ola/vn/entry/b/y;->b:Lchat/ola/vn/entry/b;

    iget-object v1, v1, Lchat/ola/vn/entry/b;->n:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/y;->C:Landroid/widget/TextView;

    iget-object v1, p0, Lchat/ola/vn/entry/b/y;->b:Lchat/ola/vn/entry/b;

    iget-object v1, v1, Lchat/ola/vn/entry/b;->o:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_3
    iget-object v0, p0, Lchat/ola/vn/entry/b/y;->F:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/y;->B:Landroid/widget/TextView;

    const-string v1, ""

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/y;->C:Landroid/widget/TextView;

    const-string v1, ""

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    new-instance v0, Lchat/ola/vn/entry/b/y$2;

    invoke-direct {v0, p0}, Lchat/ola/vn/entry/b/y$2;-><init>(Lchat/ola/vn/entry/b/y;)V

    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v2, p0, Lchat/ola/vn/entry/b/y;->b:Lchat/ola/vn/entry/b;

    iget-object v2, v2, Lchat/ola/vn/entry/b;->m:Ljava/lang/String;

    invoke-virtual {v1, v2, v0}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Lchat/ola/vn/p/o;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private j()V
    .locals 3
    .annotation build Landroid/annotation/TargetApi;
        value = 0xb
    .end annotation

    iget-object v0, p0, Lchat/ola/vn/entry/b/y;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->m:Ljava/lang/String;

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/entry/b/y;->z:Lchat/ola/vn/view/OlaCachedImageView;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    return-void

    :cond_0
    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/y;->A:Landroid/view/View;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/y;->z:Lchat/ola/vn/view/OlaCachedImageView;

    const/high16 v2, -0x1000000

    invoke-virtual {v0, v2}, Lchat/ola/vn/view/OlaCachedImageView;->setBackgroundColor(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/y;->z:Lchat/ola/vn/view/OlaCachedImageView;

    const/4 v2, 0x0

    invoke-virtual {v0, v2, v2}, Lchat/ola/vn/view/OlaCachedImageView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/y;->F:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/y;->B:Landroid/widget/TextView;

    const v1, 0x7f0f064e

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/y;->C:Landroid/widget/TextView;

    const-string v1, "--:--"

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method


# virtual methods
.method public a()V
    .locals 2
    .annotation build Landroid/annotation/TargetApi;
        value = 0xb
    .end annotation

    iget-object v0, p0, Lchat/ola/vn/entry/b/y;->b:Lchat/ola/vn/entry/b;

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-super {p0}, Lchat/ola/vn/entry/b/ab;->a()V

    iget-object v0, p0, Lchat/ola/vn/entry/b/y;->a:Landroid/view/View$OnClickListener;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/entry/b/y;->D:Landroid/view/View;

    iget-object v1, p0, Lchat/ola/vn/entry/b/y;->b:Lchat/ola/vn/entry/b;

    invoke-virtual {v0, v1}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/y;->D:Landroid/view/View;

    iget-object v1, p0, Lchat/ola/vn/entry/b/y;->a:Landroid/view/View$OnClickListener;

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/entry/b/y;->e:Landroid/view/View$OnLongClickListener;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/entry/b/y;->D:Landroid/view/View;

    iget-object v1, p0, Lchat/ola/vn/entry/b/y;->b:Lchat/ola/vn/entry/b;

    invoke-virtual {v0, v1}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/y;->D:Landroid/view/View;

    iget-object v1, p0, Lchat/ola/vn/entry/b/y;->e:Landroid/view/View$OnLongClickListener;

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnLongClickListener(Landroid/view/View$OnLongClickListener;)V

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/entry/b/y;->b:Lchat/ola/vn/entry/b;

    iget-byte v0, v0, Lchat/ola/vn/entry/b;->l:B

    packed-switch v0, :pswitch_data_0

    invoke-direct {p0}, Lchat/ola/vn/entry/b/y;->i()V

    return-void

    :pswitch_0
    invoke-direct {p0}, Lchat/ola/vn/entry/b/y;->j()V

    return-void

    :pswitch_1
    invoke-direct {p0}, Lchat/ola/vn/entry/b/y;->h()V

    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public a(Landroid/view/View;)V
    .locals 2

    invoke-super {p0, p1}, Lchat/ola/vn/entry/b/ab;->a(Landroid/view/View;)V

    const v0, 0x7f090307

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/entry/b/y;->D:Landroid/view/View;

    const v0, 0x7f090083

    :try_start_0
    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ProgressBar;

    iput-object v0, p0, Lchat/ola/vn/entry/b/y;->E:Landroid/widget/ProgressBar;

    iget-object v0, p0, Lchat/ola/vn/entry/b/y;->E:Landroid/widget/ProgressBar;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/ProgressBar;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    const v0, 0x7f090296

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/entry/b/y;->A:Landroid/view/View;

    const v0, 0x7f090295

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object v0, p0, Lchat/ola/vn/entry/b/y;->z:Lchat/ola/vn/view/OlaCachedImageView;

    const v0, 0x7f09033e

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/entry/b/y;->F:Landroid/view/View;

    const v0, 0x7f09033f

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/entry/b/y;->B:Landroid/widget/TextView;

    const v0, 0x7f09033d

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/entry/b/y;->C:Landroid/widget/TextView;

    :try_start_1
    invoke-virtual {p1}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const v1, 0x7f070141

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v0

    iput v0, p0, Lchat/ola/vn/entry/b/y;->G:I
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    iget-object v0, p0, Lchat/ola/vn/entry/b/y;->z:Lchat/ola/vn/view/OlaCachedImageView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1, v1}, Lchat/ola/vn/view/OlaCachedImageView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    const v0, 0x7f090333

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/view/ViewStub;

    iput-object p1, p0, Lchat/ola/vn/entry/b/y;->I:Landroid/view/ViewStub;

    return-void
.end method
