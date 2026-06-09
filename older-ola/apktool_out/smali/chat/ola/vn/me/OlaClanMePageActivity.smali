.class public Lchat/ola/vn/me/OlaClanMePageActivity;
.super Lchat/ola/vn/c;

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Lchat/ola/vn/activity/OlaCropImageActivity$a;
.implements Lchat/ola/vn/b/j$a;


# instance fields
.field private A:Landroid/widget/TextView;

.field private B:Landroid/widget/TextView;

.field private C:Landroid/widget/TextView;

.field private D:Landroid/widget/TextView;

.field private E:Z

.field private F:Z

.field private G:Ljava/lang/String;

.field private H:Landroid/view/View;

.field private I:Z

.field private J:Landroid/view/View;

.field private K:Landroid/view/View;

.field private L:Landroid/view/View;

.field private M:Landroid/widget/TextView;

.field protected e:Lchat/ola/vn/entity/b;

.field protected f:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

.field protected g:Landroid/widget/TextView;

.field protected h:Landroid/widget/TextView;

.field protected i:Landroid/widget/ListView;

.field protected j:Lchat/ola/vn/b/u;

.field protected k:Lchat/ola/vn/r/a/e;

.field protected l:Lchat/ola/vn/view/OlaCachedImageView;

.field protected m:Landroid/view/View;

.field protected n:Lchat/ola/vn/view/OlaCachedImageView;

.field protected o:Landroid/view/View;

.field protected p:Landroid/view/View;

.field protected q:Landroid/view/View;

.field protected r:Landroid/view/View;

.field protected s:Landroid/widget/ImageView;

.field protected t:Landroid/widget/TextView;

.field protected u:Landroid/widget/ImageView;

.field protected v:Landroid/widget/TextView;

.field private w:Lchat/ola/vn/b/q;

.field private x:Landroid/support/v4/widget/SwipeRefreshLayout;

.field private y:Z

.field private z:Ljava/lang/Runnable;


# direct methods
.method public constructor <init>()V
    .locals 2

    invoke-direct {p0}, Lchat/ola/vn/c;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->y:Z

    const/4 v1, 0x0

    iput-object v1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->z:Ljava/lang/Runnable;

    const/4 v1, 0x1

    iput-boolean v1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->E:Z

    iput-boolean v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->F:Z

    iput-boolean v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->I:Z

    return-void
.end method

.method private C()V
    .locals 4

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/me/OlaClanMePageActivity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    const-string v1, "contactId"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->G:Ljava/lang/String;

    const v0, 0x7f09039a

    invoke-virtual {p0, v0}, Lchat/ola/vn/me/OlaClanMePageActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f090030

    invoke-virtual {p0, v0}, Lchat/ola/vn/me/OlaClanMePageActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->H:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->H:Landroid/view/View;

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f0903f3

    invoke-virtual {p0, v0}, Lchat/ola/vn/me/OlaClanMePageActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/support/v4/widget/SwipeRefreshLayout;

    iput-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->x:Landroid/support/v4/widget/SwipeRefreshLayout;

    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->x:Landroid/support/v4/widget/SwipeRefreshLayout;

    const/4 v1, 0x1

    new-array v1, v1, [I

    const/4 v2, 0x0

    const v3, 0x7f06003d

    aput v3, v1, v2

    invoke-virtual {v0, v1}, Landroid/support/v4/widget/SwipeRefreshLayout;->setColorSchemeResources([I)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->x:Landroid/support/v4/widget/SwipeRefreshLayout;

    new-instance v1, Lchat/ola/vn/me/OlaClanMePageActivity$1;

    invoke-direct {v1, p0}, Lchat/ola/vn/me/OlaClanMePageActivity$1;-><init>(Lchat/ola/vn/me/OlaClanMePageActivity;)V

    invoke-virtual {v0, v1}, Landroid/support/v4/widget/SwipeRefreshLayout;->setOnRefreshListener(Landroid/support/v4/widget/SwipeRefreshLayout$OnRefreshListener;)V

    const v0, 0x7f090450

    invoke-virtual {p0, v0}, Lchat/ola/vn/me/OlaClanMePageActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    iput-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->f:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->f:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    new-instance v1, Lchat/ola/vn/me/OlaClanMePageActivity$2;

    invoke-direct {v1, p0}, Lchat/ola/vn/me/OlaClanMePageActivity$2;-><init>(Lchat/ola/vn/me/OlaClanMePageActivity;)V

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setOnEditorActionListener(Landroid/widget/TextView$OnEditorActionListener;)V

    new-instance v0, Lchat/ola/vn/b/q;

    invoke-direct {v0, p0}, Lchat/ola/vn/b/q;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->w:Lchat/ola/vn/b/q;

    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->w:Lchat/ola/vn/b/q;

    invoke-static {}, Lchat/ola/vn/g;->a()Ljava/util/List;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/b/q;->a(Ljava/util/List;)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->w:Lchat/ola/vn/b/q;

    new-instance v1, Lchat/ola/vn/b/q$a;

    iget-object v2, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->w:Lchat/ola/vn/b/q;

    invoke-virtual {v2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    invoke-direct {v1, v2}, Lchat/ola/vn/b/q$a;-><init>(Lchat/ola/vn/b/q;)V

    invoke-virtual {v0, v1}, Lchat/ola/vn/b/q;->a(Landroid/widget/Filter;)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->f:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    iget-object v1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->w:Lchat/ola/vn/b/q;

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setAdapter(Landroid/widget/BaseAdapter;)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->f:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    new-instance v1, Lchat/ola/vn/me/OlaClanMePageActivity$3;

    invoke-direct {v1, p0}, Lchat/ola/vn/me/OlaClanMePageActivity$3;-><init>(Lchat/ola/vn/me/OlaClanMePageActivity;)V

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setOnSuggestionSelectListener(Lchat/ola/vn/view/OlaQuickTypingSuggestedText$b;)V

    const v0, 0x7f0903b0

    invoke-virtual {p0, v0}, Lchat/ola/vn/me/OlaClanMePageActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ListView;

    iput-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->i:Landroid/widget/ListView;

    const v0, 0x7f090609

    invoke-virtual {p0, v0}, Lchat/ola/vn/me/OlaClanMePageActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->p:Landroid/view/View;

    new-instance v0, Lchat/ola/vn/r/a/e;

    invoke-direct {v0}, Lchat/ola/vn/r/a/e;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->k:Lchat/ola/vn/r/a/e;

    new-instance v0, Lchat/ola/vn/b/u;

    iget-object v1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->k:Lchat/ola/vn/r/a/e;

    invoke-direct {v0, p0, v1}, Lchat/ola/vn/b/u;-><init>(Landroid/content/Context;Lchat/ola/vn/r/a/e;)V

    iput-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->j:Lchat/ola/vn/b/u;

    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->j:Lchat/ola/vn/b/u;

    invoke-virtual {v0, p0}, Lchat/ola/vn/b/u;->a(Lchat/ola/vn/b/j$a;)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->j:Lchat/ola/vn/b/u;

    new-instance v1, Lchat/ola/vn/me/OlaClanMePageActivity$4;

    invoke-direct {v1, p0}, Lchat/ola/vn/me/OlaClanMePageActivity$4;-><init>(Lchat/ola/vn/me/OlaClanMePageActivity;)V

    invoke-virtual {v0, v1}, Lchat/ola/vn/b/u;->a(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->j:Lchat/ola/vn/b/u;

    new-instance v1, Lchat/ola/vn/me/OlaClanMePageActivity$5;

    invoke-direct {v1, p0}, Lchat/ola/vn/me/OlaClanMePageActivity$5;-><init>(Lchat/ola/vn/me/OlaClanMePageActivity;)V

    invoke-virtual {v0, v1}, Lchat/ola/vn/b/u;->a(Landroid/view/View$OnLongClickListener;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    invoke-static {p0}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v0

    const v1, 0x7f0b0149

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v0

    const v1, 0x7f09052b

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->A:Landroid/widget/TextView;

    const v1, 0x7f09016d

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->B:Landroid/widget/TextView;

    const v1, 0x7f09016e

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->C:Landroid/widget/TextView;

    iget-object v1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->C:Landroid/widget/TextView;

    invoke-virtual {v1, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v1, 0x7f09016f

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->D:Landroid/widget/TextView;

    const v1, 0x7f0905d5

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    invoke-virtual {v1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v1, 0x7f09020e

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->h:Landroid/widget/TextView;

    const v1, 0x7f090416

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    iput-object v1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->q:Landroid/view/View;

    const v1, 0x7f0901d6

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    iput-object v1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->r:Landroid/view/View;

    iget-object v1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->r:Landroid/view/View;

    invoke-virtual {v1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v1, 0x7f0901d5

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object v1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->l:Lchat/ola/vn/view/OlaCachedImageView;

    iget-object v1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->l:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v1, p0}, Lchat/ola/vn/view/OlaCachedImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v1, 0x7f0901ef

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    iput-object v1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->m:Landroid/view/View;

    iget-object v1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->m:Landroid/view/View;

    invoke-virtual {v1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v1, 0x7f0903e7

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object v1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->n:Lchat/ola/vn/view/OlaCachedImageView;

    iget-object v1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->n:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v1, p0}, Lchat/ola/vn/view/OlaCachedImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v1, 0x7f0901f3

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    iput-object v1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->o:Landroid/view/View;

    iget-object v1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->o:Landroid/view/View;

    invoke-virtual {v1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v1, 0x7f0901b9

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->g:Landroid/widget/TextView;

    const v1, 0x7f090035

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    iput-object v1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->J:Landroid/view/View;

    iget-object v1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->J:Landroid/view/View;

    invoke-virtual {v1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->J:Landroid/view/View;

    const/16 v2, 0x8

    invoke-virtual {v1, v2}, Landroid/view/View;->setVisibility(I)V

    const v1, 0x7f090033

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/ImageView;

    iput-object v1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->s:Landroid/widget/ImageView;

    const v1, 0x7f090034

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->t:Landroid/widget/TextView;

    const v1, 0x7f090223

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    iput-object v1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->K:Landroid/view/View;

    iget-object v1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->K:Landroid/view/View;

    invoke-virtual {v1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v1, 0x7f090221

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/ImageView;

    iput-object v1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->u:Landroid/widget/ImageView;

    const v1, 0x7f090222

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->v:Landroid/widget/TextView;

    const v1, 0x7f0903de

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    invoke-virtual {v1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v1, 0x7f0901f4

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    iput-object v1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->L:Landroid/view/View;

    iget-object v1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->L:Landroid/view/View;

    invoke-virtual {v1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v1, 0x7f090363

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    invoke-virtual {v1, v2}, Landroid/view/View;->setVisibility(I)V

    const v1, 0x7f090171

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->M:Landroid/widget/TextView;

    iget-object v1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->i:Landroid/widget/ListView;

    invoke-virtual {v1, v0}, Landroid/widget/ListView;->addHeaderView(Landroid/view/View;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :try_start_2
    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->i:Landroid/widget/ListView;

    iget-object v1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->j:Lchat/ola/vn/b/u;

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setAdapter(Landroid/widget/ListAdapter;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    return-void
.end method

.method private I()V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->k:Lchat/ola/vn/r/a/e;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/e;->e()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->e:Lchat/ola/vn/entity/b;

    invoke-direct {p0}, Lchat/ola/vn/me/OlaClanMePageActivity;->K()V

    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->j:Lchat/ola/vn/b/u;

    invoke-virtual {v0}, Lchat/ola/vn/b/u;->notifyDataSetChanged()V

    return-void
.end method

.method private static J()V
    .locals 1

    sget-object v0, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/e;->t()V

    return-void
.end method

.method private K()V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->e:Lchat/ola/vn/entity/b;

    if-nez v0, :cond_1

    iget-boolean v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->y:Z

    if-nez v0, :cond_0

    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lchat/ola/vn/me/OlaClanMePageActivity;->c(Z)V

    :cond_0
    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->G:Ljava/lang/String;

    const/16 v2, 0x44

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/network/OlaNetworkService;->f(Ljava/lang/String;S)V

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->f:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setAdapter(Landroid/widget/BaseAdapter;)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->f:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "#"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->e:Lchat/ola/vn/entity/b;

    iget-object v2, v2, Lchat/ola/vn/entity/b;->a:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->f:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    iget-object v1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->w:Lchat/ola/vn/b/q;

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setAdapter(Landroid/widget/BaseAdapter;)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->g:Landroid/widget/TextView;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "#"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->e:Lchat/ola/vn/entity/b;

    iget-object v2, v2, Lchat/ola/vn/entity/b;->a:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    invoke-direct {p0}, Lchat/ola/vn/me/OlaClanMePageActivity;->N()V

    invoke-direct {p0}, Lchat/ola/vn/me/OlaClanMePageActivity;->Q()V

    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->h:Landroid/widget/TextView;

    iget-object v1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->e:Lchat/ola/vn/entity/b;

    iget v1, v1, Lchat/ola/vn/entity/b;->f:I

    int-to-long v1, v1

    invoke-static {v1, v2}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    invoke-direct {p0}, Lchat/ola/vn/me/OlaClanMePageActivity;->P()V

    invoke-direct {p0}, Lchat/ola/vn/me/OlaClanMePageActivity;->O()V

    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->M:Landroid/widget/TextView;

    iget-object v1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->e:Lchat/ola/vn/entity/b;

    iget-short v1, v1, Lchat/ola/vn/entity/b;->j:S

    invoke-static {p0, v1}, Lchat/ola/vn/util/m;->a(Landroid/content/Context;I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :goto_0
    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->k:Lchat/ola/vn/r/a/e;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/e;->j()I

    move-result v0

    if-nez v0, :cond_2

    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lchat/ola/vn/me/OlaClanMePageActivity;->a_(I)V

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->w:Lchat/ola/vn/b/q;

    invoke-virtual {v0}, Lchat/ola/vn/b/q;->notifyDataSetChanged()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private L()Z
    .locals 2

    :try_start_0
    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->e:Lchat/ola/vn/entity/b;

    iget-object v1, v1, Lchat/ola/vn/entity/b;->b:Ljava/lang/String;

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    :catch_0
    const/4 v0, 0x0

    return v0
.end method

.method private M()Z
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->e:Lchat/ola/vn/entity/b;

    iget-object v0, v0, Lchat/ola/vn/entity/b;->e:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    :catch_0
    const/4 v0, 0x0

    return v0
.end method

.method private N()V
    .locals 5

    invoke-direct {p0}, Lchat/ola/vn/me/OlaClanMePageActivity;->M()Z

    move-result v0

    const/4 v1, 0x0

    const/16 v2, 0x8

    if-eqz v0, :cond_1

    invoke-direct {p0}, Lchat/ola/vn/me/OlaClanMePageActivity;->L()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->m:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->o:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->m:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->o:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    :goto_0
    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->H:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    goto :goto_1

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->m:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->o:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->H:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    :goto_1
    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    iget-object v2, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->e:Lchat/ola/vn/entity/b;

    iget-object v2, v2, Lchat/ola/vn/entity/b;->a:Ljava/lang/String;

    iget-object v3, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->n:Lchat/ola/vn/view/OlaCachedImageView;

    iget-boolean v4, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->I:Z

    invoke-virtual {v0, v2, v3, v4}, Lchat/ola/vn/c/t;->e(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Z)V

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    iget-object v2, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->e:Lchat/ola/vn/entity/b;

    iget-object v2, v2, Lchat/ola/vn/entity/b;->a:Ljava/lang/String;

    iget-object v3, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->l:Lchat/ola/vn/view/OlaCachedImageView;

    iget-boolean v4, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->I:Z

    invoke-virtual {v0, v2, v3, v4}, Lchat/ola/vn/c/t;->d(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Z)V

    iput-boolean v1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->I:Z

    return-void
.end method

.method private O()V
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->e:Lchat/ola/vn/entity/b;

    iget-object v0, v0, Lchat/ola/vn/entity/b;->b:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->B:Landroid/widget/TextView;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "@"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->e:Lchat/ola/vn/entity/b;

    iget-object v2, v2, Lchat/ola/vn/entity/b;->b:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/util/i;->c(Ljava/lang/String;)Ljava/lang/CharSequence;

    move-result-object v1

    :goto_0
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_1

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->B:Landroid/widget/TextView;

    const-string v1, ""

    goto :goto_0

    :goto_1
    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->e:Lchat/ola/vn/entity/b;

    iget-object v0, v0, Lchat/ola/vn/entity/b;->c:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->C:Landroid/widget/TextView;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "@"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->e:Lchat/ola/vn/entity/b;

    iget-object v2, v2, Lchat/ola/vn/entity/b;->c:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/util/i;->c(Ljava/lang/String;)Ljava/lang/CharSequence;

    move-result-object v1

    :goto_2
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_3

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->C:Landroid/widget/TextView;

    const-string v1, ""

    goto :goto_2

    :goto_3
    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->e:Lchat/ola/vn/entity/b;

    iget-object v0, v0, Lchat/ola/vn/entity/b;->d:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->D:Landroid/widget/TextView;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "@"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->e:Lchat/ola/vn/entity/b;

    iget-object v2, v2, Lchat/ola/vn/entity/b;->d:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/util/i;->c(Ljava/lang/String;)Ljava/lang/CharSequence;

    move-result-object v1

    :goto_4
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->D:Landroid/widget/TextView;

    const-string v1, ""

    goto :goto_4

    return-void
.end method

.method private P()V
    .locals 8

    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->e:Lchat/ola/vn/entity/b;

    iget-wide v0, v0, Lchat/ola/vn/entity/b;->i:J

    const-wide/16 v2, 0x0

    cmp-long v4, v0, v2

    if-eqz v4, :cond_0

    new-instance v0, Ljava/text/SimpleDateFormat;

    const-string v1, "dd/MM/yyyy"

    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v2

    invoke-direct {v0, v1, v2}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;Ljava/util/Locale;)V

    iget-object v1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->A:Landroid/widget/TextView;

    const v2, 0x7f0f0478

    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    new-instance v5, Ljava/util/Date;

    iget-object v6, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->e:Lchat/ola/vn/entity/b;

    iget-wide v6, v6, Lchat/ola/vn/entity/b;->i:J

    invoke-direct {v5, v6, v7}, Ljava/util/Date;-><init>(J)V

    invoke-virtual {v0, v5}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v0

    aput-object v0, v3, v4

    invoke-virtual {p0, v2, v3}, Lchat/ola/vn/me/OlaClanMePageActivity;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->A:Landroid/widget/TextView;

    const v1, 0x7f0f0673

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    return-void
.end method

.method private Q()V
    .locals 3

    invoke-direct {p0}, Lchat/ola/vn/me/OlaClanMePageActivity;->M()Z

    move-result v0

    const/16 v1, 0x8

    const/4 v2, 0x0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->q:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->r:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    invoke-direct {p0}, Lchat/ola/vn/me/OlaClanMePageActivity;->L()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->K:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->L:Landroid/view/View;

    goto :goto_1

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->K:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->L:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->q:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->e:Lchat/ola/vn/entity/b;

    iget-boolean v0, v0, Lchat/ola/vn/entity/b;->k:Z

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->u:Landroid/widget/ImageView;

    const v1, 0x7f080787

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->v:Landroid/widget/TextView;

    const v1, 0x7f0f04f9

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->v:Landroid/widget/TextView;

    sget v1, Lchat/ola/vn/f;->H:I

    :goto_0
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    return-void

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->u:Landroid/widget/ImageView;

    const v1, 0x7f0806c7

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->v:Landroid/widget/TextView;

    const v1, 0x7f0f04f8

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->v:Landroid/widget/TextView;

    sget v1, Lchat/ola/vn/f;->A:I

    goto :goto_0

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->q:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->r:Landroid/view/View;

    :goto_1
    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    return-void
.end method

.method private R()V
    .locals 9

    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->e:Lchat/ola/vn/entity/b;

    if-nez v0, :cond_0

    return-void

    :cond_0
    new-instance v0, Lchat/ola/vn/me/OlaClanMePageActivity$8;

    invoke-direct {v0, p0}, Lchat/ola/vn/me/OlaClanMePageActivity$8;-><init>(Lchat/ola/vn/me/OlaClanMePageActivity;)V

    iget-object v1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->e:Lchat/ola/vn/entity/b;

    iget-boolean v1, v1, Lchat/ola/vn/entity/b;->k:Z

    const/4 v2, 0x1

    if-eqz v1, :cond_1

    const v1, 0x7f0f009b

    invoke-virtual {p0, v1}, Lchat/ola/vn/me/OlaClanMePageActivity;->getString(I)Ljava/lang/String;

    move-result-object v4

    const v1, 0x7f0f0165

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "Clan #"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v6, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->e:Lchat/ola/vn/entity/b;

    iget-object v6, v6, Lchat/ola/vn/entity/b;->a:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    aput-object v5, v2, v3

    invoke-virtual {p0, v1, v2}, Lchat/ola/vn/me/OlaClanMePageActivity;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    const v1, 0x7f0f057e

    invoke-virtual {p0, v1}, Lchat/ola/vn/me/OlaClanMePageActivity;->getString(I)Ljava/lang/String;

    move-result-object v6

    const v1, 0x7f0f0480

    invoke-virtual {p0, v1}, Lchat/ola/vn/me/OlaClanMePageActivity;->getString(I)Ljava/lang/String;

    move-result-object v7

    new-instance v8, Lchat/ola/vn/me/OlaClanMePageActivity$9;

    invoke-direct {v8, p0, v0}, Lchat/ola/vn/me/OlaClanMePageActivity$9;-><init>(Lchat/ola/vn/me/OlaClanMePageActivity;Lchat/ola/vn/entry/c/e;)V

    move-object v3, p0

    invoke-static/range {v3 .. v8}, Lchat/ola/vn/i/i;->d(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/content/DialogInterface$OnClickListener;)Lchat/ola/vn/i/f;

    return-void

    :cond_1
    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "#"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v4, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->e:Lchat/ola/vn/entity/b;

    iget-object v4, v4, Lchat/ola/vn/entity/b;->a:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v0}, Lchat/ola/vn/entry/c/f;->a(Lchat/ola/vn/entry/c/e;)S

    move-result v0

    invoke-virtual {v1, v3, v2, v0}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;ZS)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->e:Lchat/ola/vn/entity/b;

    iput-boolean v2, v0, Lchat/ola/vn/entity/b;->k:Z

    invoke-direct {p0}, Lchat/ola/vn/me/OlaClanMePageActivity;->K()V

    return-void
.end method

.method private S()V
    .locals 2

    iget-boolean v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->y:Z

    if-nez v0, :cond_1

    invoke-static {}, Lchat/ola/vn/c/x;->e()Z

    move-result v0

    if-eqz v0, :cond_0

    sget-object v0, Lchat/ola/vn/util/c/a;->s:Landroid/net/Uri;

    invoke-static {p0, v0}, Lchat/ola/vn/util/n;->a(Landroid/content/Context;Landroid/net/Uri;)Z

    :cond_0
    iget-boolean v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->y:Z

    const/4 v1, 0x1

    xor-int/2addr v0, v1

    iput-boolean v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->y:Z

    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->x:Landroid/support/v4/widget/SwipeRefreshLayout;

    invoke-virtual {v0, v1}, Landroid/support/v4/widget/SwipeRefreshLayout;->setRefreshing(Z)V

    :cond_1
    return-void
.end method

.method private T()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->z:Ljava/lang/Runnable;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->z:Ljava/lang/Runnable;

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->c(Ljava/lang/Runnable;)V

    :cond_0
    iget-boolean v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->y:Z

    if-eqz v0, :cond_2

    invoke-static {}, Lchat/ola/vn/c/x;->e()Z

    move-result v0

    if-eqz v0, :cond_1

    sget-object v0, Lchat/ola/vn/util/c/a;->t:Landroid/net/Uri;

    invoke-static {p0, v0}, Lchat/ola/vn/util/n;->a(Landroid/content/Context;Landroid/net/Uri;)Z

    :cond_1
    iget-boolean v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->y:Z

    xor-int/lit8 v0, v0, 0x1

    iput-boolean v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->y:Z

    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->x:Landroid/support/v4/widget/SwipeRefreshLayout;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/support/v4/widget/SwipeRefreshLayout;->setRefreshing(Z)V

    :cond_2
    return-void
.end method

.method static synthetic a(Lchat/ola/vn/me/OlaClanMePageActivity;)Ljava/lang/Runnable;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->z:Ljava/lang/Runnable;

    return-object p0
.end method

.method static synthetic a(Lchat/ola/vn/me/OlaClanMePageActivity;Ljava/lang/Runnable;)Ljava/lang/Runnable;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->z:Ljava/lang/Runnable;

    return-object p1
.end method

.method public static a(Landroid/content/Context;Ljava/lang/String;)V
    .locals 0

    :try_start_0
    invoke-static {p0, p1}, Lchat/ola/vn/me/OlaClanMePageActivity;->b(Landroid/content/Context;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic a(Lchat/ola/vn/me/OlaClanMePageActivity;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/me/OlaClanMePageActivity;->g(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/me/OlaClanMePageActivity;Z)Z
    .locals 0

    iput-boolean p1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->y:Z

    return p1
.end method

.method private static b(Landroid/content/Context;Ljava/lang/String;)V
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

    invoke-static {p0}, Lchat/ola/vn/me/OlaClanMePageActivity;->h(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic b(Lchat/ola/vn/me/OlaClanMePageActivity;Z)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/me/OlaClanMePageActivity;->c(Z)V

    return-void
.end method

.method static synthetic b(Lchat/ola/vn/me/OlaClanMePageActivity;)Z
    .locals 0

    iget-boolean p0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->y:Z

    return p0
.end method

.method static synthetic c(Lchat/ola/vn/me/OlaClanMePageActivity;)Landroid/support/v4/widget/SwipeRefreshLayout;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->x:Landroid/support/v4/widget/SwipeRefreshLayout;

    return-object p0
.end method

.method private c(Z)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->p:Landroid/view/View;

    if-eqz p1, :cond_0

    const/4 p1, 0x0

    goto :goto_0

    :cond_0
    const/16 p1, 0x8

    :goto_0
    invoke-virtual {v0, p1}, Landroid/view/View;->setVisibility(I)V

    return-void
.end method

.method static synthetic d(Lchat/ola/vn/me/OlaClanMePageActivity;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/me/OlaClanMePageActivity;->S()V

    return-void
.end method

.method static synthetic e(Lchat/ola/vn/me/OlaClanMePageActivity;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/me/OlaClanMePageActivity;->I()V

    return-void
.end method

.method static synthetic f(Lchat/ola/vn/me/OlaClanMePageActivity;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/me/OlaClanMePageActivity;->K()V

    return-void
.end method

.method private g(Ljava/lang/String;)V
    .locals 4

    :try_start_0
    invoke-static {p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :try_start_1
    iget-object p1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->p:Landroid/view/View;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->p:Landroid/view/View;

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

    invoke-direct {p0, v2}, Lchat/ola/vn/me/OlaClanMePageActivity;->c(Z)V

    if-eqz v1, :cond_1

    invoke-static {v0}, Lchat/ola/vn/util/m;->t(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    new-array v2, v2, [Ljava/lang/String;

    const-string v3, "name"

    aput-object v3, v2, p1

    new-instance p1, Lchat/ola/vn/me/OlaClanMePageActivity$6;

    invoke-direct {p1, p0}, Lchat/ola/vn/me/OlaClanMePageActivity$6;-><init>(Lchat/ola/vn/me/OlaClanMePageActivity;)V

    invoke-virtual {v1, v0, v2, p1}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;[Ljava/lang/String;Lchat/ola/vn/p/d;)V

    return-void

    :cond_1
    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    new-instance v1, Lchat/ola/vn/me/OlaClanMePageActivity$7;

    invoke-direct {v1, p0}, Lchat/ola/vn/me/OlaClanMePageActivity$7;-><init>(Lchat/ola/vn/me/OlaClanMePageActivity;)V

    invoke-virtual {p1, v0, v1}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Lchat/ola/vn/p/i;)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_3

    :catch_3
    :cond_2
    return-void
.end method

.method private static h(Ljava/lang/String;)V
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

    invoke-static {}, Lchat/ola/vn/me/OlaClanMePageActivity;->J()V

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

    iget-boolean v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->E:Z

    return v0
.end method

.method public D()V
    .locals 1

    const/4 v0, 0x1

    iput-boolean v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->I:Z

    invoke-direct {p0}, Lchat/ola/vn/me/OlaClanMePageActivity;->K()V

    return-void
.end method

.method public E()V
    .locals 1

    const/4 v0, 0x1

    iput-boolean v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->I:Z

    invoke-direct {p0}, Lchat/ola/vn/me/OlaClanMePageActivity;->K()V

    return-void
.end method

.method public F()V
    .locals 0

    return-void
.end method

.method public G()V
    .locals 0

    return-void
.end method

.method protected a()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/me/OlaClanMePageActivity;->K()V

    return-void
.end method

.method public a(ILjava/lang/String;[B[Lchat/ola/vn/entity/d;S)V
    .locals 0

    invoke-super/range {p0 .. p5}, Lchat/ola/vn/c;->a(ILjava/lang/String;[B[Lchat/ola/vn/entity/d;S)V

    const/16 p1, 0x50

    if-ne p5, p1, :cond_0

    invoke-direct {p0}, Lchat/ola/vn/me/OlaClanMePageActivity;->T()V

    const/4 p1, 0x0

    invoke-direct {p0, p1}, Lchat/ola/vn/me/OlaClanMePageActivity;->c(Z)V

    iput-boolean p1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->F:Z

    iput-boolean p1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->E:Z

    :cond_0
    return-void
.end method

.method public a(Lchat/ola/vn/entity/b;S)V
    .locals 1

    const/16 v0, 0x44

    if-ne p2, v0, :cond_2

    iput-object p1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->e:Lchat/ola/vn/entity/b;

    if-eqz p1, :cond_1

    iget-object p2, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->k:Lchat/ola/vn/r/a/e;

    invoke-virtual {p2}, Lchat/ola/vn/r/a/e;->a()S

    move-result p2

    const/4 v0, 0x1

    if-ne p2, v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    iput-boolean v0, p1, Lchat/ola/vn/entity/b;->k:Z

    :cond_1
    invoke-direct {p0}, Lchat/ola/vn/me/OlaClanMePageActivity;->K()V

    :cond_2
    return-void
.end method

.method public a(Ljava/lang/String;S)V
    .locals 1

    const/16 v0, 0x44

    if-ne p2, v0, :cond_0

    new-instance p2, Lchat/ola/vn/entity/b;

    invoke-direct {p2}, Lchat/ola/vn/entity/b;-><init>()V

    iput-object p2, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->e:Lchat/ola/vn/entity/b;

    iget-object p2, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->e:Lchat/ola/vn/entity/b;

    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->G:Ljava/lang/String;

    iput-object v0, p2, Lchat/ola/vn/entity/b;->a:Ljava/lang/String;

    iget-object p2, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->e:Lchat/ola/vn/entity/b;

    iput-object p1, p2, Lchat/ola/vn/entity/b;->e:Ljava/lang/String;

    const/4 p1, 0x0

    invoke-direct {p0, p1}, Lchat/ola/vn/me/OlaClanMePageActivity;->c(Z)V

    invoke-direct {p0}, Lchat/ola/vn/me/OlaClanMePageActivity;->K()V

    :cond_0
    return-void
.end method

.method public a(Ljava/lang/String;SLjava/util/List;S)V
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "S",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/g;",
            ">;S)V"
        }
    .end annotation

    const/16 v0, 0x50

    if-ne p4, v0, :cond_3

    iget-object p4, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->e:Lchat/ola/vn/entity/b;

    const/4 v0, 0x0

    if-eqz p4, :cond_1

    iget-object p4, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->e:Lchat/ola/vn/entity/b;

    const/4 v1, 0x1

    if-ne p2, v1, :cond_0

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    iput-boolean v1, p4, Lchat/ola/vn/entity/b;->k:Z

    invoke-direct {p0}, Lchat/ola/vn/me/OlaClanMePageActivity;->K()V

    :cond_1
    invoke-direct {p0}, Lchat/ola/vn/me/OlaClanMePageActivity;->T()V

    invoke-direct {p0, v0}, Lchat/ola/vn/me/OlaClanMePageActivity;->c(Z)V

    iput-boolean v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->F:Z

    iget-object p4, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->k:Lchat/ola/vn/r/a/e;

    invoke-virtual {p4}, Lchat/ola/vn/r/a/e;->k()J

    move-result-wide v0

    const-wide/16 v2, 0x0

    cmp-long p4, v0, v2

    if-nez p4, :cond_2

    iget-object p4, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->k:Lchat/ola/vn/r/a/e;

    invoke-virtual {p4, p1, p2, p3}, Lchat/ola/vn/r/a/e;->b(Ljava/lang/String;SLjava/util/List;)V

    goto :goto_1

    :cond_2
    iget-object p1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->k:Lchat/ola/vn/r/a/e;

    invoke-virtual {p1, p3}, Lchat/ola/vn/r/a/e;->c(Ljava/util/List;)V

    :goto_1
    iget-object p1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->j:Lchat/ola/vn/b/u;

    invoke-virtual {p1}, Lchat/ola/vn/b/u;->notifyDataSetChanged()V

    :cond_3
    return-void
.end method

.method public a_(I)V
    .locals 4

    iget-boolean p1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->F:Z

    if-nez p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->e:Lchat/ola/vn/entity/b;

    if-nez p1, :cond_0

    return-void

    :cond_0
    const/4 p1, 0x1

    iput-boolean p1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->F:Z

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "#"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->e:Lchat/ola/vn/entity/b;

    iget-object v1, v1, Lchat/ola/vn/entity/b;->a:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->k:Lchat/ola/vn/r/a/e;

    invoke-virtual {v1}, Lchat/ola/vn/r/a/e;->k()J

    move-result-wide v1

    const/16 v3, 0x50

    invoke-virtual {p1, v0, v1, v2, v3}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;JS)V

    :cond_1
    return-void
.end method

.method public b_()V
    .locals 0

    return-void
.end method

.method public f(Ljava/lang/String;)V
    .locals 0

    return-void
.end method

.method public finish()V
    .locals 2

    invoke-super {p0}, Lchat/ola/vn/c;->finish()V

    const v0, 0x7f01003a

    const v1, 0x7f01003b

    :try_start_0
    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/me/OlaClanMePageActivity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public j()V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->j:Lchat/ola/vn/b/u;

    invoke-virtual {v0}, Lchat/ola/vn/b/u;->notifyDataSetChanged()V

    invoke-direct {p0}, Lchat/ola/vn/me/OlaClanMePageActivity;->K()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 7

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const/4 v0, 0x3

    const/4 v1, 0x0

    const/4 v2, 0x0

    const/4 v3, 0x1

    sparse-switch p1, :sswitch_data_0

    return-void

    :sswitch_0
    iget-object p1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->e:Lchat/ola/vn/entity/b;

    :goto_0
    iget-object p1, p1, Lchat/ola/vn/entity/b;->a:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    return-void

    :sswitch_1
    iget-object p1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->e:Lchat/ola/vn/entity/b;

    iget-object p1, p1, Lchat/ola/vn/entity/b;->a:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_2

    new-array p1, v3, [Lchat/ola/vn/mediastore/OlaMediaEntity;

    const/4 v4, 0x0

    :goto_1
    array-length v5, p1

    if-ge v4, v5, :cond_0

    new-instance v5, Lchat/ola/vn/mediastore/OlaMediaEntity;

    iget-object v6, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->e:Lchat/ola/vn/entity/b;

    iget-object v6, v6, Lchat/ola/vn/entity/b;->a:Ljava/lang/String;

    invoke-static {v6}, Lchat/ola/vn/c/f;->e(Ljava/lang/String;)Lchat/ola/vn/c/f;

    move-result-object v6

    invoke-virtual {v6}, Lchat/ola/vn/c/f;->b()Ljava/lang/String;

    move-result-object v6

    invoke-direct {v5, v6, v0, v3}, Lchat/ola/vn/mediastore/OlaMediaEntity;-><init>(Ljava/lang/String;IS)V

    aput-object v5, p1, v4

    add-int/lit8 v4, v4, 0x1

    goto :goto_1

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->n:Lchat/ola/vn/view/OlaCachedImageView;

    :goto_2
    invoke-static {p0, v0, v1, v2, p1}, Lchat/ola/vn/activity/OlaImageViewerActivity;->a(Landroid/content/Context;Landroid/view/View;Landroid/graphics/Bitmap;I[Lchat/ola/vn/mediastore/OlaMediaEntity;)V

    return-void

    :sswitch_2
    iget-object p1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->e:Lchat/ola/vn/entity/b;

    iget-object p1, p1, Lchat/ola/vn/entity/b;->a:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->k(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "#"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p0, p1, v1}, Lchat/ola/vn/me/OlaMeComposerActivity;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V

    return-void

    :sswitch_3
    invoke-virtual {p0}, Lchat/ola/vn/me/OlaClanMePageActivity;->finish()V

    return-void

    :sswitch_4
    invoke-direct {p0}, Lchat/ola/vn/me/OlaClanMePageActivity;->R()V

    return-void

    :sswitch_5
    iget-object p1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->e:Lchat/ola/vn/entity/b;

    invoke-static {p0, p1}, Lchat/ola/vn/activity/ClanManagementActivity;->a(Landroid/content/Context;Lchat/ola/vn/entity/b;)V

    return-void

    :sswitch_6
    iget-object p1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->e:Lchat/ola/vn/entity/b;

    iget-object p1, p1, Lchat/ola/vn/entity/b;->a:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->e:Lchat/ola/vn/entity/b;

    iget-object p1, p1, Lchat/ola/vn/entity/b;->a:Ljava/lang/String;

    invoke-static {p0, p1, p0}, Lchat/ola/vn/activity/OlaCropImageActivity;->b(Landroid/content/Context;Ljava/lang/String;Lchat/ola/vn/activity/OlaCropImageActivity$a;)V

    return-void

    :sswitch_7
    iget-object p1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->e:Lchat/ola/vn/entity/b;

    iget-object p1, p1, Lchat/ola/vn/entity/b;->a:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->e:Lchat/ola/vn/entity/b;

    iget-object p1, p1, Lchat/ola/vn/entity/b;->a:Ljava/lang/String;

    invoke-static {p0, p1, p0}, Lchat/ola/vn/activity/OlaCropImageActivity;->a(Landroid/content/Context;Ljava/lang/String;Lchat/ola/vn/activity/OlaCropImageActivity$a;)V

    return-void

    :sswitch_8
    iget-object p1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->e:Lchat/ola/vn/entity/b;

    iget-object p1, p1, Lchat/ola/vn/entity/b;->a:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->e:Lchat/ola/vn/entity/b;

    iget-object p1, p1, Lchat/ola/vn/entity/b;->a:Ljava/lang/String;

    invoke-static {p0, p1}, Lchat/ola/vn/activity/CreateClanActivity;->a(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :sswitch_9
    iget-object p1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->e:Lchat/ola/vn/entity/b;

    iget-object p1, p1, Lchat/ola/vn/entity/b;->a:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_2

    new-array p1, v3, [Lchat/ola/vn/mediastore/OlaMediaEntity;

    const/4 v4, 0x0

    :goto_3
    array-length v5, p1

    if-ge v4, v5, :cond_1

    new-instance v5, Lchat/ola/vn/mediastore/OlaMediaEntity;

    iget-object v6, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->e:Lchat/ola/vn/entity/b;

    iget-object v6, v6, Lchat/ola/vn/entity/b;->a:Ljava/lang/String;

    invoke-static {v6}, Lchat/ola/vn/c/f;->f(Ljava/lang/String;)Lchat/ola/vn/c/f;

    move-result-object v6

    invoke-virtual {v6}, Lchat/ola/vn/c/f;->b()Ljava/lang/String;

    move-result-object v6

    invoke-direct {v5, v6, v0, v3}, Lchat/ola/vn/mediastore/OlaMediaEntity;-><init>(Ljava/lang/String;IS)V

    aput-object v5, p1, v4

    add-int/lit8 v4, v4, 0x1

    goto :goto_3

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->l:Lchat/ola/vn/view/OlaCachedImageView;

    goto/16 :goto_2

    :sswitch_a
    iget-object p1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->e:Lchat/ola/vn/entity/b;

    goto/16 :goto_0

    :sswitch_b
    iget-object p1, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->e:Lchat/ola/vn/entity/b;

    iget-object p1, p1, Lchat/ola/vn/entity/b;->a:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->j(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_2

    invoke-static {p0, p1}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Landroid/content/Context;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_2
    :sswitch_c
    return-void

    :sswitch_data_0
    .sparse-switch
        0x7f090030 -> :sswitch_b
        0x7f090035 -> :sswitch_a
        0x7f09016e -> :sswitch_c
        0x7f0901d5 -> :sswitch_9
        0x7f0901d6 -> :sswitch_8
        0x7f0901ef -> :sswitch_7
        0x7f0901f3 -> :sswitch_6
        0x7f0901f4 -> :sswitch_5
        0x7f090223 -> :sswitch_4
        0x7f09039a -> :sswitch_3
        0x7f0903de -> :sswitch_2
        0x7f0903e7 -> :sswitch_1
        0x7f0905d5 -> :sswitch_0
    .end sparse-switch
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 0

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    const p1, 0x7f0b017d

    invoke-virtual {p0, p1}, Lchat/ola/vn/me/OlaClanMePageActivity;->setContentView(I)V

    invoke-direct {p0}, Lchat/ola/vn/me/OlaClanMePageActivity;->C()V

    return-void
.end method

.method protected onDestroy()V
    .locals 1

    invoke-super {p0}, Lchat/ola/vn/c;->onDestroy()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/me/OlaClanMePageActivity;->e:Lchat/ola/vn/entity/b;

    return-void
.end method

.method protected onPause()V
    .locals 0

    invoke-super {p0}, Lchat/ola/vn/c;->onPause()V

    return-void
.end method
