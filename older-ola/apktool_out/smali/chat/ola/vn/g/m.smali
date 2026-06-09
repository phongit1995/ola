.class public Lchat/ola/vn/g/m;
.super Lchat/ola/vn/g/h;

# interfaces
.implements Landroid/view/View$OnClickListener;


# instance fields
.field public e:Landroid/widget/ImageView;

.field public f:Landroid/widget/ImageView;

.field public g:Landroid/widget/TextView;

.field private h:Landroid/view/View;

.field private i:Landroid/widget/Button;

.field private j:Landroid/widget/TextView;

.field private k:Landroid/widget/TextView;


# direct methods
.method public constructor <init>(Landroid/view/View;)V
    .locals 1

    invoke-direct {p0, p1}, Lchat/ola/vn/g/h;-><init>(Landroid/view/View;)V

    const v0, 0x7f0905ef

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    iput-object v0, p0, Lchat/ola/vn/g/m;->e:Landroid/widget/ImageView;

    const v0, 0x7f090495

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    iput-object v0, p0, Lchat/ola/vn/g/m;->f:Landroid/widget/ImageView;

    const v0, 0x7f090496

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/g/m;->g:Landroid/widget/TextView;

    iget-object v0, p0, Lchat/ola/vn/g/m;->e:Landroid/widget/ImageView;

    invoke-virtual {v0, p0}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/g/m;->f:Landroid/widget/ImageView;

    invoke-virtual {v0, p0}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/g/m;->g:Landroid/widget/TextView;

    invoke-virtual {v0, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f090605

    :try_start_0
    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/g/m;->h:Landroid/view/View;

    const v0, 0x7f090604

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    iput-object v0, p0, Lchat/ola/vn/g/m;->i:Landroid/widget/Button;

    const v0, 0x7f090606

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/g/m;->j:Landroid/widget/TextView;

    const v0, 0x7f090607

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/g/m;->k:Landroid/widget/TextView;

    iget-object p1, p0, Lchat/ola/vn/g/m;->h:Landroid/view/View;

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private a(Landroid/content/Context;Landroid/view/View;)V
    .locals 2

    new-instance p2, Ljava/util/ArrayList;

    invoke-direct {p2}, Ljava/util/ArrayList;-><init>()V

    sget-short v0, Lchat/ola/vn/h;->H:S

    if-gtz v0, :cond_0

    const v0, 0x7f0f0444

    :goto_0
    invoke-virtual {p1, v0}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-interface {p2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_1

    :cond_0
    sget v0, Lchat/ola/vn/h;->K:I

    const/4 v1, 0x3

    if-gt v0, v1, :cond_1

    const v0, 0x7f0f0445

    goto :goto_0

    :cond_1
    :goto_1
    const v0, 0x7f0f045d

    invoke-virtual {p1, v0}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-interface {p2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v0, 0x7f0f054e

    invoke-virtual {p1, v0}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-interface {p2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v0, 0x7f0f054f

    invoke-virtual {p1, v0}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-interface {p2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :try_start_0
    new-instance v0, Lchat/ola/vn/i/m;

    invoke-direct {v0, p1}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    invoke-virtual {v0, p2}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance v1, Lchat/ola/vn/g/m$2;

    invoke-direct {v1, p0, p2, p1}, Lchat/ola/vn/g/m$2;-><init>(Lchat/ola/vn/g/m;Ljava/util/List;Landroid/content/Context;)V

    invoke-virtual {v0, v1}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {v0}, Lchat/ola/vn/i/m;->show()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic a(Lchat/ola/vn/g/m;Z)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/g/m;->c(Z)V

    return-void
.end method

.method private c(Z)V
    .locals 3

    :try_start_0
    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v0

    if-eqz v0, :cond_0

    new-instance v0, Lchat/ola/vn/i/j;

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v1

    new-instance v2, Lchat/ola/vn/g/m$3;

    invoke-direct {v2, p0, p1}, Lchat/ola/vn/g/m$3;-><init>(Lchat/ola/vn/g/m;Z)V

    invoke-direct {v0, v1, p1, v2}, Lchat/ola/vn/i/j;-><init>(Landroid/content/Context;ZLchat/ola/vn/i/j$a;)V

    invoke-virtual {v0}, Lchat/ola/vn/i/j;->show()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method


# virtual methods
.method public b(I)V
    .locals 6

    const/16 p1, 0x8

    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/g/m;->e:Landroid/widget/ImageView;

    invoke-static {}, Lchat/ola/vn/j;->a()Lchat/ola/vn/j;

    move-result-object v2

    sget-short v3, Lchat/ola/vn/h;->H:S

    invoke-virtual {v2, v3}, Lchat/ola/vn/j;->a(I)Landroid/graphics/Bitmap;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/widget/ImageView;->setImageBitmap(Landroid/graphics/Bitmap;)V

    sget-object v1, Lchat/ola/vn/c/x;->c:Ljava/lang/String;

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_5

    invoke-static {v1}, Lchat/ola/vn/util/i;->b(Ljava/lang/CharSequence;)Ljava/util/ArrayList;

    move-result-object v2

    const-string v3, ""

    invoke-static {v1, v3}, Lchat/ola/vn/util/i;->d(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    if-eqz v2, :cond_4

    invoke-interface {v2}, Ljava/util/List;->isEmpty()Z

    move-result v3

    if-nez v3, :cond_4

    invoke-interface {v2, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    const/4 v3, 0x1

    invoke-virtual {v2, v3}, Ljava/lang/String;->charAt(I)C

    move-result v4

    const/16 v5, 0x50

    if-eq v4, v5, :cond_2

    const/16 v2, 0x53

    if-eq v4, v2, :cond_1

    const/16 v2, 0x56

    if-eq v4, v2, :cond_0

    iget-object v2, p0, Lchat/ola/vn/g/m;->f:Landroid/widget/ImageView;

    const v3, 0x7f080775

    invoke-virtual {v2, v3}, Landroid/widget/ImageView;->setImageResource(I)V

    goto :goto_0

    :cond_0
    iget-object v2, p0, Lchat/ola/vn/g/m;->f:Landroid/widget/ImageView;

    const v3, 0x7f08071a

    invoke-virtual {v2, v3}, Landroid/widget/ImageView;->setImageResource(I)V

    goto :goto_0

    :cond_1
    iget-object v2, p0, Lchat/ola/vn/g/m;->f:Landroid/widget/ImageView;

    const v3, 0x7f080717

    invoke-virtual {v2, v3}, Landroid/widget/ImageView;->setImageResource(I)V

    goto :goto_0

    :cond_2
    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v4

    invoke-virtual {v4, v2}, Lchat/ola/vn/c/t;->b(Ljava/lang/String;)Landroid/graphics/Bitmap;

    move-result-object v4

    if-eqz v4, :cond_3

    iget-object v2, p0, Lchat/ola/vn/g/m;->f:Landroid/widget/ImageView;

    invoke-virtual {v2, v4}, Landroid/widget/ImageView;->setImageBitmap(Landroid/graphics/Bitmap;)V

    goto :goto_0

    :cond_3
    iget-object v4, p0, Lchat/ola/vn/g/m;->f:Landroid/widget/ImageView;

    const v5, 0x7f0800b2

    invoke-virtual {v4, v5}, Landroid/widget/ImageView;->setImageResource(I)V

    const/16 v4, 0x140

    invoke-static {v2, v4}, Lchat/ola/vn/c/f;->g(Ljava/lang/String;I)Lchat/ola/vn/c/f;

    move-result-object v2

    new-instance v4, Lchat/ola/vn/g/m$1;

    invoke-direct {v4, p0}, Lchat/ola/vn/g/m$1;-><init>(Lchat/ola/vn/g/m;)V

    invoke-virtual {v2, v4}, Lchat/ola/vn/c/f;->a(Lchat/ola/vn/c/g;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    new-instance v4, Lchat/ola/vn/c/e;

    invoke-direct {v4}, Lchat/ola/vn/c/e;-><init>()V

    new-array v3, v3, [Lchat/ola/vn/c/f;

    aput-object v2, v3, v0

    invoke-virtual {v4, v3}, Lchat/ola/vn/c/e;->a([Lchat/ola/vn/c/f;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :goto_0
    :try_start_2
    iget-object v2, p0, Lchat/ola/vn/g/m;->f:Landroid/widget/ImageView;

    invoke-virtual {v2, v0}, Landroid/widget/ImageView;->setVisibility(I)V

    goto :goto_1

    :cond_4
    iget-object v2, p0, Lchat/ola/vn/g/m;->f:Landroid/widget/ImageView;

    invoke-virtual {v2, p1}, Landroid/widget/ImageView;->setVisibility(I)V

    :goto_1
    iget-object v2, p0, Lchat/ola/vn/g/m;->g:Landroid/widget/TextView;

    invoke-virtual {v2, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_2

    :cond_5
    iget-object v1, p0, Lchat/ola/vn/g/m;->g:Landroid/widget/TextView;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v1, p0, Lchat/ola/vn/g/m;->f:Landroid/widget/ImageView;

    invoke-virtual {v1, p1}, Landroid/widget/ImageView;->setVisibility(I)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    :goto_2
    :try_start_3
    iget-object v1, p0, Lchat/ola/vn/g/m;->h:Landroid/view/View;

    if-eqz v1, :cond_8

    iget-object v1, p0, Lchat/ola/vn/g/m;->h:Landroid/view/View;

    invoke-virtual {v1, p1}, Landroid/view/View;->setVisibility(I)V

    sget-object v1, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    iget-short v1, v1, Lchat/ola/vn/entity/ag;->u:S

    if-nez v1, :cond_6

    iget-object v1, p0, Lchat/ola/vn/g/m;->h:Landroid/view/View;

    invoke-virtual {v1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/g/m;->h:Landroid/view/View;

    const-string v1, "0"

    invoke-virtual {v0, v1}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object v0, p0, Lchat/ola/vn/g/m;->i:Landroid/widget/Button;

    const v1, 0x7f0f0444

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setText(I)V

    iget-object v0, p0, Lchat/ola/vn/g/m;->j:Landroid/widget/TextView;

    const v1, 0x7f0f0329

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    iget-object v0, p0, Lchat/ola/vn/g/m;->k:Landroid/widget/TextView;

    const v1, 0x7f0f032b

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    return-void

    :cond_6
    sget-object v1, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    iget v1, v1, Lchat/ola/vn/entity/ag;->q:I

    if-lez v1, :cond_7

    sget-object v1, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    iget v1, v1, Lchat/ola/vn/entity/ag;->q:I

    const/4 v2, 0x3

    if-ge v1, v2, :cond_7

    iget-object v1, p0, Lchat/ola/vn/g/m;->h:Landroid/view/View;

    invoke-virtual {v1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/g/m;->h:Landroid/view/View;

    const-string v1, "1"

    invoke-virtual {v0, v1}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object v0, p0, Lchat/ola/vn/g/m;->i:Landroid/widget/Button;

    const v1, 0x7f0f04ea

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setText(I)V

    iget-object v0, p0, Lchat/ola/vn/g/m;->j:Landroid/widget/TextView;

    const v1, 0x7f0f0246

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    iget-object v0, p0, Lchat/ola/vn/g/m;->k:Landroid/widget/TextView;

    const v1, 0x7f0f0247

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    return-void

    :cond_7
    sget-object v1, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    iget-boolean v1, v1, Lchat/ola/vn/entity/ag;->x:Z

    if-nez v1, :cond_8

    iget-object v1, p0, Lchat/ola/vn/g/m;->h:Landroid/view/View;

    invoke-virtual {v1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/g/m;->h:Landroid/view/View;

    const-string v1, "2"

    invoke-virtual {v0, v1}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object v0, p0, Lchat/ola/vn/g/m;->i:Landroid/widget/Button;

    const v1, 0x7f0f068c

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setText(I)V

    iget-object v0, p0, Lchat/ola/vn/g/m;->j:Landroid/widget/TextView;

    const v1, 0x7f0f02e3

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    iget-object v0, p0, Lchat/ola/vn/g/m;->k:Landroid/widget/TextView;

    const v1, 0x7f0f03a7

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_2

    return-void

    :catch_2
    :try_start_4
    iget-object v0, p0, Lchat/ola/vn/g/m;->h:Landroid/view/View;

    invoke-virtual {v0, p1}, Landroid/view/View;->setVisibility(I)V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_3

    :catch_3
    :cond_8
    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 6

    :try_start_0
    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v0

    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v1

    sparse-switch v1, :sswitch_data_0

    return-void

    :sswitch_0
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    const-string v0, "0"

    invoke-static {p1, v0}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/activity/BuyVipActivity;->a(Landroid/content/Context;)V

    return-void

    :cond_0
    const-string v0, "1"

    invoke-static {p1, v0}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/activity/BuyVipActivity;->b(Landroid/content/Context;)V

    return-void

    :cond_1
    const-string v0, "2"

    invoke-static {p1, v0}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_4

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->a(Landroid/content/Context;)V

    return-void

    :sswitch_1
    invoke-direct {p0, v0, p1}, Lchat/ola/vn/g/m;->a(Landroid/content/Context;Landroid/view/View;)V

    return-void

    :sswitch_2
    sget-object p1, Lchat/ola/vn/c/x;->c:Ljava/lang/String;

    invoke-static {v0, p1}, Lchat/ola/vn/me/OlaMeComposerActivity;->a(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :sswitch_3
    sget-object v1, Lchat/ola/vn/c/x;->c:Ljava/lang/String;

    invoke-static {v1}, Lchat/ola/vn/util/i;->b(Ljava/lang/CharSequence;)Ljava/util/ArrayList;

    move-result-object v1

    if-eqz v1, :cond_4

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v2

    if-lez v2, :cond_4

    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2, v1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_2
    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_3

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    invoke-static {v3}, Lchat/ola/vn/entity/i;->i(Ljava/lang/String;)C

    move-result v4

    const/4 v5, 0x1

    if-ne v4, v5, :cond_2

    invoke-interface {v2, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_3
    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v1

    if-lez v1, :cond_4

    const/4 v1, 0x0

    const/4 v3, 0x0

    invoke-static {v2}, Lchat/ola/vn/mediastore/OlaMediaEntity;->a(Ljava/util/List;)Ljava/util/ArrayList;

    move-result-object v2

    invoke-static {v0, p1, v1, v3, v2}, Lchat/ola/vn/activity/OlaImageViewerActivity;->a(Landroid/content/Context;Landroid/view/View;Landroid/graphics/Bitmap;ILjava/util/ArrayList;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_4
    return-void

    :sswitch_data_0
    .sparse-switch
        0x7f090495 -> :sswitch_3
        0x7f090496 -> :sswitch_2
        0x7f0905ef -> :sswitch_1
        0x7f090605 -> :sswitch_0
    .end sparse-switch
.end method
