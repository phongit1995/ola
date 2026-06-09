.class public Lchat/ola/vn/entry/b/r;
.super Lchat/ola/vn/entry/b/f;

# interfaces
.implements Landroid/view/View$OnClickListener;


# instance fields
.field public A:Landroid/widget/TextView;

.field public B:Landroid/widget/TextView;

.field protected C:Lchat/ola/vn/message/r;

.field protected D:Lchat/ola/vn/message/i;

.field private E:Landroid/widget/ImageView;

.field private F:Landroid/view/View;

.field private G:Landroid/view/View;

.field private H:Landroid/view/View;

.field private I:Landroid/view/View;

.field protected t:Lchat/ola/vn/view/OlaCachedImageView;

.field protected u:Landroid/widget/TextView;

.field protected v:Landroid/widget/TextView;

.field protected w:Landroid/view/View;

.field protected x:Landroid/view/View;

.field protected y:Landroid/view/View;

.field protected z:Landroid/widget/TextView;


# direct methods
.method public constructor <init>(Landroid/view/View;I)V
    .locals 1

    invoke-direct {p0, p1}, Lchat/ola/vn/entry/b/f;-><init>(Landroid/view/View;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/r;->q:Landroid/view/ViewStub;

    invoke-virtual {v0, p2}, Landroid/view/ViewStub;->setLayoutResource(I)V

    iget-object p2, p0, Lchat/ola/vn/entry/b/r;->q:Landroid/view/ViewStub;

    invoke-virtual {p2}, Landroid/view/ViewStub;->inflate()Landroid/view/View;

    iget-object p2, p0, Lchat/ola/vn/entry/b/r;->q:Landroid/view/ViewStub;

    const/4 v0, 0x0

    invoke-virtual {p2, v0}, Landroid/view/ViewStub;->setVisibility(I)V

    const p2, 0x7f09029e

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object p2, p0, Lchat/ola/vn/entry/b/r;->t:Lchat/ola/vn/view/OlaCachedImageView;

    const p2, 0x7f09056e

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, p0, Lchat/ola/vn/entry/b/r;->u:Landroid/widget/TextView;

    const p2, 0x7f09056c

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, p0, Lchat/ola/vn/entry/b/r;->v:Landroid/widget/TextView;

    const p2, 0x7f09043b

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    iput-object p2, p0, Lchat/ola/vn/entry/b/r;->w:Landroid/view/View;

    const p2, 0x7f0900f1

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    iput-object p2, p0, Lchat/ola/vn/entry/b/r;->x:Landroid/view/View;

    const p2, 0x7f09043d

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    iput-object p2, p0, Lchat/ola/vn/entry/b/r;->y:Landroid/view/View;

    const p2, 0x7f09043c

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, p0, Lchat/ola/vn/entry/b/r;->z:Landroid/widget/TextView;

    const p2, 0x7f09043e

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    iput-object p2, p0, Lchat/ola/vn/entry/b/r;->I:Landroid/view/View;

    iget-object p2, p0, Lchat/ola/vn/entry/b/r;->I:Landroid/view/View;

    invoke-virtual {p2, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p2, 0x7f09015a

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    iput-object p2, p0, Lchat/ola/vn/entry/b/r;->H:Landroid/view/View;

    iget-object p2, p0, Lchat/ola/vn/entry/b/r;->H:Landroid/view/View;

    invoke-static {}, Lchat/ola/vn/q/a;->a()Lchat/ola/vn/q/a;

    move-result-object v0

    invoke-virtual {p2, v0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p2, 0x7f090442

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    iput-object p2, p0, Lchat/ola/vn/entry/b/r;->F:Landroid/view/View;

    iget-object p2, p0, Lchat/ola/vn/entry/b/r;->F:Landroid/view/View;

    invoke-virtual {p2, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p2, 0x7f09043f

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/ImageView;

    iput-object p2, p0, Lchat/ola/vn/entry/b/r;->E:Landroid/widget/ImageView;

    const p2, 0x7f090441

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, p0, Lchat/ola/vn/entry/b/r;->B:Landroid/widget/TextView;

    const p2, 0x7f090440

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, p0, Lchat/ola/vn/entry/b/r;->A:Landroid/widget/TextView;

    const p2, 0x7f090443

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/entry/b/r;->G:Landroid/view/View;

    iget-object p1, p0, Lchat/ola/vn/entry/b/r;->G:Landroid/view/View;

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/entry/b/r;->d:Landroid/view/View;

    invoke-virtual {p1}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object p1

    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p1

    const p2, 0x7f07013c

    invoke-virtual {p1, p2}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result p1

    iput p1, p0, Lchat/ola/vn/entry/b/r;->e:I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic a(Lchat/ola/vn/entry/b/r;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/entry/b/r;->g()V

    return-void
.end method

.method private a(Lchat/ola/vn/message/i;)V
    .locals 2

    :try_start_0
    iput-object p1, p0, Lchat/ola/vn/entry/b/r;->D:Lchat/ola/vn/message/i;

    const/4 p1, 0x0

    iput-object p1, p0, Lchat/ola/vn/entry/b/r;->C:Lchat/ola/vn/message/r;

    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lchat/ola/vn/entry/b/r;->a(Z)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/r;->D:Lchat/ola/vn/message/i;

    invoke-virtual {v1}, Lchat/ola/vn/message/i;->a()Lchat/ola/vn/entity/z;

    move-result-object v1

    if-nez v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/entry/b/r;->t:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v1, p1, p1}, Lchat/ola/vn/view/OlaCachedImageView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/r;->u:Landroid/widget/TextView;

    const-string v1, ""

    invoke-virtual {p1, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/r;->v:Landroid/widget/TextView;

    const-string v1, ""

    invoke-virtual {p1, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/r;->t:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {p1, v0}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/r;->u:Landroid/widget/TextView;

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/r;->v:Landroid/widget/TextView;

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v0, p0, Lchat/ola/vn/entry/b/r;->D:Lchat/ola/vn/message/i;

    invoke-virtual {v0}, Lchat/ola/vn/message/i;->B()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Lchat/ola/vn/entry/b/r$2;

    invoke-direct {v1, p0}, Lchat/ola/vn/entry/b/r$2;-><init>(Lchat/ola/vn/entry/b/r;)V

    invoke-virtual {p1, v0, v1}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Lchat/ola/vn/network/a/a/aj$a;)V

    return-void

    :cond_0
    invoke-direct {p0}, Lchat/ola/vn/entry/b/r;->h()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private a(Lchat/ola/vn/message/r;)V
    .locals 2

    :try_start_0
    iput-object p1, p0, Lchat/ola/vn/entry/b/r;->C:Lchat/ola/vn/message/r;

    const/4 p1, 0x0

    iput-object p1, p0, Lchat/ola/vn/entry/b/r;->D:Lchat/ola/vn/message/i;

    iget-object v0, p0, Lchat/ola/vn/entry/b/r;->C:Lchat/ola/vn/message/r;

    invoke-virtual {v0}, Lchat/ola/vn/message/r;->a()Lchat/ola/vn/entity/u;

    move-result-object v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/entry/b/r;->t:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, p1, p1}, Lchat/ola/vn/view/OlaCachedImageView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/r;->u:Landroid/widget/TextView;

    const-string v0, ""

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/r;->v:Landroid/widget/TextView;

    const-string v0, ""

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/r;->t:Lchat/ola/vn/view/OlaCachedImageView;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/r;->u:Landroid/widget/TextView;

    const/16 v1, 0x8

    invoke-virtual {p1, v1}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/r;->v:Landroid/widget/TextView;

    invoke-virtual {p1, v1}, Landroid/widget/TextView;->setVisibility(I)V

    invoke-direct {p0, v0}, Lchat/ola/vn/entry/b/r;->a(Z)V

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v0, p0, Lchat/ola/vn/entry/b/r;->C:Lchat/ola/vn/message/r;

    invoke-virtual {v0}, Lchat/ola/vn/message/r;->y()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Lchat/ola/vn/entry/b/r$1;

    invoke-direct {v1, p0}, Lchat/ola/vn/entry/b/r$1;-><init>(Lchat/ola/vn/entry/b/r;)V

    invoke-virtual {p1, v0, v1}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Lchat/ola/vn/p/l;)V

    return-void

    :cond_0
    invoke-direct {p0}, Lchat/ola/vn/entry/b/r;->g()V

    invoke-direct {p0}, Lchat/ola/vn/entry/b/r;->i()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private a(Z)V
    .locals 1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/entry/b/r;->w:Landroid/view/View;

    const/4 v0, 0x0

    :goto_0
    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/r;->x:Landroid/view/View;

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/r;->y:Landroid/view/View;

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/entry/b/r;->w:Landroid/view/View;

    const/16 v0, 0x8

    goto :goto_0

    return-void
.end method

.method static synthetic b(Lchat/ola/vn/entry/b/r;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/entry/b/r;->i()V

    return-void
.end method

.method private b(Lchat/ola/vn/message/r;)V
    .locals 4

    const/4 v0, 0x0

    :try_start_0
    invoke-virtual {p1}, Lchat/ola/vn/message/r;->a()Lchat/ola/vn/entity/u;

    move-result-object v1

    invoke-virtual {v1}, Lchat/ola/vn/entity/u;->b()Lchat/ola/vn/entity/f;

    move-result-object v1

    invoke-virtual {v1}, Lchat/ola/vn/entity/f;->a()Z

    move-result v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    const/4 v1, 0x0

    :goto_0
    iget-object v2, p0, Lchat/ola/vn/entry/b/r;->G:Landroid/view/View;

    invoke-virtual {v2, p1}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object v2, p0, Lchat/ola/vn/entry/b/r;->F:Landroid/view/View;

    invoke-virtual {v2, p1}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    invoke-virtual {p1}, Lchat/ola/vn/message/r;->a()Lchat/ola/vn/entity/u;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/entity/u;->f()I

    move-result p1

    iget-object v2, p0, Lchat/ola/vn/entry/b/r;->E:Landroid/widget/ImageView;

    const v3, 0x7f080700

    invoke-virtual {v2, v3}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object v2, p0, Lchat/ola/vn/entry/b/r;->B:Landroid/widget/TextView;

    sget v3, Lchat/ola/vn/f;->A:I

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setTextColor(I)V

    const/4 v2, 0x2

    if-eqz v1, :cond_1

    iget-object v1, p0, Lchat/ola/vn/entry/b/r;->C:Lchat/ola/vn/message/r;

    invoke-virtual {v1}, Lchat/ola/vn/message/r;->d()B

    move-result v1

    if-ne v1, v2, :cond_0

    iget-object v1, p0, Lchat/ola/vn/entry/b/r;->E:Landroid/widget/ImageView;

    const v3, 0x7f080702

    invoke-virtual {v1, v3}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/r;->B:Landroid/widget/TextView;

    sget v3, Lchat/ola/vn/f;->C:I

    :goto_1
    invoke-virtual {v1, v3}, Landroid/widget/TextView;->setTextColor(I)V

    goto :goto_2

    :cond_0
    iget-object v1, p0, Lchat/ola/vn/entry/b/r;->E:Landroid/widget/ImageView;

    const v3, 0x7f080701

    invoke-virtual {v1, v3}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/r;->B:Landroid/widget/TextView;

    sget v3, Lchat/ola/vn/f;->H:I

    goto :goto_1

    :cond_1
    :goto_2
    if-lez p1, :cond_4

    iget-object v1, p0, Lchat/ola/vn/entry/b/r;->C:Lchat/ola/vn/message/r;

    invoke-virtual {v1}, Lchat/ola/vn/message/r;->d()B

    move-result v1

    if-ne v1, v2, :cond_2

    iget-object v1, p0, Lchat/ola/vn/entry/b/r;->A:Landroid/widget/TextView;

    sget v2, Lchat/ola/vn/f;->E:I

    :goto_3
    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setTextColor(I)V

    goto :goto_4

    :cond_2
    iget-object v1, p0, Lchat/ola/vn/entry/b/r;->A:Landroid/widget/TextView;

    sget v2, Lchat/ola/vn/f;->A:I

    goto :goto_3

    :goto_4
    iget-object v1, p0, Lchat/ola/vn/entry/b/r;->A:Landroid/widget/TextView;

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    const/4 v0, 0x1

    if-le p1, v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/entry/b/r;->A:Landroid/widget/TextView;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    int-to-long v2, p1

    invoke-static {v2, v3}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, " "

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const p1, 0x7f0f0538

    :goto_5
    invoke-static {p1}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_3
    iget-object v0, p0, Lchat/ola/vn/entry/b/r;->A:Landroid/widget/TextView;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    int-to-long v2, p1

    invoke-static {v2, v3}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, " "

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const p1, 0x7f0f0539

    goto :goto_5

    :cond_4
    iget-object p1, p0, Lchat/ola/vn/entry/b/r;->A:Landroid/widget/TextView;

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    return-void
.end method

.method static synthetic c(Lchat/ola/vn/entry/b/r;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/entry/b/r;->h()V

    return-void
.end method

.method private g()V
    .locals 5

    const/16 v0, 0x8

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/entry/b/r;->H:Landroid/view/View;

    iget-object v2, p0, Lchat/ola/vn/entry/b/r;->C:Lchat/ola/vn/message/r;

    invoke-virtual {v1, v2}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/r;->H:Landroid/view/View;

    iget-object v2, p0, Lchat/ola/vn/entry/b/r;->b:Landroid/view/View$OnLongClickListener;

    invoke-virtual {v1, v2}, Landroid/view/View;->setOnLongClickListener(Landroid/view/View$OnLongClickListener;)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/r;->C:Lchat/ola/vn/message/r;

    invoke-virtual {v1}, Lchat/ola/vn/message/r;->d()B

    move-result v1

    const/4 v2, 0x2

    if-ne v1, v2, :cond_0

    iget-object v1, p0, Lchat/ola/vn/entry/b/r;->u:Landroid/widget/TextView;

    sget v2, Lchat/ola/vn/f;->C:I

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/r;->v:Landroid/widget/TextView;

    sget v2, Lchat/ola/vn/f;->D:I

    :goto_0
    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setTextColor(I)V

    goto :goto_1

    :cond_0
    iget-object v1, p0, Lchat/ola/vn/entry/b/r;->u:Landroid/widget/TextView;

    sget v2, Lchat/ola/vn/f;->y:I

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/r;->v:Landroid/widget/TextView;

    sget v2, Lchat/ola/vn/f;->z:I

    goto :goto_0

    :goto_1
    iget-object v1, p0, Lchat/ola/vn/entry/b/r;->C:Lchat/ola/vn/message/r;

    invoke-virtual {v1}, Lchat/ola/vn/message/r;->a()Lchat/ola/vn/entity/u;

    move-result-object v1

    invoke-virtual {v1}, Lchat/ola/vn/entity/u;->c()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    const/4 v3, 0x0

    if-eqz v2, :cond_1

    iget-object v1, p0, Lchat/ola/vn/entry/b/r;->u:Landroid/widget/TextView;

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    goto :goto_2

    :cond_1
    iget-object v2, p0, Lchat/ola/vn/entry/b/r;->u:Landroid/widget/TextView;

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v2, p0, Lchat/ola/vn/entry/b/r;->u:Landroid/widget/TextView;

    invoke-virtual {v2, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :goto_2
    iget-object v1, p0, Lchat/ola/vn/entry/b/r;->C:Lchat/ola/vn/message/r;

    invoke-virtual {v1}, Lchat/ola/vn/message/r;->a()Lchat/ola/vn/entity/u;

    move-result-object v1

    invoke-virtual {v1}, Lchat/ola/vn/entity/u;->j()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_2

    iget-object v1, p0, Lchat/ola/vn/entry/b/r;->v:Landroid/widget/TextView;

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    goto :goto_3

    :cond_2
    iget-object v2, p0, Lchat/ola/vn/entry/b/r;->v:Landroid/widget/TextView;

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v2, p0, Lchat/ola/vn/entry/b/r;->v:Landroid/widget/TextView;

    invoke-virtual {v2, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :goto_3
    iget-object v1, p0, Lchat/ola/vn/entry/b/r;->C:Lchat/ola/vn/message/r;

    invoke-virtual {v1}, Lchat/ola/vn/message/r;->a()Lchat/ola/vn/entity/u;

    move-result-object v1

    invoke-virtual {v1}, Lchat/ola/vn/entity/u;->d()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_3

    iget-object v1, p0, Lchat/ola/vn/entry/b/r;->t:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v1, v0}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    return-void

    :cond_3
    iget-object v1, p0, Lchat/ola/vn/entry/b/r;->t:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v1, v3}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/entry/b/r;->C:Lchat/ola/vn/message/r;

    invoke-virtual {v2}, Lchat/ola/vn/message/r;->a()Lchat/ola/vn/entity/u;

    move-result-object v2

    invoke-virtual {v2}, Lchat/ola/vn/entity/u;->d()Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lchat/ola/vn/entry/b/r;->t:Lchat/ola/vn/view/OlaCachedImageView;

    const/16 v4, 0x1e0

    invoke-virtual {v1, v2, v3, v4}, Lchat/ola/vn/c/t;->b(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    iget-object v1, p0, Lchat/ola/vn/entry/b/r;->u:Landroid/widget/TextView;

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/r;->t:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v1, v0}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/r;->v:Landroid/widget/TextView;

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    return-void
.end method

.method private h()V
    .locals 4

    const/16 v0, 0x8

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/entry/b/r;->H:Landroid/view/View;

    iget-object v2, p0, Lchat/ola/vn/entry/b/r;->D:Lchat/ola/vn/message/i;

    invoke-virtual {v1, v2}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/r;->H:Landroid/view/View;

    iget-object v2, p0, Lchat/ola/vn/entry/b/r;->b:Landroid/view/View$OnLongClickListener;

    invoke-virtual {v1, v2}, Landroid/view/View;->setOnLongClickListener(Landroid/view/View$OnLongClickListener;)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/r;->D:Lchat/ola/vn/message/i;

    invoke-virtual {v1}, Lchat/ola/vn/message/i;->d()B

    move-result v1

    const/4 v2, 0x2

    if-ne v1, v2, :cond_0

    iget-object v1, p0, Lchat/ola/vn/entry/b/r;->u:Landroid/widget/TextView;

    sget v2, Lchat/ola/vn/f;->C:I

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/r;->v:Landroid/widget/TextView;

    sget v2, Lchat/ola/vn/f;->D:I

    :goto_0
    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setTextColor(I)V

    goto :goto_1

    :cond_0
    iget-object v1, p0, Lchat/ola/vn/entry/b/r;->u:Landroid/widget/TextView;

    sget v2, Lchat/ola/vn/f;->y:I

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/r;->v:Landroid/widget/TextView;

    sget v2, Lchat/ola/vn/f;->z:I

    goto :goto_0

    :goto_1
    iget-object v1, p0, Lchat/ola/vn/entry/b/r;->D:Lchat/ola/vn/message/i;

    invoke-virtual {v1}, Lchat/ola/vn/message/i;->a()Lchat/ola/vn/entity/z;

    move-result-object v1

    iget-object v1, v1, Lchat/ola/vn/entity/z;->c:Ljava/lang/String;

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    const/4 v3, 0x0

    if-eqz v2, :cond_1

    iget-object v1, p0, Lchat/ola/vn/entry/b/r;->u:Landroid/widget/TextView;

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    goto :goto_2

    :cond_1
    iget-object v2, p0, Lchat/ola/vn/entry/b/r;->u:Landroid/widget/TextView;

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v2, p0, Lchat/ola/vn/entry/b/r;->u:Landroid/widget/TextView;

    invoke-virtual {v2, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :goto_2
    iget-object v1, p0, Lchat/ola/vn/entry/b/r;->D:Lchat/ola/vn/message/i;

    invoke-virtual {v1}, Lchat/ola/vn/message/i;->a()Lchat/ola/vn/entity/z;

    move-result-object v1

    iget-object v1, v1, Lchat/ola/vn/entity/z;->e:Ljava/lang/String;

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_2

    iget-object v1, p0, Lchat/ola/vn/entry/b/r;->v:Landroid/widget/TextView;

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    goto :goto_3

    :cond_2
    iget-object v2, p0, Lchat/ola/vn/entry/b/r;->v:Landroid/widget/TextView;

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v2, p0, Lchat/ola/vn/entry/b/r;->v:Landroid/widget/TextView;

    invoke-virtual {v2, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :goto_3
    iget-object v1, p0, Lchat/ola/vn/entry/b/r;->D:Lchat/ola/vn/message/i;

    invoke-virtual {v1}, Lchat/ola/vn/message/i;->a()Lchat/ola/vn/entity/z;

    move-result-object v1

    iget-object v1, v1, Lchat/ola/vn/entity/z;->f:Ljava/lang/String;

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_3

    iget-object v1, p0, Lchat/ola/vn/entry/b/r;->t:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v1, v0}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    return-void

    :cond_3
    iget-object v1, p0, Lchat/ola/vn/entry/b/r;->t:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v1, v3}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    iget-object v1, p0, Lchat/ola/vn/entry/b/r;->t:Lchat/ola/vn/view/OlaCachedImageView;

    check-cast v1, Lchat/ola/vn/view/OlaRatioImageView;

    const-wide v2, 0x3ffc71c71c71c71cL    # 1.7777777777777777

    invoke-virtual {v1, v2, v3}, Lchat/ola/vn/view/OlaRatioImageView;->setRatio(D)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :try_start_2
    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/entry/b/r;->D:Lchat/ola/vn/message/i;

    invoke-virtual {v2}, Lchat/ola/vn/message/i;->a()Lchat/ola/vn/entity/z;

    move-result-object v2

    iget-object v2, v2, Lchat/ola/vn/entity/z;->f:Ljava/lang/String;

    iget-object v3, p0, Lchat/ola/vn/entry/b/r;->t:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v1, v2, v3}, Lchat/ola/vn/c/t;->b(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    return-void

    :catch_1
    iget-object v1, p0, Lchat/ola/vn/entry/b/r;->u:Landroid/widget/TextView;

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/r;->t:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v1, v0}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/r;->v:Landroid/widget/TextView;

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    return-void
.end method

.method private i()V
    .locals 4

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/r;->C:Lchat/ola/vn/message/r;

    invoke-virtual {v0}, Lchat/ola/vn/message/r;->d()B

    move-result v0

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Lchat/ola/vn/entry/b/r;->z:Landroid/widget/TextView;

    sget v1, Lchat/ola/vn/f;->E:I

    :goto_0
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    goto :goto_1

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/r;->z:Landroid/widget/TextView;

    sget v1, Lchat/ola/vn/f;->A:I

    goto :goto_0

    :goto_1
    iget-object v0, p0, Lchat/ola/vn/entry/b/r;->C:Lchat/ola/vn/message/r;

    invoke-virtual {v0}, Lchat/ola/vn/message/r;->a()Lchat/ola/vn/entity/u;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/entity/u;->b()Lchat/ola/vn/entity/f;

    move-result-object v0

    const/4 v1, 0x0

    if-eqz v0, :cond_3

    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lchat/ola/vn/entry/b/r;->a(Z)V

    iget-object v2, p0, Lchat/ola/vn/entry/b/r;->I:Landroid/view/View;

    iget-object v3, p0, Lchat/ola/vn/entry/b/r;->C:Lchat/ola/vn/message/r;

    invoke-virtual {v2, v3}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object v2, p0, Lchat/ola/vn/entry/b/r;->C:Lchat/ola/vn/message/r;

    invoke-virtual {v2}, Lchat/ola/vn/message/r;->a()Lchat/ola/vn/entity/u;

    move-result-object v2

    invoke-virtual {v2}, Lchat/ola/vn/entity/u;->e()I

    move-result v2

    if-lez v2, :cond_2

    iget-object v2, p0, Lchat/ola/vn/entry/b/r;->z:Landroid/widget/TextView;

    invoke-virtual {v2, v1}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/r;->C:Lchat/ola/vn/message/r;

    invoke-virtual {v1}, Lchat/ola/vn/message/r;->a()Lchat/ola/vn/entity/u;

    move-result-object v1

    invoke-virtual {v1}, Lchat/ola/vn/entity/u;->e()I

    move-result v1

    if-le v1, v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/entry/b/r;->z:Landroid/widget/TextView;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v2, p0, Lchat/ola/vn/entry/b/r;->C:Lchat/ola/vn/message/r;

    invoke-virtual {v2}, Lchat/ola/vn/message/r;->a()Lchat/ola/vn/entity/u;

    move-result-object v2

    invoke-virtual {v2}, Lchat/ola/vn/entity/u;->e()I

    move-result v2

    int-to-long v2, v2

    invoke-static {v2, v3}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, " "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v2, 0x7f0f0487

    invoke-static {v2}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :goto_2
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_3

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/entry/b/r;->z:Landroid/widget/TextView;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v2, p0, Lchat/ola/vn/entry/b/r;->C:Lchat/ola/vn/message/r;

    invoke-virtual {v2}, Lchat/ola/vn/message/r;->a()Lchat/ola/vn/entity/u;

    move-result-object v2

    invoke-virtual {v2}, Lchat/ola/vn/entity/u;->e()I

    move-result v2

    int-to-long v2, v2

    invoke-static {v2, v3}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, " "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v2, 0x7f0f0486

    invoke-static {v2}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_2

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/entry/b/r;->z:Landroid/widget/TextView;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    :goto_3
    iget-object v0, p0, Lchat/ola/vn/entry/b/r;->C:Lchat/ola/vn/message/r;

    invoke-direct {p0, v0}, Lchat/ola/vn/entry/b/r;->b(Lchat/ola/vn/message/r;)V

    return-void

    :cond_3
    invoke-direct {p0, v1}, Lchat/ola/vn/entry/b/r;->a(Z)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/message/d;Lchat/ola/vn/message/d;Lchat/ola/vn/message/d;)V
    .locals 0
    .annotation build Landroid/annotation/TargetApi;
        value = 0xb
    .end annotation

    invoke-super {p0, p1, p2, p3}, Lchat/ola/vn/entry/b/f;->a(Lchat/ola/vn/message/d;Lchat/ola/vn/message/d;Lchat/ola/vn/message/d;)V

    :try_start_0
    move-object p2, p1

    check-cast p2, Lchat/ola/vn/message/r;

    invoke-direct {p0, p2}, Lchat/ola/vn/entry/b/r;->a(Lchat/ola/vn/message/r;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    :try_start_1
    check-cast p1, Lchat/ola/vn/message/i;

    invoke-direct {p0, p1}, Lchat/ola/vn/entry/b/r;->a(Lchat/ola/vn/message/i;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 8

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v0

    const v1, 0x7f09043e

    if-eq v0, v1, :cond_5

    packed-switch v0, :pswitch_data_0

    return-void

    :pswitch_0
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/message/r;

    invoke-virtual {p1}, Lchat/ola/vn/message/r;->y()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_6

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const v1, 0x7f0f062b

    invoke-static {v1}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    sget-object v2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    invoke-virtual/range {v2 .. v7}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Ljava/lang/String;SLjava/lang/String;S)V

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object p1

    const v0, 0x7f0f00a2

    const v1, 0x7f0f035c

    invoke-static {p1, v0, v1}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;II)Landroid/app/Dialog;

    return-void

    :pswitch_1
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/message/r;

    invoke-virtual {p1}, Lchat/ola/vn/message/r;->a()Lchat/ola/vn/entity/u;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/entity/u;->b()Lchat/ola/vn/entity/f;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/entity/f;->a()Z

    move-result v0

    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {p1}, Lchat/ola/vn/message/r;->a()Lchat/ola/vn/entity/u;

    move-result-object v2

    invoke-virtual {v2}, Lchat/ola/vn/entity/u;->a()J

    move-result-wide v2

    xor-int/lit8 v4, v0, 0x1

    invoke-virtual {v1, v2, v3, v4}, Lchat/ola/vn/network/OlaNetworkService;->b(JZ)Z

    move-result v1

    if-nez v1, :cond_0

    return-void

    :cond_0
    invoke-virtual {p1}, Lchat/ola/vn/message/r;->a()Lchat/ola/vn/entity/u;

    move-result-object v1

    invoke-virtual {v1}, Lchat/ola/vn/entity/u;->b()Lchat/ola/vn/entity/f;

    move-result-object v1

    invoke-virtual {v1}, Lchat/ola/vn/entity/f;->b()Z

    move-result v1

    invoke-virtual {p1}, Lchat/ola/vn/message/r;->a()Lchat/ola/vn/entity/u;

    move-result-object v2

    invoke-virtual {v2}, Lchat/ola/vn/entity/u;->f()I

    move-result v2

    invoke-virtual {p1}, Lchat/ola/vn/message/r;->a()Lchat/ola/vn/entity/u;

    move-result-object v3

    invoke-virtual {v3}, Lchat/ola/vn/entity/u;->i()I

    move-result v3

    const/4 v4, 0x0

    const/4 v5, 0x1

    if-eqz v0, :cond_1

    invoke-virtual {p1}, Lchat/ola/vn/message/r;->a()Lchat/ola/vn/entity/u;

    move-result-object v6

    invoke-virtual {v6}, Lchat/ola/vn/entity/u;->b()Lchat/ola/vn/entity/f;

    move-result-object v6

    invoke-virtual {v6, v4}, Lchat/ola/vn/entity/f;->a(S)V

    goto :goto_0

    :cond_1
    invoke-virtual {p1}, Lchat/ola/vn/message/r;->a()Lchat/ola/vn/entity/u;

    move-result-object v6

    invoke-virtual {v6}, Lchat/ola/vn/entity/u;->b()Lchat/ola/vn/entity/f;

    move-result-object v6

    invoke-virtual {v6, v5}, Lchat/ola/vn/entity/f;->a(S)V

    :goto_0
    if-eqz v1, :cond_2

    add-int/lit8 v3, v3, -0x1

    if-gez v3, :cond_2

    const/4 v3, 0x0

    :cond_2
    if-eqz v0, :cond_4

    add-int/lit8 v0, v2, -0x1

    if-gez v0, :cond_3

    goto :goto_1

    :cond_3
    move v4, v0

    goto :goto_1

    :cond_4
    add-int/lit8 v4, v2, 0x1

    :goto_1
    invoke-virtual {p1}, Lchat/ola/vn/message/r;->a()Lchat/ola/vn/entity/u;

    move-result-object v0

    invoke-virtual {v0, v4}, Lchat/ola/vn/entity/u;->b(I)V

    invoke-virtual {p1}, Lchat/ola/vn/message/r;->a()Lchat/ola/vn/entity/u;

    move-result-object v0

    invoke-virtual {v0, v3}, Lchat/ola/vn/entity/u;->c(I)V

    invoke-direct {p0, p1}, Lchat/ola/vn/entry/b/r;->b(Lchat/ola/vn/message/r;)V

    return-void

    :cond_5
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/message/r;

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v0

    invoke-virtual {p1}, Lchat/ola/vn/message/r;->a()Lchat/ola/vn/entity/u;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/entity/u;->a()J

    move-result-wide v1

    invoke-static {v0, v1, v2}, Lchat/ola/vn/me/OlaMeComposerActivity;->a(Landroid/content/Context;J)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_6
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x7f090442
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
