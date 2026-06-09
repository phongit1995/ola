.class public Lchat/ola/vn/entry/b/x;
.super Lchat/ola/vn/entry/b/j;


# instance fields
.field private i:Landroid/view/View;

.field private j:Lchat/ola/vn/view/OlaCachedImageView;

.field private k:Lchat/ola/vn/view/OlaRatioImageView;

.field private l:Landroid/widget/TextView;

.field private m:Landroid/widget/TextView;

.field private n:Lcom/mg/ola/common/widget/CommpressTextView;

.field private o:Landroid/widget/TextView;

.field private p:Landroid/widget/RatingBar;

.field private q:Lchat/ola/vn/entity/k;

.field private r:Landroid/view/View;

.field private s:Landroid/view/View;

.field private t:Landroid/widget/TextView;

.field private u:Landroid/widget/TextView;

.field private v:I

.field private w:Landroid/view/View$OnTouchListener;


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lchat/ola/vn/entry/b/j;-><init>()V

    const/4 v0, 0x0

    iput v0, p0, Lchat/ola/vn/entry/b/x;->v:I

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/entry/b/x;)Lchat/ola/vn/entity/k;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/entry/b/x;->q:Lchat/ola/vn/entity/k;

    return-object p0
.end method

.method static synthetic b(Lchat/ola/vn/entry/b/x;)Landroid/view/View;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/entry/b/x;->s:Landroid/view/View;

    return-object p0
.end method

.method static synthetic c(Lchat/ola/vn/entry/b/x;)Landroid/widget/TextView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/entry/b/x;->t:Landroid/widget/TextView;

    return-object p0
.end method

.method static synthetic d(Lchat/ola/vn/entry/b/x;)Landroid/widget/TextView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/entry/b/x;->u:Landroid/widget/TextView;

    return-object p0
.end method

.method private e()V
    .locals 3
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "NewApi"
        }
    .end annotation

    :try_start_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "http://img.youtube.com/vi/"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lchat/ola/vn/entry/b/x;->b:Lchat/ola/vn/entry/b;

    iget-object v1, v1, Lchat/ola/vn/entry/b;->m:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "/mqdefault.jpg"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/entry/b/x;->k:Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v1}, Lchat/ola/vn/view/OlaRatioImageView;->getWidth()I

    move-result v1

    const/16 v2, 0x190

    if-gt v1, v2, :cond_0

    sget-boolean v1, Lchat/ola/vn/h;->I:Z

    if-eqz v1, :cond_1

    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "http://img.youtube.com/vi/"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lchat/ola/vn/entry/b/x;->b:Lchat/ola/vn/entry/b;

    iget-object v1, v1, Lchat/ola/vn/entry/b;->m:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "/hqdefault.jpg"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    :cond_1
    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/entry/b/x;->k:Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v1, v0, v2}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/x;->q:Lchat/ola/vn/entity/k;

    iget-object v0, v0, Lchat/ola/vn/entity/k;->c:Ljava/lang/String;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/entry/b/x;->s:Landroid/view/View;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/x;->t:Landroid/widget/TextView;

    iget-object v1, p0, Lchat/ola/vn/entry/b/x;->q:Lchat/ola/vn/entity/k;

    iget-object v1, v1, Lchat/ola/vn/entity/k;->c:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/x;->u:Landroid/widget/TextView;

    iget-object v1, p0, Lchat/ola/vn/entry/b/x;->q:Lchat/ola/vn/entity/k;

    iget-object v1, v1, Lchat/ola/vn/entity/k;->d:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/entry/b/x;->s:Landroid/view/View;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/x;->t:Landroid/widget/TextView;

    const-string v1, ""

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/x;->u:Landroid/widget/TextView;

    const-string v1, ""

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    new-instance v0, Lchat/ola/vn/entry/b/x$3;

    invoke-direct {v0, p0}, Lchat/ola/vn/entry/b/x$3;-><init>(Lchat/ola/vn/entry/b/x;)V

    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v2, p0, Lchat/ola/vn/entry/b/x;->b:Lchat/ola/vn/entry/b;

    iget-object v2, v2, Lchat/ola/vn/entry/b;->m:Ljava/lang/String;

    invoke-virtual {v1, v2, v0}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Lchat/ola/vn/p/o;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private f()V
    .locals 4

    :try_start_0
    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/entry/b/x;->q:Lchat/ola/vn/entity/k;

    iget-object v1, v1, Lchat/ola/vn/entity/k;->k:Ljava/lang/String;

    iget-object v2, p0, Lchat/ola/vn/entry/b/x;->k:Lchat/ola/vn/view/OlaRatioImageView;

    iget v3, p0, Lchat/ola/vn/entry/b/x;->h:I

    invoke-virtual {v0, v1, v2, v3}, Lchat/ola/vn/c/t;->b(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/x;->k:Lchat/ola/vn/view/OlaRatioImageView;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaRatioImageView;->setVisibility(I)V

    return-void
.end method

.method private g()V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/x;->l:Landroid/widget/TextView;

    iget-object v1, p0, Lchat/ola/vn/entry/b/x;->q:Lchat/ola/vn/entity/k;

    iget-object v1, v1, Lchat/ola/vn/entity/k;->a:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/x;->m:Landroid/widget/TextView;

    iget-object v1, p0, Lchat/ola/vn/entry/b/x;->q:Lchat/ola/vn/entity/k;

    iget-object v1, v1, Lchat/ola/vn/entity/k;->e:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/x;->o:Landroid/widget/TextView;

    iget-object v1, p0, Lchat/ola/vn/entry/b/x;->q:Lchat/ola/vn/entity/k;

    iget-object v1, v1, Lchat/ola/vn/entity/k;->l:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/x;->q:Lchat/ola/vn/entity/k;

    iget-object v0, v0, Lchat/ola/vn/entity/k;->n:Ljava/lang/Float;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/entry/b/x;->p:Landroid/widget/RatingBar;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/RatingBar;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/x;->p:Landroid/widget/RatingBar;

    iget-object v1, p0, Lchat/ola/vn/entry/b/x;->q:Lchat/ola/vn/entity/k;

    iget-object v1, v1, Lchat/ola/vn/entity/k;->n:Ljava/lang/Float;

    invoke-virtual {v1}, Ljava/lang/Float;->floatValue()F

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/RatingBar;->setRating(F)V

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/x;->p:Landroid/widget/RatingBar;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/RatingBar;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private h()V
    .locals 4

    const/16 v0, 0x8

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/entry/b/x;->q:Lchat/ola/vn/entity/k;

    iget-object v1, v1, Lchat/ola/vn/entity/k;->j:Ljava/lang/String;

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/entry/b/x;->j:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v1, v0}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    return-void

    :cond_0
    iget-object v1, p0, Lchat/ola/vn/entry/b/x;->j:Lchat/ola/vn/view/OlaCachedImageView;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/entry/b/x;->q:Lchat/ola/vn/entity/k;

    iget-object v2, v2, Lchat/ola/vn/entity/k;->j:Ljava/lang/String;

    iget-object v3, p0, Lchat/ola/vn/entry/b/x;->j:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v1, v2, v3}, Lchat/ola/vn/c/t;->c(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    iget-object v1, p0, Lchat/ola/vn/entry/b/x;->j:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v1, v0}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    return-void
.end method

.method private i()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/entry/b/x;->n:Lcom/mg/ola/common/widget/CommpressTextView;

    iget-object v1, p0, Lchat/ola/vn/entry/b/x;->b:Lchat/ola/vn/entry/b;

    iget-object v1, v1, Lchat/ola/vn/entry/b;->c:Ljava/lang/CharSequence;

    invoke-virtual {v0, v1}, Lcom/mg/ola/common/widget/CommpressTextView;->setFullText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/x;->n:Lcom/mg/ola/common/widget/CommpressTextView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/mg/ola/common/widget/CommpressTextView;->setOnEclipesizeListener(Lcom/mg/ola/common/widget/CommpressTextView$a;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/x;->n:Lcom/mg/ola/common/widget/CommpressTextView;

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/CommpressTextView;->a()V

    return-void
.end method


# virtual methods
.method public a()V
    .locals 3
    .annotation build Landroid/annotation/TargetApi;
        value = 0xb
    .end annotation

    iget-object v0, p0, Lchat/ola/vn/entry/b/x;->b:Lchat/ola/vn/entry/b;

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/x;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    iget-object v0, v0, Lchat/ola/vn/entity/g;->a:Lchat/ola/vn/entity/k;

    iput-object v0, p0, Lchat/ola/vn/entry/b/x;->q:Lchat/ola/vn/entity/k;

    iget-object v0, p0, Lchat/ola/vn/entry/b/x;->q:Lchat/ola/vn/entity/k;

    if-nez v0, :cond_1

    return-void

    :cond_1
    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/x;->a:Landroid/view/View$OnClickListener;

    if-eqz v0, :cond_3

    new-instance v0, Lchat/ola/vn/entry/b/x$1;

    invoke-direct {v0, p0}, Lchat/ola/vn/entry/b/x$1;-><init>(Lchat/ola/vn/entry/b/x;)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/x;->i:Landroid/view/View;

    invoke-virtual {v1, v0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/x;->w:Landroid/view/View$OnTouchListener;

    if-nez v1, :cond_2

    new-instance v1, Lchat/ola/vn/entry/b/x$2;

    invoke-direct {v1, p0}, Lchat/ola/vn/entry/b/x$2;-><init>(Lchat/ola/vn/entry/b/x;)V

    iput-object v1, p0, Lchat/ola/vn/entry/b/x;->w:Landroid/view/View$OnTouchListener;

    :cond_2
    iget-object v1, p0, Lchat/ola/vn/entry/b/x;->p:Landroid/widget/RatingBar;

    iget-object v2, p0, Lchat/ola/vn/entry/b/x;->w:Landroid/view/View$OnTouchListener;

    invoke-virtual {v1, v2}, Landroid/widget/RatingBar;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/x;->r:Landroid/view/View;

    invoke-virtual {v1, v0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_3
    invoke-direct {p0}, Lchat/ola/vn/entry/b/x;->g()V

    invoke-direct {p0}, Lchat/ola/vn/entry/b/x;->h()V

    invoke-direct {p0}, Lchat/ola/vn/entry/b/x;->i()V

    iget-object v0, p0, Lchat/ola/vn/entry/b/x;->q:Lchat/ola/vn/entity/k;

    iget-object v0, v0, Lchat/ola/vn/entity/k;->b:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x0

    if-nez v0, :cond_4

    iget-object v0, p0, Lchat/ola/vn/entry/b/x;->b:Lchat/ola/vn/entry/b;

    iget-object v2, p0, Lchat/ola/vn/entry/b/x;->q:Lchat/ola/vn/entity/k;

    iget-object v2, v2, Lchat/ola/vn/entity/k;->b:Ljava/lang/String;

    iput-object v2, v0, Lchat/ola/vn/entry/b;->m:Ljava/lang/String;

    iget-object v0, p0, Lchat/ola/vn/entry/b/x;->r:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/x;->s:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    invoke-direct {p0}, Lchat/ola/vn/entry/b/x;->e()V

    return-void

    :cond_4
    iget-object v0, p0, Lchat/ola/vn/entry/b/x;->q:Lchat/ola/vn/entity/k;

    iget-object v0, v0, Lchat/ola/vn/entity/k;->k:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    const/16 v2, 0x8

    if-nez v0, :cond_5

    iget-object v0, p0, Lchat/ola/vn/entry/b/x;->r:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/x;->s:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    invoke-direct {p0}, Lchat/ola/vn/entry/b/x;->f()V

    return-void

    :cond_5
    iget-object v0, p0, Lchat/ola/vn/entry/b/x;->r:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    return-void
.end method

.method public a(Landroid/view/View;)V
    .locals 1

    invoke-super {p0, p1}, Lchat/ola/vn/entry/b/j;->a(Landroid/view/View;)V

    const v0, 0x7f090048

    :try_start_0
    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/entry/b/x;->i:Landroid/view/View;

    const v0, 0x7f090052

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/entry/b/x;->r:Landroid/view/View;

    const v0, 0x7f090051

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/entry/b/x;->s:Landroid/view/View;

    const v0, 0x7f090049

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object v0, p0, Lchat/ola/vn/entry/b/x;->j:Lchat/ola/vn/view/OlaCachedImageView;

    const v0, 0x7f09004a

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaRatioImageView;

    iput-object v0, p0, Lchat/ola/vn/entry/b/x;->k:Lchat/ola/vn/view/OlaRatioImageView;

    const v0, 0x7f09004f

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/entry/b/x;->l:Landroid/widget/TextView;

    const v0, 0x7f09004c

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lcom/mg/ola/common/widget/CommpressTextView;

    iput-object v0, p0, Lchat/ola/vn/entry/b/x;->n:Lcom/mg/ola/common/widget/CommpressTextView;

    const v0, 0x7f09004e

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/entry/b/x;->m:Landroid/widget/TextView;

    const v0, 0x7f09004b

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/entry/b/x;->o:Landroid/widget/TextView;

    const v0, 0x7f09004d

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/RatingBar;

    iput-object v0, p0, Lchat/ola/vn/entry/b/x;->p:Landroid/widget/RatingBar;

    const v0, 0x7f090054

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/entry/b/x;->t:Landroid/widget/TextView;

    const v0, 0x7f090050

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/entry/b/x;->u:Landroid/widget/TextView;

    invoke-virtual {p1}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object p1

    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p1

    const v0, 0x7f070141

    invoke-virtual {p1, v0}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result p1

    iput p1, p0, Lchat/ola/vn/entry/b/x;->v:I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
