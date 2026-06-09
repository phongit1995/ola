.class public Lchat/ola/vn/entry/b/m;
.super Lchat/ola/vn/entry/b/l;


# instance fields
.field private a:Landroid/widget/TextView;

.field private e:Landroid/widget/ImageView;

.field private f:Landroid/widget/TextView;

.field private g:Landroid/view/View;

.field private h:Landroid/widget/TextView;

.field private i:Landroid/view/View;

.field private j:Landroid/view/View;

.field private k:Lchat/ola/vn/entity/t;

.field private l:Landroid/view/View;

.field private m:Lchat/ola/vn/view/OlaCachedImageView;

.field private n:Lchat/ola/vn/view/OlaCachedImageView;

.field private o:Lchat/ola/vn/view/OlaCachedImageView;


# direct methods
.method public constructor <init>(Landroid/view/View;)V
    .locals 1

    invoke-direct {p0, p1}, Lchat/ola/vn/entry/b/l;-><init>(Landroid/view/View;)V

    const v0, 0x7f090569

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/entry/b/m;->a:Landroid/widget/TextView;

    const v0, 0x7f090568

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    iput-object v0, p0, Lchat/ola/vn/entry/b/m;->e:Landroid/widget/ImageView;

    const v0, 0x7f09056a

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/entry/b/m;->f:Landroid/widget/TextView;

    const v0, 0x7f09056b

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/entry/b/m;->g:Landroid/view/View;

    const v0, 0x7f090567

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/entry/b/m;->h:Landroid/widget/TextView;

    const v0, 0x7f090100

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/entry/b/m;->i:Landroid/view/View;

    const v0, 0x7f09046c

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/entry/b/m;->j:Landroid/view/View;

    const v0, 0x7f0900ff

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/entry/b/m;->l:Landroid/view/View;

    const v0, 0x7f09029b

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object v0, p0, Lchat/ola/vn/entry/b/m;->m:Lchat/ola/vn/view/OlaCachedImageView;

    const v0, 0x7f09029c

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object v0, p0, Lchat/ola/vn/entry/b/m;->n:Lchat/ola/vn/view/OlaCachedImageView;

    const v0, 0x7f09029d

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object p1, p0, Lchat/ola/vn/entry/b/m;->o:Lchat/ola/vn/view/OlaCachedImageView;

    return-void
.end method

.method private a()V
    .locals 6

    iget-object v0, p0, Lchat/ola/vn/entry/b/m;->k:Lchat/ola/vn/entity/t;

    invoke-virtual {v0}, Lchat/ola/vn/entity/t;->s()I

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/entry/b/m;->l:Landroid/view/View;

    const/4 v1, 0x4

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/m;->l:Landroid/view/View;

    iget-object v1, p0, Lchat/ola/vn/entry/b/m;->k:Lchat/ola/vn/entity/t;

    invoke-virtual {v0, v1}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/m;->l:Landroid/view/View;

    iget-object v1, p0, Lchat/ola/vn/entry/b/m;->b:Landroid/view/View$OnClickListener;

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/m;->l:Landroid/view/View;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/m;->k:Lchat/ola/vn/entity/t;

    invoke-virtual {v0}, Lchat/ola/vn/entity/t;->s()I

    move-result v0

    const/4 v2, 0x3

    const/4 v3, 0x2

    const/16 v4, 0x8

    const/4 v5, 0x1

    if-lt v0, v2, :cond_1

    iget-object v0, p0, Lchat/ola/vn/entry/b/m;->m:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/m;->m:Lchat/ola/vn/view/OlaCachedImageView;

    iget-object v2, p0, Lchat/ola/vn/entry/b/m;->k:Lchat/ola/vn/entity/t;

    invoke-virtual {v2, v1}, Lchat/ola/vn/entity/t;->d(I)Ljava/lang/String;

    move-result-object v2

    invoke-direct {p0, v0, v2}, Lchat/ola/vn/entry/b/m;->a(Lchat/ola/vn/view/OlaCachedImageView;Ljava/lang/String;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/m;->n:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/m;->n:Lchat/ola/vn/view/OlaCachedImageView;

    iget-object v2, p0, Lchat/ola/vn/entry/b/m;->k:Lchat/ola/vn/entity/t;

    invoke-virtual {v2, v5}, Lchat/ola/vn/entity/t;->d(I)Ljava/lang/String;

    move-result-object v2

    invoke-direct {p0, v0, v2}, Lchat/ola/vn/entry/b/m;->a(Lchat/ola/vn/view/OlaCachedImageView;Ljava/lang/String;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/m;->o:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/m;->o:Lchat/ola/vn/view/OlaCachedImageView;

    iget-object v2, p0, Lchat/ola/vn/entry/b/m;->k:Lchat/ola/vn/entity/t;

    invoke-virtual {v2, v3}, Lchat/ola/vn/entity/t;->d(I)Ljava/lang/String;

    move-result-object v2

    invoke-direct {p0, v0, v2}, Lchat/ola/vn/entry/b/m;->a(Lchat/ola/vn/view/OlaCachedImageView;Ljava/lang/String;)V

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/entry/b/m;->o:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, v4}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    :goto_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/m;->k:Lchat/ola/vn/entity/t;

    invoke-virtual {v0}, Lchat/ola/vn/entity/t;->s()I

    move-result v0

    if-lt v0, v3, :cond_2

    iget-object v0, p0, Lchat/ola/vn/entry/b/m;->m:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/m;->m:Lchat/ola/vn/view/OlaCachedImageView;

    iget-object v2, p0, Lchat/ola/vn/entry/b/m;->k:Lchat/ola/vn/entity/t;

    invoke-virtual {v2, v1}, Lchat/ola/vn/entity/t;->d(I)Ljava/lang/String;

    move-result-object v2

    invoke-direct {p0, v0, v2}, Lchat/ola/vn/entry/b/m;->a(Lchat/ola/vn/view/OlaCachedImageView;Ljava/lang/String;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/m;->n:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/m;->n:Lchat/ola/vn/view/OlaCachedImageView;

    iget-object v2, p0, Lchat/ola/vn/entry/b/m;->k:Lchat/ola/vn/entity/t;

    invoke-virtual {v2, v5}, Lchat/ola/vn/entity/t;->d(I)Ljava/lang/String;

    move-result-object v2

    invoke-direct {p0, v0, v2}, Lchat/ola/vn/entry/b/m;->a(Lchat/ola/vn/view/OlaCachedImageView;Ljava/lang/String;)V

    goto :goto_1

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/entry/b/m;->n:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, v4}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    :goto_1
    iget-object v0, p0, Lchat/ola/vn/entry/b/m;->k:Lchat/ola/vn/entity/t;

    invoke-virtual {v0}, Lchat/ola/vn/entity/t;->s()I

    move-result v0

    if-lt v0, v5, :cond_3

    iget-object v0, p0, Lchat/ola/vn/entry/b/m;->m:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/m;->m:Lchat/ola/vn/view/OlaCachedImageView;

    iget-object v2, p0, Lchat/ola/vn/entry/b/m;->k:Lchat/ola/vn/entity/t;

    invoke-virtual {v2, v1}, Lchat/ola/vn/entity/t;->d(I)Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v0, v1}, Lchat/ola/vn/entry/b/m;->a(Lchat/ola/vn/view/OlaCachedImageView;Ljava/lang/String;)V

    return-void

    :cond_3
    iget-object v0, p0, Lchat/ola/vn/entry/b/m;->m:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, v4}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    return-void
.end method

.method private a(Lchat/ola/vn/view/OlaCachedImageView;Ljava/lang/String;)V
    .locals 1

    :try_start_0
    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    invoke-virtual {v0, p2, p1}, Lchat/ola/vn/c/t;->f(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/entry/c;I)V
    .locals 4

    invoke-virtual {p1}, Lchat/ola/vn/entry/c;->b()Lchat/ola/vn/entity/t;

    move-result-object p2

    iput-object p2, p0, Lchat/ola/vn/entry/b/m;->k:Lchat/ola/vn/entity/t;

    iget-object p2, p0, Lchat/ola/vn/entry/b/m;->g:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/entry/b/m;->k:Lchat/ola/vn/entity/t;

    invoke-virtual {p2, v0}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object p2, p0, Lchat/ola/vn/entry/b/m;->i:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/entry/b/m;->k:Lchat/ola/vn/entity/t;

    invoke-virtual {p2, v0}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object p2, p0, Lchat/ola/vn/entry/b/m;->j:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/entry/b/m;->k:Lchat/ola/vn/entity/t;

    invoke-virtual {p2, v0}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object p2, p0, Lchat/ola/vn/entry/b/m;->g:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/entry/b/m;->b:Landroid/view/View$OnClickListener;

    invoke-virtual {p2, v0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p2, p0, Lchat/ola/vn/entry/b/m;->i:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/entry/b/m;->b:Landroid/view/View$OnClickListener;

    invoke-virtual {p2, v0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p2, p0, Lchat/ola/vn/entry/b/m;->j:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/entry/b/m;->b:Landroid/view/View$OnClickListener;

    invoke-virtual {p2, v0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p2, p0, Lchat/ola/vn/entry/b/m;->k:Lchat/ola/vn/entity/t;

    invoke-virtual {p2}, Lchat/ola/vn/entity/t;->r()J

    move-result-wide v0

    const-wide/16 v2, 0x0

    cmp-long p2, v0, v2

    if-eqz p2, :cond_5

    iget-object p2, p0, Lchat/ola/vn/entry/b/m;->g:Landroid/view/View;

    const/4 v0, 0x0

    invoke-virtual {p2, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object p2, p0, Lchat/ola/vn/entry/b/m;->j:Landroid/view/View;

    invoke-virtual {p2, v0}, Landroid/view/View;->setVisibility(I)V

    invoke-virtual {p1}, Lchat/ola/vn/entry/c;->a()I

    move-result p2

    const/4 v0, 0x1

    if-nez p2, :cond_0

    iget-object p1, p0, Lchat/ola/vn/entry/b/m;->h:Landroid/widget/TextView;

    const-string p2, ""

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_1

    :cond_0
    invoke-virtual {p1}, Lchat/ola/vn/entry/c;->a()I

    move-result p2

    if-le p2, v0, :cond_1

    iget-object p2, p0, Lchat/ola/vn/entry/b/m;->h:Landroid/widget/TextView;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p1}, Lchat/ola/vn/entry/c;->a()I

    move-result p1

    int-to-long v2, p1

    invoke-static {v2, v3}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, " "

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const p1, 0x7f0f0487

    :goto_0
    invoke-static {p1}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_1

    :cond_1
    iget-object p2, p0, Lchat/ola/vn/entry/b/m;->h:Landroid/widget/TextView;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p1}, Lchat/ola/vn/entry/c;->a()I

    move-result p1

    int-to-long v2, p1

    invoke-static {v2, v3}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, " "

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const p1, 0x7f0f0486

    goto :goto_0

    :goto_1
    iget-object p1, p0, Lchat/ola/vn/entry/b/m;->k:Lchat/ola/vn/entity/t;

    invoke-virtual {p1}, Lchat/ola/vn/entity/t;->s()I

    move-result p1

    const p2, 0x7f080700

    if-lez p1, :cond_4

    iget-object v1, p0, Lchat/ola/vn/entry/b/m;->k:Lchat/ola/vn/entity/t;

    invoke-virtual {v1}, Lchat/ola/vn/entity/t;->v()S

    move-result v1

    if-ne v1, v0, :cond_2

    iget-object p2, p0, Lchat/ola/vn/entry/b/m;->e:Landroid/widget/ImageView;

    const v1, 0x7f080701

    invoke-virtual {p2, v1}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object p2, p0, Lchat/ola/vn/entry/b/m;->f:Landroid/widget/TextView;

    sget v1, Lchat/ola/vn/f;->H:I

    :goto_2
    invoke-virtual {p2, v1}, Landroid/widget/TextView;->setTextColor(I)V

    goto :goto_3

    :cond_2
    iget-object v1, p0, Lchat/ola/vn/entry/b/m;->e:Landroid/widget/ImageView;

    invoke-virtual {v1, p2}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object p2, p0, Lchat/ola/vn/entry/b/m;->f:Landroid/widget/TextView;

    sget v1, Lchat/ola/vn/f;->z:I

    goto :goto_2

    :goto_3
    if-le p1, v0, :cond_3

    iget-object p2, p0, Lchat/ola/vn/entry/b/m;->a:Landroid/widget/TextView;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    int-to-long v1, p1

    invoke-static {v1, v2}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, " "

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const p1, 0x7f0f0538

    :goto_4
    invoke-static {p1}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_5

    :cond_3
    iget-object p2, p0, Lchat/ola/vn/entry/b/m;->a:Landroid/widget/TextView;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    int-to-long v1, p1

    invoke-static {v1, v2}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, " "

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const p1, 0x7f0f0539

    goto :goto_4

    :cond_4
    iget-object p1, p0, Lchat/ola/vn/entry/b/m;->e:Landroid/widget/ImageView;

    invoke-virtual {p1, p2}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/m;->a:Landroid/widget/TextView;

    const-string p2, ""

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :goto_5
    invoke-direct {p0}, Lchat/ola/vn/entry/b/m;->a()V

    return-void

    :cond_5
    iget-object p1, p0, Lchat/ola/vn/entry/b/m;->i:Landroid/view/View;

    const/16 p2, 0x8

    invoke-virtual {p1, p2}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/m;->j:Landroid/view/View;

    invoke-virtual {p1, p2}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/m;->g:Landroid/view/View;

    invoke-virtual {p1, p2}, Landroid/view/View;->setVisibility(I)V

    return-void
.end method
