.class public Lchat/ola/vn/checkin/OlaVenueDetailActivity;
.super Lchat/ola/vn/c;

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Lchat/ola/vn/b/j$a;
.implements Lchat/ola/vn/p/a;
.implements Lchat/ola/vn/r/a/d;


# instance fields
.field private A:Ljava/lang/Runnable;

.field private B:Landroid/view/View;

.field private C:J

.field private D:Z

.field private E:Z

.field private F:Ljava/lang/String;

.field private G:Lchat/ola/vn/e/c;

.field protected e:Lchat/ola/vn/entity/y;

.field protected f:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

.field protected g:Landroid/widget/TextView;

.field protected h:Landroid/widget/TextView;

.field protected i:Landroid/widget/TextView;

.field protected j:Landroid/widget/TextView;

.field protected k:Landroid/view/View;

.field protected l:Landroid/widget/TextView;

.field protected m:Landroid/widget/ListView;

.field protected n:Lchat/ola/vn/b/u;

.field protected o:Lchat/ola/vn/r/a/e;

.field protected p:Lchat/ola/vn/view/OlaRatioImageView;

.field protected q:Lchat/ola/vn/view/OlaRatioImageView;

.field protected r:Lchat/ola/vn/view/OlaCachedImageView;

.field protected s:Landroid/view/View;

.field protected t:Landroid/view/View;

.field protected u:Landroid/view/View;

.field protected v:Landroid/widget/TextView;

.field protected w:[Lchat/ola/vn/view/OlaCachedImageView;

.field private x:Lchat/ola/vn/b/q;

.field private y:Landroid/support/v4/widget/SwipeRefreshLayout;

.field private z:Z


# direct methods
.method public constructor <init>()V
    .locals 4

    invoke-direct {p0}, Lchat/ola/vn/c;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->z:Z

    const/4 v1, 0x0

    iput-object v1, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->A:Ljava/lang/Runnable;

    const-wide/16 v2, 0x0

    iput-wide v2, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->C:J

    const/4 v2, 0x1

    iput-boolean v2, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->D:Z

    iput-boolean v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->E:Z

    iput-object v1, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->G:Lchat/ola/vn/e/c;

    return-void
.end method

.method private F()V
    .locals 7

    const v0, 0x7f09039a

    :try_start_0
    invoke-virtual {p0, v0}, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f090030

    invoke-virtual {p0, v0}, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f0903f3

    invoke-virtual {p0, v0}, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/support/v4/widget/SwipeRefreshLayout;

    iput-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->y:Landroid/support/v4/widget/SwipeRefreshLayout;

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->y:Landroid/support/v4/widget/SwipeRefreshLayout;

    const/4 v1, 0x1

    new-array v2, v1, [I

    const v3, 0x7f06003d

    const/4 v4, 0x0

    aput v3, v2, v4

    invoke-virtual {v0, v2}, Landroid/support/v4/widget/SwipeRefreshLayout;->setColorSchemeResources([I)V

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->y:Landroid/support/v4/widget/SwipeRefreshLayout;

    new-instance v2, Lchat/ola/vn/checkin/OlaVenueDetailActivity$1;

    invoke-direct {v2, p0}, Lchat/ola/vn/checkin/OlaVenueDetailActivity$1;-><init>(Lchat/ola/vn/checkin/OlaVenueDetailActivity;)V

    invoke-virtual {v0, v2}, Landroid/support/v4/widget/SwipeRefreshLayout;->setOnRefreshListener(Landroid/support/v4/widget/SwipeRefreshLayout$OnRefreshListener;)V

    const v0, 0x7f090450

    invoke-virtual {p0, v0}, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    iput-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->f:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->f:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    new-instance v2, Lchat/ola/vn/checkin/OlaVenueDetailActivity$2;

    invoke-direct {v2, p0}, Lchat/ola/vn/checkin/OlaVenueDetailActivity$2;-><init>(Lchat/ola/vn/checkin/OlaVenueDetailActivity;)V

    invoke-virtual {v0, v2}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setOnEditorActionListener(Landroid/widget/TextView$OnEditorActionListener;)V

    new-instance v0, Lchat/ola/vn/b/q;

    invoke-direct {v0, p0}, Lchat/ola/vn/b/q;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->x:Lchat/ola/vn/b/q;

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->x:Lchat/ola/vn/b/q;

    invoke-static {}, Lchat/ola/vn/g;->a()Ljava/util/List;

    move-result-object v2

    invoke-virtual {v0, v2}, Lchat/ola/vn/b/q;->a(Ljava/util/List;)V

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->x:Lchat/ola/vn/b/q;

    new-instance v2, Lchat/ola/vn/b/q$a;

    iget-object v3, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->x:Lchat/ola/vn/b/q;

    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    invoke-direct {v2, v3}, Lchat/ola/vn/b/q$a;-><init>(Lchat/ola/vn/b/q;)V

    invoke-virtual {v0, v2}, Lchat/ola/vn/b/q;->a(Landroid/widget/Filter;)V

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->f:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    iget-object v2, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->x:Lchat/ola/vn/b/q;

    invoke-virtual {v0, v2}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setAdapter(Landroid/widget/BaseAdapter;)V

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->f:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    new-instance v2, Lchat/ola/vn/checkin/OlaVenueDetailActivity$3;

    invoke-direct {v2, p0}, Lchat/ola/vn/checkin/OlaVenueDetailActivity$3;-><init>(Lchat/ola/vn/checkin/OlaVenueDetailActivity;)V

    invoke-virtual {v0, v2}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setOnSuggestionSelectListener(Lchat/ola/vn/view/OlaQuickTypingSuggestedText$b;)V

    const v0, 0x7f0903b0

    invoke-virtual {p0, v0}, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ListView;

    iput-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->m:Landroid/widget/ListView;

    const v0, 0x7f090609

    invoke-virtual {p0, v0}, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->t:Landroid/view/View;

    new-instance v0, Lchat/ola/vn/r/a/e;

    invoke-direct {v0}, Lchat/ola/vn/r/a/e;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->o:Lchat/ola/vn/r/a/e;

    new-instance v0, Lchat/ola/vn/b/u;

    iget-object v2, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->o:Lchat/ola/vn/r/a/e;

    invoke-direct {v0, p0, v2}, Lchat/ola/vn/b/u;-><init>(Landroid/content/Context;Lchat/ola/vn/r/a/e;)V

    iput-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->n:Lchat/ola/vn/b/u;

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->n:Lchat/ola/vn/b/u;

    invoke-virtual {v0, p0}, Lchat/ola/vn/b/u;->a(Lchat/ola/vn/b/j$a;)V

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->n:Lchat/ola/vn/b/u;

    new-instance v2, Lchat/ola/vn/checkin/OlaVenueDetailActivity$4;

    invoke-direct {v2, p0}, Lchat/ola/vn/checkin/OlaVenueDetailActivity$4;-><init>(Lchat/ola/vn/checkin/OlaVenueDetailActivity;)V

    invoke-virtual {v0, v2}, Lchat/ola/vn/b/u;->a(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->n:Lchat/ola/vn/b/u;

    new-instance v2, Lchat/ola/vn/checkin/OlaVenueDetailActivity$5;

    invoke-direct {v2, p0}, Lchat/ola/vn/checkin/OlaVenueDetailActivity$5;-><init>(Lchat/ola/vn/checkin/OlaVenueDetailActivity;)V

    invoke-virtual {v0, v2}, Lchat/ola/vn/b/u;->a(Landroid/view/View$OnLongClickListener;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_2

    const/4 v0, 0x0

    :try_start_1
    invoke-static {p0}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v2

    const v3, 0x7f0b017f

    invoke-virtual {v2, v3, v0}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v2

    const v3, 0x7f09020e

    invoke-virtual {v2, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Landroid/widget/TextView;

    iput-object v3, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->h:Landroid/widget/TextView;

    const v3, 0x7f0901d5

    invoke-virtual {v2, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Lchat/ola/vn/view/OlaRatioImageView;

    iput-object v3, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->p:Lchat/ola/vn/view/OlaRatioImageView;

    iget-object v3, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->p:Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v3, p0}, Lchat/ola/vn/view/OlaRatioImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v3, 0x7f0903e7

    invoke-virtual {v2, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object v3, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->r:Lchat/ola/vn/view/OlaCachedImageView;

    iget-object v3, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->r:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v3, p0}, Lchat/ola/vn/view/OlaCachedImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v3, 0x7f0901b9

    invoke-virtual {v2, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Landroid/widget/TextView;

    iput-object v3, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->g:Landroid/widget/TextView;

    const v3, 0x7f0901e0

    invoke-virtual {v2, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Landroid/widget/TextView;

    iput-object v3, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->i:Landroid/widget/TextView;

    const v3, 0x7f090093

    invoke-virtual {v2, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Landroid/widget/TextView;

    iput-object v3, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->j:Landroid/widget/TextView;

    const v3, 0x7f090330

    invoke-virtual {v2, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    iput-object v3, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->s:Landroid/view/View;

    const v3, 0x7f0901e8

    invoke-virtual {v2, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    iput-object v3, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->k:Landroid/view/View;

    iget-object v3, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->k:Landroid/view/View;

    invoke-virtual {v3, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v3, 0x7f090037

    invoke-virtual {v2, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Landroid/widget/TextView;

    iput-object v3, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->l:Landroid/widget/TextView;

    const v3, 0x7f09032f

    invoke-virtual {v2, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Lchat/ola/vn/view/OlaRatioImageView;

    iput-object v3, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->q:Lchat/ola/vn/view/OlaRatioImageView;

    iget-object v3, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->q:Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v3, p0}, Lchat/ola/vn/view/OlaRatioImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v3, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->q:Lchat/ola/vn/view/OlaRatioImageView;

    const-wide v5, 0x400c71c71c71c71cL    # 3.5555555555555554

    invoke-virtual {v3, v5, v6}, Lchat/ola/vn/view/OlaRatioImageView;->setRatio(D)V

    const v3, 0x7f090351

    invoke-virtual {v2, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    iput-object v3, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->u:Landroid/view/View;

    iget-object v3, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->u:Landroid/view/View;

    invoke-virtual {v3, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v3, 0x7f090350

    invoke-virtual {v2, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Landroid/widget/TextView;

    iput-object v3, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->v:Landroid/widget/TextView;

    const/4 v3, 0x6

    new-array v3, v3, [Lchat/ola/vn/view/OlaCachedImageView;

    iput-object v3, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->w:[Lchat/ola/vn/view/OlaCachedImageView;

    iget-object v3, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->w:[Lchat/ola/vn/view/OlaCachedImageView;

    const v5, 0x7f090348

    invoke-virtual {v2, v5}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v5

    check-cast v5, Lchat/ola/vn/view/OlaCachedImageView;

    aput-object v5, v3, v4

    iget-object v3, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->w:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v3, v3, v4

    invoke-virtual {v3, p0}, Lchat/ola/vn/view/OlaCachedImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v3, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->w:[Lchat/ola/vn/view/OlaCachedImageView;

    const v4, 0x7f090349

    invoke-virtual {v2, v4}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v4

    check-cast v4, Lchat/ola/vn/view/OlaCachedImageView;

    aput-object v4, v3, v1

    iget-object v3, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->w:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v1, v3, v1

    invoke-virtual {v1, p0}, Lchat/ola/vn/view/OlaCachedImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v1, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->w:[Lchat/ola/vn/view/OlaCachedImageView;

    const v3, 0x7f09034c

    invoke-virtual {v2, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Lchat/ola/vn/view/OlaCachedImageView;

    const/4 v4, 0x2

    aput-object v3, v1, v4

    iget-object v1, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->w:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v1, v1, v4

    invoke-virtual {v1, p0}, Lchat/ola/vn/view/OlaCachedImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v1, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->w:[Lchat/ola/vn/view/OlaCachedImageView;

    const v3, 0x7f09034a

    invoke-virtual {v2, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Lchat/ola/vn/view/OlaCachedImageView;

    const/4 v4, 0x3

    aput-object v3, v1, v4

    iget-object v1, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->w:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v1, v1, v4

    invoke-virtual {v1, p0}, Lchat/ola/vn/view/OlaCachedImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v1, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->w:[Lchat/ola/vn/view/OlaCachedImageView;

    const v3, 0x7f09034b

    invoke-virtual {v2, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Lchat/ola/vn/view/OlaCachedImageView;

    const/4 v4, 0x4

    aput-object v3, v1, v4

    iget-object v1, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->w:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v1, v1, v4

    invoke-virtual {v1, p0}, Lchat/ola/vn/view/OlaCachedImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v1, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->w:[Lchat/ola/vn/view/OlaCachedImageView;

    const v3, 0x7f09034d

    invoke-virtual {v2, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Lchat/ola/vn/view/OlaCachedImageView;

    const/4 v4, 0x5

    aput-object v3, v1, v4

    iget-object v1, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->w:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v1, v1, v4

    invoke-virtual {v1, p0}, Lchat/ola/vn/view/OlaCachedImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v1, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->m:Landroid/widget/ListView;

    invoke-virtual {v1, v2}, Landroid/widget/ListView;->addHeaderView(Landroid/view/View;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :try_start_2
    invoke-static {p0}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v1

    const v2, 0x7f0b00d1

    invoke-virtual {v1, v2, v0}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->B:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->m:Landroid/widget/ListView;

    iget-object v1, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->B:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->addFooterView(Landroid/view/View;)V

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->B:Landroid/view/View;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    :try_start_3
    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->m:Landroid/widget/ListView;

    iget-object v1, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->n:Lchat/ola/vn/b/u;

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setAdapter(Landroid/widget/ListAdapter;)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_2

    :catch_2
    return-void
.end method

.method private G()V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->o:Lchat/ola/vn/r/a/e;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/e;->e()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->e:Lchat/ola/vn/entity/y;

    invoke-direct {p0}, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->H()V

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->n:Lchat/ola/vn/b/u;

    invoke-virtual {v0}, Lchat/ola/vn/b/u;->notifyDataSetChanged()V

    return-void
.end method

.method private H()V
    .locals 8

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->e:Lchat/ola/vn/entity/y;

    const/4 v1, 0x1

    const/4 v2, 0x0

    if-nez v0, :cond_1

    iget-boolean v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->z:Z

    if-nez v0, :cond_0

    invoke-direct {p0, v1}, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->c(Z)V

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->F:Ljava/lang/String;

    invoke-direct {p0, v0}, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->i(Ljava/lang/String;)V

    goto/16 :goto_5

    :cond_1
    invoke-direct {p0}, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->J()V

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->f:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    const/4 v3, 0x0

    invoke-virtual {v0, v3}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setAdapter(Landroid/widget/BaseAdapter;)V

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->f:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    iget-object v3, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->e:Lchat/ola/vn/entity/y;

    invoke-virtual {v3}, Lchat/ola/vn/entity/y;->b()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->f:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    iget-object v3, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->x:Lchat/ola/vn/b/q;

    invoke-virtual {v0, v3}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setAdapter(Landroid/widget/BaseAdapter;)V

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->g:Landroid/widget/TextView;

    iget-object v3, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->e:Lchat/ola/vn/entity/y;

    invoke-virtual {v3}, Lchat/ola/vn/entity/y;->b()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->e:Lchat/ola/vn/entity/y;

    invoke-virtual {v0}, Lchat/ola/vn/entity/y;->c()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    const/16 v3, 0x8

    if-nez v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->i:Landroid/widget/TextView;

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->i:Landroid/widget/TextView;

    iget-object v4, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->e:Lchat/ola/vn/entity/y;

    invoke-virtual {v4}, Lchat/ola/vn/entity/y;->c()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v0, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_0

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->i:Landroid/widget/TextView;

    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setVisibility(I)V

    :goto_0
    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->e:Lchat/ola/vn/entity/y;

    invoke-virtual {v0}, Lchat/ola/vn/entity/y;->k()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->j:Landroid/widget/TextView;

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->j:Landroid/widget/TextView;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "@"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v5, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->e:Lchat/ola/vn/entity/y;

    invoke-virtual {v5}, Lchat/ola/vn/entity/y;->k()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lchat/ola/vn/util/i;->c(Ljava/lang/String;)Ljava/lang/CharSequence;

    move-result-object v4

    invoke-virtual {v0, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_1

    :cond_3
    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->j:Landroid/widget/TextView;

    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setVisibility(I)V

    :goto_1
    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->e:Lchat/ola/vn/entity/y;

    invoke-virtual {v0}, Lchat/ola/vn/entity/y;->g()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_5

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->e:Lchat/ola/vn/entity/y;

    invoke-virtual {v0}, Lchat/ola/vn/entity/y;->f()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_5

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->s:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->e:Lchat/ola/vn/entity/y;

    invoke-virtual {v0}, Lchat/ola/vn/entity/y;->d()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_4

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->l:Landroid/widget/TextView;

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->l:Landroid/widget/TextView;

    iget-object v4, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->e:Lchat/ola/vn/entity/y;

    invoke-virtual {v4}, Lchat/ola/vn/entity/y;->d()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v0, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_2

    :cond_4
    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->l:Landroid/widget/TextView;

    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setVisibility(I)V

    :goto_2
    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->q:Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v0}, Lchat/ola/vn/view/OlaRatioImageView;->getWidth()I

    move-result v0

    iget-object v4, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->q:Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v4}, Lchat/ola/vn/view/OlaRatioImageView;->getHeight()I

    move-result v4

    iget-object v5, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->e:Lchat/ola/vn/entity/y;

    invoke-virtual {v5}, Lchat/ola/vn/entity/y;->g()Ljava/lang/String;

    move-result-object v5

    iget-object v6, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->e:Lchat/ola/vn/entity/y;

    invoke-virtual {v6}, Lchat/ola/vn/entity/y;->f()Ljava/lang/String;

    move-result-object v6

    const/16 v7, 0x11

    invoke-static {v5, v6, v0, v4, v7}, Lchat/ola/vn/c/f;->a(Ljava/lang/String;Ljava/lang/String;III)Lchat/ola/vn/c/f;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/c/f;->e()Ljava/lang/String;

    move-result-object v4

    iget-object v5, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->q:Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v5, v4}, Lchat/ola/vn/view/OlaRatioImageView;->a(Ljava/lang/String;)Z

    move-result v5

    if-nez v5, :cond_6

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v5

    new-instance v6, Lchat/ola/vn/checkin/OlaVenueDetailActivity$6;

    invoke-direct {v6, p0, v4, v0}, Lchat/ola/vn/checkin/OlaVenueDetailActivity$6;-><init>(Lchat/ola/vn/checkin/OlaVenueDetailActivity;Ljava/lang/String;Lchat/ola/vn/c/f;)V

    invoke-virtual {v5, v4, v6}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/c/w;)V

    goto :goto_3

    :cond_5
    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->s:Landroid/view/View;

    invoke-virtual {v0, v3}, Landroid/view/View;->setVisibility(I)V

    :cond_6
    :goto_3
    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/n/c;->e()Landroid/location/Location;

    move-result-object v0

    if-eqz v0, :cond_9

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->e:Lchat/ola/vn/entity/y;

    invoke-virtual {v0}, Lchat/ola/vn/entity/y;->g()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_9

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->e:Lchat/ola/vn/entity/y;

    invoke-virtual {v0}, Lchat/ola/vn/entity/y;->f()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_9

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/n/c;->e()Landroid/location/Location;

    move-result-object v0

    new-instance v3, Landroid/location/Location;

    const-string v4, ""

    invoke-direct {v3, v4}, Landroid/location/Location;-><init>(Ljava/lang/String;)V

    iget-object v4, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->e:Lchat/ola/vn/entity/y;

    invoke-virtual {v4}, Lchat/ola/vn/entity/y;->g()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Ljava/lang/Double;->parseDouble(Ljava/lang/String;)D

    move-result-wide v4

    invoke-virtual {v3, v4, v5}, Landroid/location/Location;->setLatitude(D)V

    iget-object v4, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->e:Lchat/ola/vn/entity/y;

    invoke-virtual {v4}, Lchat/ola/vn/entity/y;->f()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Ljava/lang/Double;->parseDouble(Ljava/lang/String;)D

    move-result-wide v4

    invoke-virtual {v3, v4, v5}, Landroid/location/Location;->setLongitude(D)V

    iget-object v4, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->h:Landroid/widget/TextView;

    invoke-virtual {v4, v2}, Landroid/widget/TextView;->setVisibility(I)V

    invoke-virtual {v0, v3}, Landroid/location/Location;->distanceTo(Landroid/location/Location;)F

    move-result v0

    const/high16 v3, 0x41200000    # 10.0f

    cmpg-float v3, v0, v3

    if-gez v3, :cond_7

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->h:Landroid/widget/TextView;

    const v1, 0x7f0f0570

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    goto :goto_4

    :cond_7
    const/high16 v3, 0x447a0000    # 1000.0f

    cmpg-float v4, v0, v3

    if-gez v4, :cond_8

    iget-object v1, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->h:Landroid/widget/TextView;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    float-to-int v0, v0

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v0, "m"

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_4

    :cond_8
    iget-object v4, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->h:Landroid/widget/TextView;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "%.1f"

    new-array v1, v1, [Ljava/lang/Object;

    div-float/2addr v0, v3

    invoke-static {v0}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v0

    aput-object v0, v1, v2

    invoke-static {v6, v1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v0, "Km"

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v4, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_4

    :cond_9
    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->h:Landroid/widget/TextView;

    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setVisibility(I)V

    :goto_4
    invoke-direct {p0}, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->I()V

    :goto_5
    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->o:Lchat/ola/vn/r/a/e;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/e;->j()I

    move-result v0

    if-nez v0, :cond_a

    invoke-virtual {p0, v2}, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->a_(I)V

    :cond_a
    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->x:Lchat/ola/vn/b/q;

    invoke-virtual {v0}, Lchat/ola/vn/b/q;->notifyDataSetChanged()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private I()V
    .locals 10

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->e:Lchat/ola/vn/entity/y;

    invoke-virtual {v0}, Lchat/ola/vn/entity/y;->j()Ljava/util/List;

    move-result-object v0

    const/16 v1, 0x8

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->u:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    return-void

    :cond_0
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v2

    if-lez v2, :cond_4

    iget-object v3, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->u:Landroid/view/View;

    const/4 v4, 0x0

    invoke-virtual {v3, v4}, Landroid/view/View;->setVisibility(I)V

    const v3, 0x7f0f0563

    invoke-virtual {p0, v3}, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->getString(I)Ljava/lang/String;

    move-result-object v3

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v6, " \u00b7 "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    int-to-long v6, v2

    invoke-static {v6, v7}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    new-instance v6, Landroid/text/SpannableStringBuilder;

    invoke-direct {v6, v5}, Landroid/text/SpannableStringBuilder;-><init>(Ljava/lang/CharSequence;)V

    new-instance v7, Landroid/text/style/ForegroundColorSpan;

    sget v8, Lchat/ola/vn/f;->y:I

    invoke-direct {v7, v8}, Landroid/text/style/ForegroundColorSpan;-><init>(I)V

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v8

    const/16 v9, 0x21

    invoke-virtual {v6, v7, v4, v8, v9}, Landroid/text/SpannableStringBuilder;->setSpan(Ljava/lang/Object;III)V

    new-instance v7, Landroid/text/style/ForegroundColorSpan;

    sget v8, Lchat/ola/vn/f;->z:I

    invoke-direct {v7, v8}, Landroid/text/style/ForegroundColorSpan;-><init>(I)V

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v3

    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v5

    invoke-virtual {v6, v7, v3, v5, v9}, Landroid/text/SpannableStringBuilder;->setSpan(Ljava/lang/Object;III)V

    iget-object v3, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->v:Landroid/widget/TextView;

    invoke-virtual {v3, v6}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    const/4 v3, 0x0

    :goto_0
    iget-object v5, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->w:[Lchat/ola/vn/view/OlaCachedImageView;

    array-length v5, v5

    if-ge v3, v5, :cond_1

    iget-object v5, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->w:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v5, v5, v3

    invoke-virtual {v5, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :cond_1
    const/4 v3, 0x3

    const/4 v5, 0x4

    if-le v2, v3, :cond_2

    const/4 v3, 0x0

    :goto_1
    iget-object v6, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->w:[Lchat/ola/vn/view/OlaCachedImageView;

    array-length v6, v6

    if-ge v3, v6, :cond_3

    iget-object v6, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->w:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v6, v6, v3

    invoke-virtual {v6, v5}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    :cond_2
    iget-object v3, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->w:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v3, v3, v4

    invoke-virtual {v3, v5}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    iget-object v3, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->w:[Lchat/ola/vn/view/OlaCachedImageView;

    const/4 v6, 0x1

    aget-object v3, v3, v6

    invoke-virtual {v3, v5}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    iget-object v3, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->w:[Lchat/ola/vn/view/OlaCachedImageView;

    const/4 v6, 0x2

    aget-object v3, v3, v6

    invoke-virtual {v3, v5}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    :cond_3
    const/4 v3, 0x0

    :goto_2
    iget-object v5, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->w:[Lchat/ola/vn/view/OlaCachedImageView;

    array-length v5, v5

    if-ge v3, v5, :cond_5

    if-ge v3, v2, :cond_5

    iget-object v5, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->w:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v5, v5, v3

    invoke-virtual {v5, v4}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    invoke-interface {v0, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/String;

    invoke-static {v6}, Lchat/ola/vn/entity/i;->i(Ljava/lang/String;)C

    move-result v7

    packed-switch v7, :pswitch_data_0

    invoke-virtual {v5, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    goto :goto_4

    :pswitch_0
    sget-object v6, Landroid/widget/ImageView$ScaleType;->CENTER_INSIDE:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {v5, v6}, Lchat/ola/vn/view/OlaCachedImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    const v6, 0x7f080717

    goto :goto_3

    :pswitch_1
    sget-object v6, Landroid/widget/ImageView$ScaleType;->CENTER_INSIDE:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {v5, v6}, Lchat/ola/vn/view/OlaCachedImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    const v6, 0x7f08071a

    :goto_3
    invoke-virtual {v5, v6}, Lchat/ola/vn/view/OlaCachedImageView;->setImageResource(I)V

    goto :goto_4

    :pswitch_2
    sget-object v7, Landroid/widget/ImageView$ScaleType;->CENTER_CROP:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {v5, v7}, Lchat/ola/vn/view/OlaCachedImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v7

    invoke-virtual {v5}, Lchat/ola/vn/view/OlaCachedImageView;->getWidth()I

    move-result v8

    invoke-virtual {v7, v6, v5, v8}, Lchat/ola/vn/c/t;->b(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;I)V

    :goto_4
    add-int/lit8 v3, v3, 0x1

    goto :goto_2

    :cond_4
    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->u:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    :cond_5
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private J()V
    .locals 5

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->e:Lchat/ola/vn/entity/y;

    if-eqz v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->e:Lchat/ola/vn/entity/y;

    invoke-virtual {v0}, Lchat/ola/vn/entity/y;->k()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->r:Lchat/ola/vn/view/OlaCachedImageView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->e:Lchat/ola/vn/entity/y;

    invoke-virtual {v1}, Lchat/ola/vn/entity/y;->k()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->r:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/c/t;->g(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->r:Lchat/ola/vn/view/OlaCachedImageView;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    :goto_0
    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->e:Lchat/ola/vn/entity/y;

    invoke-virtual {v0}, Lchat/ola/vn/entity/y;->i()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->e:Lchat/ola/vn/entity/y;

    invoke-virtual {v0}, Lchat/ola/vn/entity/y;->i()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/c/f;->o(Ljava/lang/String;)Z

    move-result v0

    const-wide v1, 0x3ffc71c71c71c71cL    # 1.7777777777777777

    if-eqz v0, :cond_1

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    iget-object v3, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->e:Lchat/ola/vn/entity/y;

    invoke-virtual {v3}, Lchat/ola/vn/entity/y;->i()Ljava/lang/String;

    move-result-object v3

    iget-object v4, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->p:Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v0, v3, v4}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V

    :goto_1
    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->p:Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/view/OlaRatioImageView;->setRatio(D)V

    return-void

    :cond_1
    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    iget-object v3, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->e:Lchat/ola/vn/entity/y;

    invoke-virtual {v3}, Lchat/ola/vn/entity/y;->i()Ljava/lang/String;

    move-result-object v3

    iget-object v4, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->p:Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v0, v3, v4}, Lchat/ola/vn/c/t;->d(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V

    goto :goto_1

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->p:Lchat/ola/vn/view/OlaRatioImageView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1, v1}, Lchat/ola/vn/view/OlaRatioImageView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    :cond_3
    return-void
.end method

.method private static K()V
    .locals 1

    sget-object v0, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/e;->t()V

    return-void
.end method

.method private L()V
    .locals 2

    iget-boolean v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->z:Z

    if-nez v0, :cond_1

    invoke-static {}, Lchat/ola/vn/c/x;->e()Z

    move-result v0

    if-eqz v0, :cond_0

    sget-object v0, Lchat/ola/vn/util/c/a;->s:Landroid/net/Uri;

    invoke-static {p0, v0}, Lchat/ola/vn/util/n;->a(Landroid/content/Context;Landroid/net/Uri;)Z

    :cond_0
    iget-boolean v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->z:Z

    const/4 v1, 0x1

    xor-int/2addr v0, v1

    iput-boolean v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->z:Z

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->y:Landroid/support/v4/widget/SwipeRefreshLayout;

    invoke-virtual {v0, v1}, Landroid/support/v4/widget/SwipeRefreshLayout;->setRefreshing(Z)V

    :cond_1
    return-void
.end method

.method private M()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->A:Ljava/lang/Runnable;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->A:Ljava/lang/Runnable;

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->c(Ljava/lang/Runnable;)V

    :cond_0
    iget-boolean v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->z:Z

    if-eqz v0, :cond_2

    invoke-static {}, Lchat/ola/vn/c/x;->e()Z

    move-result v0

    if-eqz v0, :cond_1

    sget-object v0, Lchat/ola/vn/util/c/a;->t:Landroid/net/Uri;

    invoke-static {p0, v0}, Lchat/ola/vn/util/n;->a(Landroid/content/Context;Landroid/net/Uri;)Z

    :cond_1
    iget-boolean v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->z:Z

    xor-int/lit8 v0, v0, 0x1

    iput-boolean v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->z:Z

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->y:Landroid/support/v4/widget/SwipeRefreshLayout;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/support/v4/widget/SwipeRefreshLayout;->setRefreshing(Z)V

    :cond_2
    return-void
.end method

.method static synthetic a(Lchat/ola/vn/checkin/OlaVenueDetailActivity;)Ljava/lang/Runnable;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->A:Ljava/lang/Runnable;

    return-object p0
.end method

.method static synthetic a(Lchat/ola/vn/checkin/OlaVenueDetailActivity;Ljava/lang/Runnable;)Ljava/lang/Runnable;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->A:Ljava/lang/Runnable;

    return-object p1
.end method

.method public static a(Landroid/content/Context;Ljava/lang/String;)V
    .locals 2

    :try_start_0
    new-instance v0, Landroid/os/Bundle;

    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V

    const-string v1, "_byte_data"

    invoke-virtual {v0, v1, p1}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    new-instance p1, Landroid/content/Intent;

    const-class v1, Lchat/ola/vn/checkin/OlaVenueDetailActivity;

    invoke-direct {p1, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const/high16 v1, 0x10000000

    invoke-virtual {p1, v1}, Landroid/content/Intent;->setFlags(I)Landroid/content/Intent;

    invoke-virtual {p1, v0}, Landroid/content/Intent;->putExtras(Landroid/os/Bundle;)Landroid/content/Intent;

    invoke-virtual {p0, p1}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :try_start_1
    check-cast p0, Landroid/app/Activity;

    const p1, 0x7f010038

    const v0, 0x7f010039

    invoke-virtual {p0, p1, v0}, Landroid/app/Activity;->overridePendingTransition(II)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    return-void

    :catch_0
    move-exception p0

    invoke-virtual {p0}, Ljava/lang/Throwable;->printStackTrace()V

    :catch_1
    return-void
.end method

.method private a(Landroid/view/View;I)V
    .locals 7

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->e:Lchat/ola/vn/entity/y;

    invoke-virtual {v0}, Lchat/ola/vn/entity/y;->j()Ljava/util/List;

    move-result-object v0

    if-eqz v0, :cond_4

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v1

    if-nez v1, :cond_0

    return-void

    :cond_0
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v1

    const/4 v2, 0x1

    if-lt p2, v1, :cond_1

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result p2

    sub-int/2addr p2, v2

    :cond_1
    new-instance v1, Ljava/util/ArrayList;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v3

    invoke-direct {v1, v3}, Ljava/util/ArrayList;-><init>(I)V

    const/4 v3, 0x0

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v4

    :goto_0
    if-ge v3, v4, :cond_3

    invoke-interface {v0, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    invoke-static {v5}, Lchat/ola/vn/entity/i;->i(Ljava/lang/String;)C

    move-result v6

    if-eq v6, v2, :cond_2

    goto :goto_1

    :cond_2
    new-instance v6, Lchat/ola/vn/mediastore/OlaMediaEntity;

    invoke-direct {v6, v5, v2, v2}, Lchat/ola/vn/mediastore/OlaMediaEntity;-><init>(Ljava/lang/String;IS)V

    invoke-virtual {v1, v6}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    :goto_1
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :cond_3
    const/4 v0, 0x0

    invoke-static {p0, p1, v0, p2, v1}, Lchat/ola/vn/activity/OlaImageViewerActivity;->a(Landroid/content/Context;Landroid/view/View;Landroid/graphics/Bitmap;ILjava/util/ArrayList;)V

    :cond_4
    return-void
.end method

.method static synthetic a(Lchat/ola/vn/checkin/OlaVenueDetailActivity;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->h(Ljava/lang/String;)V

    return-void
.end method

.method private a(Ljava/lang/String;J)V
    .locals 1

    iget-boolean v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->E:Z

    if-eqz v0, :cond_0

    return-void

    :cond_0
    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0, p1, p2, p3, p0}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;JLchat/ola/vn/p/a;)V

    const/4 p1, 0x1

    iput-boolean p1, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->E:Z

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/checkin/OlaVenueDetailActivity;Z)Z
    .locals 0

    iput-boolean p1, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->z:Z

    return p1
.end method

.method static synthetic b(Landroid/content/Context;Ljava/lang/String;)V
    .locals 0

    invoke-static {p0, p1}, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->c(Landroid/content/Context;Ljava/lang/String;)V

    return-void
.end method

.method static synthetic b(Lchat/ola/vn/checkin/OlaVenueDetailActivity;Z)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->c(Z)V

    return-void
.end method

.method static synthetic b(Lchat/ola/vn/checkin/OlaVenueDetailActivity;)Z
    .locals 0

    iget-boolean p0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->z:Z

    return p0
.end method

.method static synthetic c(Lchat/ola/vn/checkin/OlaVenueDetailActivity;)Landroid/support/v4/widget/SwipeRefreshLayout;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->y:Landroid/support/v4/widget/SwipeRefreshLayout;

    return-object p0
.end method

.method private static c(Landroid/content/Context;Ljava/lang/String;)V
    .locals 0

    :try_start_0
    invoke-static {p0, p1}, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->d(Landroid/content/Context;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private c(Z)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->t:Landroid/view/View;

    if-eqz p1, :cond_0

    const/4 p1, 0x0

    goto :goto_0

    :cond_0
    const/16 p1, 0x8

    :goto_0
    invoke-virtual {v0, p1}, Landroid/view/View;->setVisibility(I)V

    return-void
.end method

.method private static d(Landroid/content/Context;Ljava/lang/String;)V
    .locals 2

    :try_start_0
    invoke-static {p1}, Lchat/ola/vn/util/m;->k(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    new-instance v0, Landroid/content/Intent;

    const-class v1, Lchat/ola/vn/me/OlaClanMePageActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v1, "contactId"

    invoke-virtual {v0, v1, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    invoke-virtual {p0, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    check-cast p0, Landroid/app/Activity;

    const v0, 0x7f010038

    const v1, 0x7f010039

    invoke-virtual {p0, v0, v1}, Landroid/app/Activity;->overridePendingTransition(II)V

    new-instance p0, Ljava/lang/StringBuilder;

    invoke-direct {p0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "#"

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->j(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic d(Lchat/ola/vn/checkin/OlaVenueDetailActivity;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->L()V

    return-void
.end method

.method static synthetic e(Lchat/ola/vn/checkin/OlaVenueDetailActivity;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->G()V

    return-void
.end method

.method private h(Ljava/lang/String;)V
    .locals 4

    :try_start_0
    invoke-static {p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :try_start_1
    iget-object p1, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->t:Landroid/view/View;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->t:Landroid/view/View;

    invoke-virtual {p1}, Landroid/view/View;->getVisibility()I

    move-result p1
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    if-nez p1, :cond_0

    return-void

    :catch_0
    move-object v0, p1

    :catch_1
    :cond_0
    const/4 p1, 0x0

    :try_start_2
    sget-object v1, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    iget-boolean v1, v1, Lchat/ola/vn/entity/ag;->x:Z
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    goto :goto_0

    :catch_2
    const/4 v1, 0x0

    :goto_0
    :try_start_3
    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_2

    invoke-static {v0}, Lchat/ola/vn/util/m;->j(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const/4 v2, 0x1

    invoke-direct {p0, v2}, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->c(Z)V

    if-eqz v1, :cond_1

    invoke-static {v0}, Lchat/ola/vn/util/m;->t(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    new-array v2, v2, [Ljava/lang/String;

    const-string v3, "name"

    aput-object v3, v2, p1

    new-instance p1, Lchat/ola/vn/checkin/OlaVenueDetailActivity$7;

    invoke-direct {p1, p0}, Lchat/ola/vn/checkin/OlaVenueDetailActivity$7;-><init>(Lchat/ola/vn/checkin/OlaVenueDetailActivity;)V

    invoke-virtual {v1, v0, v2, p1}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;[Ljava/lang/String;Lchat/ola/vn/p/d;)V

    return-void

    :cond_1
    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    new-instance v1, Lchat/ola/vn/checkin/OlaVenueDetailActivity$8;

    invoke-direct {v1, p0}, Lchat/ola/vn/checkin/OlaVenueDetailActivity$8;-><init>(Lchat/ola/vn/checkin/OlaVenueDetailActivity;)V

    invoke-virtual {p1, v0, v1}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Lchat/ola/vn/p/i;)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_3

    :catch_3
    :cond_2
    return-void
.end method

.method private i(Ljava/lang/String;)V
    .locals 1

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz v0, :cond_0

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0, p1, p0}, Lchat/ola/vn/network/OlaNetworkService;->c(Ljava/lang/String;Lchat/ola/vn/p/a;)V

    :cond_0
    return-void
.end method

.method private static j(Ljava/lang/String;)V
    .locals 8

    sget-object v0, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v0, p0}, Lchat/ola/vn/r/a/e;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_2

    const-string v0, "my diary"

    invoke-static {p0, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_2

    const-string v0, "mariage diary"

    invoke-static {p0, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_2

    const/4 v0, 0x0

    const-string v1, "#"

    invoke-virtual {p0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v0, p0}, Lchat/ola/vn/message/g;->b(Ljava/lang/String;)Lchat/ola/vn/message/f;

    move-result-object v0

    :cond_0
    sget-object v1, Lchat/ola/vn/h;->w:Lchat/ola/vn/r/a;

    invoke-interface {v1, p0}, Lchat/ola/vn/r/a;->a(Ljava/lang/String;)Lchat/ola/vn/entry/g;

    move-result-object v1

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    if-nez v1, :cond_1

    new-instance v1, Lchat/ola/vn/entry/g;

    invoke-direct {v1, p0, p0}, Lchat/ola/vn/entry/g;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v1, v2, v3}, Lchat/ola/vn/entry/g;->c(J)V

    :cond_1
    invoke-virtual {v1, v2, v3}, Lchat/ola/vn/entry/g;->a(J)V

    invoke-virtual {v1}, Lchat/ola/vn/entry/g;->d()J

    move-result-wide v2

    const-wide/16 v4, 0x1

    add-long v6, v2, v4

    invoke-virtual {v1, v6, v7}, Lchat/ola/vn/entry/g;->b(J)V

    sget-object p0, Lchat/ola/vn/h;->w:Lchat/ola/vn/r/a;

    invoke-interface {p0, v1}, Lchat/ola/vn/r/a;->a(Lchat/ola/vn/entry/g;)V

    invoke-static {}, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->K()V

    if-eqz v0, :cond_2

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->b()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v1, p0}, Lchat/ola/vn/entry/g;->a(Ljava/lang/String;)V

    :cond_2
    return-void
.end method


# virtual methods
.method public B()Z
    .locals 1

    iget-boolean v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->D:Z

    return v0
.end method

.method public C()Ljava/lang/String;
    .locals 1

    const/4 v0, 0x0

    return-object v0
.end method

.method public D()V
    .locals 0

    return-void
.end method

.method public E()V
    .locals 0

    return-void
.end method

.method protected a()V
    .locals 0

    return-void
.end method

.method public a(II)V
    .locals 0

    return-void
.end method

.method public a(Lchat/ola/vn/entity/OlaCheckInItemEntity;)V
    .locals 0

    return-void
.end method

.method public a(Lchat/ola/vn/entity/OlaVenueEntity;)V
    .locals 0

    return-void
.end method

.method public a(Lchat/ola/vn/entity/g;Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lchat/ola/vn/entity/g;",
            "Ljava/util/List<",
            "Lchat/ola/vn/entry/b;",
            ">;)V"
        }
    .end annotation

    return-void
.end method

.method public a(Lchat/ola/vn/entity/o;)V
    .locals 0

    return-void
.end method

.method public a(Lchat/ola/vn/entity/y;)V
    .locals 2

    if-eqz p1, :cond_0

    iput-object p1, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->e:Lchat/ola/vn/entity/y;

    const/4 p1, 0x0

    invoke-direct {p0, p1}, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->c(Z)V

    iget-object p1, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->F:Ljava/lang/String;

    const-wide/16 v0, 0x0

    invoke-direct {p0, p1, v0, v1}, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->a(Ljava/lang/String;J)V

    invoke-direct {p0}, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->H()V

    :cond_0
    return-void
.end method

.method public a(Lchat/ola/vn/entry/a;Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lchat/ola/vn/entry/a;",
            "Ljava/util/List<",
            "Lchat/ola/vn/entry/b;",
            ">;)V"
        }
    .end annotation

    return-void
.end method

.method public a(Lchat/ola/vn/entry/b;Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lchat/ola/vn/entry/b;",
            "Ljava/util/List<",
            "Lchat/ola/vn/entry/b;",
            ">;)V"
        }
    .end annotation

    return-void
.end method

.method public a(Ljava/util/List;J)V
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/g;",
            ">;J)V"
        }
    .end annotation

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->G:Lchat/ola/vn/e/c;

    const/4 v1, 0x0

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/e/c;

    invoke-direct {v0, v1}, Lchat/ola/vn/e/c;-><init>(Z)V

    iput-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->G:Lchat/ola/vn/e/c;

    :cond_0
    const-wide/16 v2, 0x0

    if-eqz p1, :cond_2

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->G:Lchat/ola/vn/e/c;

    invoke-static {p1, v0}, Ljava/util/Collections;->sort(Ljava/util/List;Ljava/util/Comparator;)V

    const/4 v0, 0x1

    iput-boolean v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->D:Z

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->o:Lchat/ola/vn/r/a/e;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/e;->k()J

    move-result-wide v4

    cmp-long v0, v4, v2

    if-nez v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->o:Lchat/ola/vn/r/a/e;

    const-string v4, ""

    invoke-virtual {v0, v4, v1, p1}, Lchat/ola/vn/r/a/e;->b(Ljava/lang/String;SLjava/util/List;)V

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->o:Lchat/ola/vn/r/a/e;

    invoke-virtual {v0, p1}, Lchat/ola/vn/r/a/e;->c(Ljava/util/List;)V

    :goto_0
    iget-object p1, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->n:Lchat/ola/vn/b/u;

    invoke-virtual {p1}, Lchat/ola/vn/b/u;->notifyDataSetChanged()V

    goto :goto_1

    :cond_2
    iput-boolean v1, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->D:Z

    :goto_1
    cmp-long p1, p2, v2

    if-eqz p1, :cond_3

    iput-wide p2, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->C:J

    goto :goto_2

    :cond_3
    iput-boolean v1, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->D:Z

    :goto_2
    iget-object p1, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->B:Landroid/view/View;

    const/16 p2, 0x8

    invoke-virtual {p1, p2}, Landroid/view/View;->setVisibility(I)V

    invoke-direct {p0}, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->M()V

    invoke-direct {p0, v1}, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->c(Z)V

    iput-boolean v1, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->E:Z

    return-void
.end method

.method public a(Ljava/util/List;Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entry/b;",
            ">;",
            "Ljava/util/List<",
            "Lchat/ola/vn/entry/b;",
            ">;)V"
        }
    .end annotation

    return-void
.end method

.method public a(SLjava/lang/String;)V
    .locals 4

    const/4 v0, 0x0

    iput-boolean v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->D:Z

    packed-switch p1, :pswitch_data_0

    goto :goto_0

    :pswitch_0
    iget-wide v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->C:J

    const-wide/16 v2, 0x0

    cmp-long p1, v0, v2

    if-eqz p1, :cond_0

    invoke-static {p2}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_0

    const/4 p1, 0x0

    invoke-static {p0, p1, p2}, Lchat/ola/vn/i/i;->b(Landroid/content/Context;Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/app/Dialog;

    goto :goto_0

    :pswitch_1
    iget-object p1, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->B:Landroid/view/View;

    const/16 p2, 0x8

    invoke-virtual {p1, p2}, Landroid/view/View;->setVisibility(I)V

    invoke-direct {p0, v0}, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->c(Z)V

    :cond_0
    :goto_0
    invoke-direct {p0}, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->H()V

    return-void

    :pswitch_data_0
    .packed-switch 0x5
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public a_(I)V
    .locals 2

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->e:Lchat/ola/vn/entity/y;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->B:Landroid/view/View;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->e:Lchat/ola/vn/entity/y;

    invoke-virtual {p1}, Lchat/ola/vn/entity/y;->a()Ljava/lang/String;

    move-result-object p1

    iget-wide v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->C:J

    invoke-direct {p0, p1, v0, v1}, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->a(Ljava/lang/String;J)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public b(Lchat/ola/vn/entity/OlaVenueEntity;)V
    .locals 0

    return-void
.end method

.method public b(Lchat/ola/vn/entry/b;Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lchat/ola/vn/entry/b;",
            "Ljava/util/List<",
            "Lchat/ola/vn/entry/b;",
            ">;)V"
        }
    .end annotation

    return-void
.end method

.method public b(Ljava/util/List;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/OlaVenueEntity;",
            ">;I)V"
        }
    .end annotation

    return-void
.end method

.method public b(Ljava/util/List;Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entry/b;",
            ">;",
            "Ljava/util/List<",
            "Lchat/ola/vn/entry/b;",
            ">;)V"
        }
    .end annotation

    return-void
.end method

.method public c(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/OlaCheckInActionEntity;",
            ">;)V"
        }
    .end annotation

    return-void
.end method

.method public c(Ljava/util/List;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/OlaCheckInItemEntity;",
            ">;I)V"
        }
    .end annotation

    return-void
.end method

.method public d(I)V
    .locals 0

    return-void
.end method

.method public d(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/af;",
            ">;)V"
        }
    .end annotation

    return-void
.end method

.method public e(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entry/b;",
            ">;)V"
        }
    .end annotation

    return-void
.end method

.method public f(Ljava/lang/String;)V
    .locals 1

    const/4 v0, 0x0

    :try_start_0
    invoke-direct {p0, v0}, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->c(Z)V

    invoke-static {p1}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->e:Lchat/ola/vn/entity/y;

    invoke-virtual {p1}, Lchat/ola/vn/entity/y;->e()Lchat/ola/vn/entity/OlaVenueEntity;

    move-result-object p1

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Lchat/ola/vn/entity/OlaVenueEntity;->h(Ljava/lang/String;)V

    invoke-virtual {p0}, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->finish()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public f(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    return-void
.end method

.method public finish()V
    .locals 2

    invoke-super {p0}, Lchat/ola/vn/c;->finish()V

    const v0, 0x7f01003a

    const v1, 0x7f01003b

    :try_start_0
    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public g(Ljava/lang/String;)V
    .locals 0

    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 5

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v0

    const v1, 0x7f090030

    if-eq v0, v1, :cond_6

    const v1, 0x7f0901d5

    const/4 v2, 0x3

    const/4 v3, 0x1

    const/4 v4, 0x0

    if-eq v0, v1, :cond_4

    const p1, 0x7f0901e8

    if-eq v0, p1, :cond_3

    const p1, 0x7f09032f

    if-eq v0, p1, :cond_2

    const p1, 0x7f090351

    if-eq v0, p1, :cond_1

    const p1, 0x7f09039a

    if-eq v0, p1, :cond_0

    packed-switch v0, :pswitch_data_0

    return-void

    :pswitch_0
    iget-object p1, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->w:[Lchat/ola/vn/view/OlaCachedImageView;

    const/4 v0, 0x5

    aget-object p1, p1, v0

    :goto_0
    invoke-direct {p0, p1, v0}, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->a(Landroid/view/View;I)V

    return-void

    :pswitch_1
    iget-object p1, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->w:[Lchat/ola/vn/view/OlaCachedImageView;

    const/4 v0, 0x2

    aget-object p1, p1, v0

    goto :goto_0

    :pswitch_2
    iget-object p1, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->w:[Lchat/ola/vn/view/OlaCachedImageView;

    const/4 v0, 0x4

    aget-object p1, p1, v0

    goto :goto_0

    :pswitch_3
    iget-object p1, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->w:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object p1, p1, v2

    invoke-direct {p0, p1, v2}, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->a(Landroid/view/View;I)V

    return-void

    :pswitch_4
    iget-object p1, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->w:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object p1, p1, v3

    invoke-direct {p0, p1, v3}, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->a(Landroid/view/View;I)V

    return-void

    :pswitch_5
    iget-object p1, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->w:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object p1, p1, v4

    :goto_1
    invoke-direct {p0, p1, v4}, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->a(Landroid/view/View;I)V

    return-void

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->finish()V

    return-void

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->w:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object p1, p1, v4

    goto :goto_1

    :cond_2
    iget-object p1, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->e:Lchat/ola/vn/entity/y;

    invoke-virtual {p1}, Lchat/ola/vn/entity/y;->g()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_7

    iget-object p1, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->e:Lchat/ola/vn/entity/y;

    invoke-virtual {p1}, Lchat/ola/vn/entity/y;->f()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_7

    iget-object p1, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->e:Lchat/ola/vn/entity/y;

    invoke-virtual {p1}, Lchat/ola/vn/entity/y;->g()Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->e:Lchat/ola/vn/entity/y;

    invoke-virtual {v0}, Lchat/ola/vn/entity/y;->f()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->e:Lchat/ola/vn/entity/y;

    invoke-virtual {v1}, Lchat/ola/vn/entity/y;->b()Ljava/lang/String;

    move-result-object v1

    invoke-static {p0, p1, v0, v1}, Lchat/ola/vn/util/b;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void

    :cond_3
    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/n/c;->e()Landroid/location/Location;

    move-result-object p1

    if-eqz p1, :cond_7

    iget-object p1, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->e:Lchat/ola/vn/entity/y;

    invoke-virtual {p1}, Lchat/ola/vn/entity/y;->g()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_7

    iget-object p1, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->e:Lchat/ola/vn/entity/y;

    invoke-virtual {p1}, Lchat/ola/vn/entity/y;->f()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_7

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/n/c;->c()Ljava/lang/String;

    move-result-object p1

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/n/c;->b()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->e:Lchat/ola/vn/entity/y;

    invoke-virtual {v1}, Lchat/ola/vn/entity/y;->g()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->e:Lchat/ola/vn/entity/y;

    invoke-virtual {v2}, Lchat/ola/vn/entity/y;->f()Ljava/lang/String;

    move-result-object v2

    invoke-static {p0, p1, v0, v1, v2}, Lchat/ola/vn/util/b;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void

    :cond_4
    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->e:Lchat/ola/vn/entity/y;

    invoke-virtual {v0}, Lchat/ola/vn/entity/y;->i()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/c/f;->o(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_5

    new-instance v0, Lchat/ola/vn/mediastore/OlaMediaEntity;

    iget-object v1, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->e:Lchat/ola/vn/entity/y;

    invoke-virtual {v1}, Lchat/ola/vn/entity/y;->i()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1, v2, v3}, Lchat/ola/vn/mediastore/OlaMediaEntity;-><init>(Ljava/lang/String;IS)V

    goto :goto_2

    :cond_5
    new-instance v0, Lchat/ola/vn/mediastore/OlaMediaEntity;

    iget-object v1, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->e:Lchat/ola/vn/entity/y;

    invoke-virtual {v1}, Lchat/ola/vn/entity/y;->i()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1, v3, v3}, Lchat/ola/vn/mediastore/OlaMediaEntity;-><init>(Ljava/lang/String;IS)V

    :goto_2
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1, v4}, Ljava/util/ArrayList;-><init>(I)V

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    const/4 v0, 0x0

    invoke-static {p0, p1, v0, v4, v1}, Lchat/ola/vn/activity/OlaImageViewerActivity;->a(Landroid/content/Context;Landroid/view/View;Landroid/graphics/Bitmap;ILjava/util/ArrayList;)V

    return-void

    :cond_6
    new-instance p1, Lchat/ola/vn/entity/OlaVenueEntity;

    invoke-direct {p1}, Lchat/ola/vn/entity/OlaVenueEntity;-><init>()V

    new-instance p1, Lchat/ola/vn/entity/OlaVenueEntity;

    invoke-direct {p1}, Lchat/ola/vn/entity/OlaVenueEntity;-><init>()V

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->e:Lchat/ola/vn/entity/y;

    invoke-virtual {v0}, Lchat/ola/vn/entity/y;->d()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Lchat/ola/vn/entity/OlaVenueEntity;->d(Ljava/lang/String;)V

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->e:Lchat/ola/vn/entity/y;

    invoke-virtual {v0}, Lchat/ola/vn/entity/y;->c()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Lchat/ola/vn/entity/OlaVenueEntity;->c(Ljava/lang/String;)V

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->e:Lchat/ola/vn/entity/y;

    invoke-virtual {v0}, Lchat/ola/vn/entity/y;->i()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Lchat/ola/vn/entity/OlaVenueEntity;->e(Ljava/lang/String;)V

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->e:Lchat/ola/vn/entity/y;

    invoke-virtual {v0}, Lchat/ola/vn/entity/y;->b()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Lchat/ola/vn/entity/OlaVenueEntity;->b(Ljava/lang/String;)V

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->e:Lchat/ola/vn/entity/y;

    invoke-virtual {v0}, Lchat/ola/vn/entity/y;->a()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Lchat/ola/vn/entity/OlaVenueEntity;->a(Ljava/lang/String;)V

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->e:Lchat/ola/vn/entity/y;

    invoke-virtual {v0}, Lchat/ola/vn/entity/y;->f()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Lchat/ola/vn/entity/OlaVenueEntity;->f(Ljava/lang/String;)V

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->e:Lchat/ola/vn/entity/y;

    invoke-virtual {v0}, Lchat/ola/vn/entity/y;->g()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Lchat/ola/vn/entity/OlaVenueEntity;->g(Ljava/lang/String;)V

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->e:Lchat/ola/vn/entity/y;

    invoke-virtual {v0}, Lchat/ola/vn/entity/y;->l()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Lchat/ola/vn/entity/OlaVenueEntity;->h(Ljava/lang/String;)V

    iget-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->e:Lchat/ola/vn/entity/y;

    invoke-virtual {v0}, Lchat/ola/vn/entity/y;->h()I

    move-result v0

    invoke-virtual {p1, v0}, Lchat/ola/vn/entity/OlaVenueEntity;->a(I)V

    invoke-static {p0, p1}, Lchat/ola/vn/me/OlaMeComposerActivity;->a(Landroid/content/Context;Lchat/ola/vn/entity/OlaVenueEntity;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_7
    return-void

    :pswitch_data_0
    .packed-switch 0x7f090348
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 1

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    const p1, 0x7f0b017d

    invoke-virtual {p0, p1}, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->setContentView(I)V

    invoke-virtual {p0}, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->getIntent()Landroid/content/Intent;

    move-result-object p1

    const-string v0, "_byte_data"

    invoke-virtual {p1, v0}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->F:Ljava/lang/String;

    invoke-direct {p0}, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->F()V

    return-void
.end method

.method protected onDestroy()V
    .locals 1

    invoke-super {p0}, Lchat/ola/vn/c;->onDestroy()V

    const/4 v0, 0x0

    :try_start_0
    iput-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->e:Lchat/ola/vn/entity/y;

    iput-object v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->o:Lchat/ola/vn/r/a/e;

    const/4 v0, 0x1

    iput-boolean v0, p0, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->D:Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method protected onStart()V
    .locals 0

    invoke-super {p0}, Lchat/ola/vn/c;->onStart()V

    invoke-direct {p0}, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->H()V

    return-void
.end method
