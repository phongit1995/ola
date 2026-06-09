.class public Lchat/ola/vn/me/OlaUserMePageActivity;
.super Lchat/ola/vn/c;

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Lchat/ola/vn/activity/OlaCropImageActivity$a;
.implements Lchat/ola/vn/b/j$a;


# instance fields
.field protected A:Landroid/view/View;

.field protected B:Landroid/widget/TextView;

.field protected C:[Landroid/widget/TextView;

.field protected D:Landroid/view/View;

.field protected E:Landroid/widget/TextView;

.field protected F:Lchat/ola/vn/view/OlaCachedImageView;

.field protected G:Landroid/widget/ImageView;

.field protected H:Landroid/widget/TextView;

.field protected I:Landroid/widget/ImageView;

.field protected J:Landroid/widget/TextView;

.field private K:Lchat/ola/vn/b/q;

.field private L:[Lchat/ola/vn/view/OlaCachedImageView;

.field private M:Landroid/support/v4/widget/SwipeRefreshLayout;

.field private N:Z

.field private O:Ljava/lang/Runnable;

.field private P:Landroid/view/View;

.field private Q:Lchat/ola/vn/view/OlaCachedImageView;

.field private R:Landroid/widget/TextView;

.field private S:Landroid/widget/TextView;

.field private T:Landroid/widget/TextView;

.field private U:Landroid/widget/TextView;

.field private V:Z

.field private W:Z

.field private X:Ljava/lang/String;

.field private Y:Landroid/view/View;

.field private Z:Z

.field private aa:Landroid/view/View;

.field private ab:Landroid/view/View;

.field private ac:Landroid/view/View;

.field private ad:Landroid/view/View;

.field private ae:Landroid/widget/FrameLayout;

.field private af:Z

.field protected e:Lchat/ola/vn/entity/ag;

.field protected f:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

.field protected g:Landroid/widget/TextView;

.field protected h:Landroid/view/View;

.field protected i:Landroid/widget/TextView;

.field protected j:Landroid/view/View;

.field protected k:Landroid/widget/TextView;

.field protected l:Landroid/widget/ListView;

.field protected m:Lchat/ola/vn/b/u;

.field protected n:Lchat/ola/vn/r/a/e;

.field protected o:Lchat/ola/vn/view/OlaCachedImageView;

.field protected p:Landroid/view/View;

.field protected q:Lchat/ola/vn/view/OlaCachedImageView;

.field protected r:Landroid/view/View;

.field protected s:Lchat/ola/vn/view/OlaCachedImageView;

.field protected t:[Lchat/ola/vn/view/OlaCachedImageView;

.field protected u:Landroid/view/View;

.field protected v:Landroid/view/View;

.field protected w:Landroid/view/View;

.field protected x:Landroid/view/View;

.field protected y:Landroid/widget/TextView;

.field protected z:[Landroid/view/View;


# direct methods
.method public constructor <init>()V
    .locals 2

    invoke-direct {p0}, Lchat/ola/vn/c;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->N:Z

    const/4 v1, 0x0

    iput-object v1, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->O:Ljava/lang/Runnable;

    const/4 v1, 0x1

    iput-boolean v1, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->V:Z

    iput-boolean v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->W:Z

    iput-boolean v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->Z:Z

    iput-boolean v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->af:Z

    return-void
.end method

.method private C()V
    .locals 9

    const v0, 0x7f090242

    :try_start_0
    invoke-virtual {p0, v0}, Lchat/ola/vn/me/OlaUserMePageActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/FrameLayout;

    iput-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->ae:Landroid/widget/FrameLayout;

    invoke-virtual {p0}, Lchat/ola/vn/me/OlaUserMePageActivity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    const-string v1, "contactId"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->X:Ljava/lang/String;

    const v0, 0x7f09039a

    invoke-virtual {p0, v0}, Lchat/ola/vn/me/OlaUserMePageActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f090030

    invoke-virtual {p0, v0}, Lchat/ola/vn/me/OlaUserMePageActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->Y:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->Y:Landroid/view/View;

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f0903f3

    invoke-virtual {p0, v0}, Lchat/ola/vn/me/OlaUserMePageActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/support/v4/widget/SwipeRefreshLayout;

    iput-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->M:Landroid/support/v4/widget/SwipeRefreshLayout;

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->M:Landroid/support/v4/widget/SwipeRefreshLayout;

    const/4 v1, 0x1

    new-array v2, v1, [I

    const v3, 0x7f06003d

    const/4 v4, 0x0

    aput v3, v2, v4

    invoke-virtual {v0, v2}, Landroid/support/v4/widget/SwipeRefreshLayout;->setColorSchemeResources([I)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->M:Landroid/support/v4/widget/SwipeRefreshLayout;

    new-instance v2, Lchat/ola/vn/me/OlaUserMePageActivity$1;

    invoke-direct {v2, p0}, Lchat/ola/vn/me/OlaUserMePageActivity$1;-><init>(Lchat/ola/vn/me/OlaUserMePageActivity;)V

    invoke-virtual {v0, v2}, Landroid/support/v4/widget/SwipeRefreshLayout;->setOnRefreshListener(Landroid/support/v4/widget/SwipeRefreshLayout$OnRefreshListener;)V

    const v0, 0x7f090450

    invoke-virtual {p0, v0}, Lchat/ola/vn/me/OlaUserMePageActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    iput-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->f:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->f:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    new-instance v2, Lchat/ola/vn/me/OlaUserMePageActivity$7;

    invoke-direct {v2, p0}, Lchat/ola/vn/me/OlaUserMePageActivity$7;-><init>(Lchat/ola/vn/me/OlaUserMePageActivity;)V

    invoke-virtual {v0, v2}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setOnEditorActionListener(Landroid/widget/TextView$OnEditorActionListener;)V

    new-instance v0, Lchat/ola/vn/b/q;

    invoke-direct {v0, p0}, Lchat/ola/vn/b/q;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->K:Lchat/ola/vn/b/q;

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->K:Lchat/ola/vn/b/q;

    invoke-static {}, Lchat/ola/vn/g;->a()Ljava/util/List;

    move-result-object v2

    invoke-virtual {v0, v2}, Lchat/ola/vn/b/q;->a(Ljava/util/List;)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->K:Lchat/ola/vn/b/q;

    new-instance v2, Lchat/ola/vn/b/q$a;

    iget-object v3, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->K:Lchat/ola/vn/b/q;

    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    invoke-direct {v2, v3}, Lchat/ola/vn/b/q$a;-><init>(Lchat/ola/vn/b/q;)V

    invoke-virtual {v0, v2}, Lchat/ola/vn/b/q;->a(Landroid/widget/Filter;)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->f:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    iget-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->K:Lchat/ola/vn/b/q;

    invoke-virtual {v0, v2}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setAdapter(Landroid/widget/BaseAdapter;)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->f:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    new-instance v2, Lchat/ola/vn/me/OlaUserMePageActivity$8;

    invoke-direct {v2, p0}, Lchat/ola/vn/me/OlaUserMePageActivity$8;-><init>(Lchat/ola/vn/me/OlaUserMePageActivity;)V

    invoke-virtual {v0, v2}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setOnSuggestionSelectListener(Lchat/ola/vn/view/OlaQuickTypingSuggestedText$b;)V

    const v0, 0x7f0903b0

    invoke-virtual {p0, v0}, Lchat/ola/vn/me/OlaUserMePageActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ListView;

    iput-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->l:Landroid/widget/ListView;

    const v0, 0x7f090609

    invoke-virtual {p0, v0}, Lchat/ola/vn/me/OlaUserMePageActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->u:Landroid/view/View;

    new-instance v0, Lchat/ola/vn/r/a/e;

    invoke-direct {v0}, Lchat/ola/vn/r/a/e;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->n:Lchat/ola/vn/r/a/e;

    new-instance v0, Lchat/ola/vn/b/u;

    iget-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->n:Lchat/ola/vn/r/a/e;

    invoke-direct {v0, p0, v2}, Lchat/ola/vn/b/u;-><init>(Landroid/content/Context;Lchat/ola/vn/r/a/e;)V

    iput-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->m:Lchat/ola/vn/b/u;

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->m:Lchat/ola/vn/b/u;

    invoke-virtual {v0, p0}, Lchat/ola/vn/b/u;->a(Lchat/ola/vn/b/j$a;)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->m:Lchat/ola/vn/b/u;

    new-instance v2, Lchat/ola/vn/me/OlaUserMePageActivity$9;

    invoke-direct {v2, p0}, Lchat/ola/vn/me/OlaUserMePageActivity$9;-><init>(Lchat/ola/vn/me/OlaUserMePageActivity;)V

    invoke-virtual {v0, v2}, Lchat/ola/vn/b/u;->a(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->m:Lchat/ola/vn/b/u;

    new-instance v2, Lchat/ola/vn/me/OlaUserMePageActivity$10;

    invoke-direct {v2, p0}, Lchat/ola/vn/me/OlaUserMePageActivity$10;-><init>(Lchat/ola/vn/me/OlaUserMePageActivity;)V

    invoke-virtual {v0, v2}, Lchat/ola/vn/b/u;->a(Landroid/view/View$OnLongClickListener;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    invoke-static {p0}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v0

    const v2, 0x7f0b017c

    const/4 v3, 0x0

    invoke-virtual {v0, v2, v3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v0

    const v2, 0x7f090300

    invoke-virtual {v0, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    iput-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->D:Landroid/view/View;

    const v2, 0x7f090526

    invoke-virtual {v0, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/TextView;

    iput-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->E:Landroid/widget/TextView;

    const v2, 0x7f0902a7

    invoke-virtual {v0, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->F:Lchat/ola/vn/view/OlaCachedImageView;

    iget-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->F:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v2, p0}, Lchat/ola/vn/view/OlaCachedImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v2, 0x7f0905ec

    invoke-virtual {v0, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    iput-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->P:Landroid/view/View;

    iget-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->P:Landroid/view/View;

    invoke-virtual {v2, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v2, 0x7f0902b2

    invoke-virtual {v0, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->Q:Lchat/ola/vn/view/OlaCachedImageView;

    const v2, 0x7f09052b

    invoke-virtual {v0, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/TextView;

    iput-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->R:Landroid/widget/TextView;

    const v2, 0x7f090557

    invoke-virtual {v0, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/TextView;

    iput-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->S:Landroid/widget/TextView;

    const v2, 0x7f090558

    invoke-virtual {v0, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/TextView;

    iput-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->T:Landroid/widget/TextView;

    iget-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->T:Landroid/widget/TextView;

    invoke-virtual {v2, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v2, 0x7f090556

    invoke-virtual {v0, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/TextView;

    iput-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->U:Landroid/widget/TextView;

    const v2, 0x7f0905d5

    invoke-virtual {v0, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    invoke-virtual {v2, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v2, 0x7f09020e

    invoke-virtual {v0, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/TextView;

    iput-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->i:Landroid/widget/TextView;

    const v2, 0x7f0902c6

    invoke-virtual {v0, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/TextView;

    iput-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->k:Landroid/widget/TextView;

    const v2, 0x7f0902c5

    invoke-virtual {v0, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    iput-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->j:Landroid/view/View;

    const v2, 0x7f0902c7

    invoke-virtual {v0, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/view/ViewGroup;

    invoke-virtual {v2, v4}, Landroid/view/ViewGroup;->setClipChildren(Z)V

    invoke-virtual {v2, p0}, Landroid/view/ViewGroup;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v2, 0x7f090351

    invoke-virtual {v0, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    iput-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->x:Landroid/view/View;

    iget-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->x:Landroid/view/View;

    invoke-virtual {v2, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v2, 0x7f090350

    invoke-virtual {v0, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/TextView;

    iput-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->y:Landroid/widget/TextView;

    const v2, 0x7f090416

    invoke-virtual {v0, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    iput-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->v:Landroid/view/View;

    const v2, 0x7f09012e

    invoke-virtual {v0, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    iput-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->w:Landroid/view/View;

    iget-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->w:Landroid/view/View;

    invoke-virtual {v2, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v2, 0x7f0901d5

    invoke-virtual {v0, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->o:Lchat/ola/vn/view/OlaCachedImageView;

    iget-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->o:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v2, p0}, Lchat/ola/vn/view/OlaCachedImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v2, 0x7f0901ef

    invoke-virtual {v0, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    iput-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->p:Landroid/view/View;

    iget-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->p:Landroid/view/View;

    invoke-virtual {v2, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v2, 0x7f0903e7

    invoke-virtual {v0, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->q:Lchat/ola/vn/view/OlaCachedImageView;

    iget-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->q:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v2, p0}, Lchat/ola/vn/view/OlaCachedImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v2, 0x7f0901f3

    invoke-virtual {v0, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    iput-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->r:Landroid/view/View;

    iget-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->r:Landroid/view/View;

    invoke-virtual {v2, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v2, 0x7f09024b

    invoke-virtual {v0, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->s:Lchat/ola/vn/view/OlaCachedImageView;

    iget-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->s:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v2, p0}, Lchat/ola/vn/view/OlaCachedImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v2, 0x7f0901b9

    invoke-virtual {v0, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/TextView;

    iput-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->g:Landroid/widget/TextView;

    const v2, 0x7f09026c

    invoke-virtual {v0, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    iput-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->h:Landroid/view/View;

    const v2, 0x7f090035

    invoke-virtual {v0, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    iput-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->aa:Landroid/view/View;

    iget-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->aa:Landroid/view/View;

    invoke-virtual {v2, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v2, 0x7f090033

    invoke-virtual {v0, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/ImageView;

    iput-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->G:Landroid/widget/ImageView;

    const v2, 0x7f090034

    invoke-virtual {v0, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/TextView;

    iput-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->H:Landroid/widget/TextView;

    const v2, 0x7f090223

    invoke-virtual {v0, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    iput-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->ab:Landroid/view/View;

    iget-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->ab:Landroid/view/View;

    invoke-virtual {v2, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v2, 0x7f090221

    invoke-virtual {v0, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/ImageView;

    iput-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->I:Landroid/widget/ImageView;

    const v2, 0x7f090222

    invoke-virtual {v0, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/TextView;

    iput-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->J:Landroid/widget/TextView;

    const v2, 0x7f0903de

    invoke-virtual {v0, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    invoke-virtual {v2, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v2, 0x7f0901f4

    invoke-virtual {v0, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    iput-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->ac:Landroid/view/View;

    iget-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->ac:Landroid/view/View;

    invoke-virtual {v2, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v2, 0x7f0901f2

    invoke-virtual {v0, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    iput-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->ad:Landroid/view/View;

    const v2, 0x7f090363

    invoke-virtual {v0, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    invoke-virtual {v2, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v2, 0x7f090559

    invoke-virtual {v0, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    invoke-virtual {v2, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const/4 v2, 0x6

    new-array v2, v2, [Lchat/ola/vn/view/OlaCachedImageView;

    iput-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->t:[Lchat/ola/vn/view/OlaCachedImageView;

    iget-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->t:[Lchat/ola/vn/view/OlaCachedImageView;

    const v3, 0x7f090348

    invoke-virtual {v0, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Lchat/ola/vn/view/OlaCachedImageView;

    aput-object v3, v2, v4

    iget-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->t:[Lchat/ola/vn/view/OlaCachedImageView;

    const v3, 0x7f090349

    invoke-virtual {v0, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Lchat/ola/vn/view/OlaCachedImageView;

    aput-object v3, v2, v1

    iget-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->t:[Lchat/ola/vn/view/OlaCachedImageView;

    const v3, 0x7f09034c

    invoke-virtual {v0, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Lchat/ola/vn/view/OlaCachedImageView;

    const/4 v5, 0x2

    aput-object v3, v2, v5

    iget-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->t:[Lchat/ola/vn/view/OlaCachedImageView;

    const v3, 0x7f09034a

    invoke-virtual {v0, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Lchat/ola/vn/view/OlaCachedImageView;

    const/4 v6, 0x3

    aput-object v3, v2, v6

    iget-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->t:[Lchat/ola/vn/view/OlaCachedImageView;

    const v3, 0x7f09034b

    invoke-virtual {v0, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Lchat/ola/vn/view/OlaCachedImageView;

    const/4 v7, 0x4

    aput-object v3, v2, v7

    iget-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->t:[Lchat/ola/vn/view/OlaCachedImageView;

    const v3, 0x7f09034d

    invoke-virtual {v0, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Lchat/ola/vn/view/OlaCachedImageView;

    const/4 v8, 0x5

    aput-object v3, v2, v8

    const v2, 0x7f090230

    invoke-virtual {v0, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/TextView;

    iput-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->B:Landroid/widget/TextView;

    const v2, 0x7f090236

    invoke-virtual {v0, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    iput-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->A:Landroid/view/View;

    iget-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->A:Landroid/view/View;

    invoke-virtual {v2, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    new-array v2, v8, [Landroid/view/View;

    iput-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->z:[Landroid/view/View;

    iget-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->z:[Landroid/view/View;

    const v3, 0x7f090237

    invoke-virtual {v0, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    aput-object v3, v2, v4

    iget-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->z:[Landroid/view/View;

    const v3, 0x7f090238

    invoke-virtual {v0, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    aput-object v3, v2, v1

    iget-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->z:[Landroid/view/View;

    const v3, 0x7f090239

    invoke-virtual {v0, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    aput-object v3, v2, v5

    iget-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->z:[Landroid/view/View;

    const v3, 0x7f09023a

    invoke-virtual {v0, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    aput-object v3, v2, v6

    iget-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->z:[Landroid/view/View;

    const v3, 0x7f09023b

    invoke-virtual {v0, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    aput-object v3, v2, v7

    new-array v2, v8, [Lchat/ola/vn/view/OlaCachedImageView;

    iput-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->L:[Lchat/ola/vn/view/OlaCachedImageView;

    iget-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->L:[Lchat/ola/vn/view/OlaCachedImageView;

    const v3, 0x7f09022b

    invoke-virtual {v0, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Lchat/ola/vn/view/OlaCachedImageView;

    aput-object v3, v2, v4

    iget-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->L:[Lchat/ola/vn/view/OlaCachedImageView;

    const v3, 0x7f09022c

    invoke-virtual {v0, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Lchat/ola/vn/view/OlaCachedImageView;

    aput-object v3, v2, v1

    iget-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->L:[Lchat/ola/vn/view/OlaCachedImageView;

    const v3, 0x7f09022d

    invoke-virtual {v0, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Lchat/ola/vn/view/OlaCachedImageView;

    aput-object v3, v2, v5

    iget-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->L:[Lchat/ola/vn/view/OlaCachedImageView;

    const v3, 0x7f09022e

    invoke-virtual {v0, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Lchat/ola/vn/view/OlaCachedImageView;

    aput-object v3, v2, v6

    iget-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->L:[Lchat/ola/vn/view/OlaCachedImageView;

    const v3, 0x7f09022f

    invoke-virtual {v0, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Lchat/ola/vn/view/OlaCachedImageView;

    aput-object v3, v2, v7

    new-array v2, v8, [Landroid/widget/TextView;

    iput-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->C:[Landroid/widget/TextView;

    iget-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->C:[Landroid/widget/TextView;

    const v3, 0x7f090231

    invoke-virtual {v0, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Landroid/widget/TextView;

    aput-object v3, v2, v4

    iget-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->C:[Landroid/widget/TextView;

    const v3, 0x7f090232

    invoke-virtual {v0, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Landroid/widget/TextView;

    aput-object v3, v2, v1

    iget-object v1, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->C:[Landroid/widget/TextView;

    const v2, 0x7f090233

    invoke-virtual {v0, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/TextView;

    aput-object v2, v1, v5

    iget-object v1, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->C:[Landroid/widget/TextView;

    const v2, 0x7f090234

    invoke-virtual {v0, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/TextView;

    aput-object v2, v1, v6

    iget-object v1, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->C:[Landroid/widget/TextView;

    const v2, 0x7f090235

    invoke-virtual {v0, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/TextView;

    aput-object v2, v1, v7

    iget-object v1, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->l:Landroid/widget/ListView;

    invoke-virtual {v1, v0}, Landroid/widget/ListView;->addHeaderView(Landroid/view/View;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :try_start_2
    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->l:Landroid/widget/ListView;

    iget-object v1, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->m:Lchat/ola/vn/b/u;

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setAdapter(Landroid/widget/ListAdapter;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    return-void
.end method

.method private I()V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->n:Lchat/ola/vn/r/a/e;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/e;->e()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    invoke-direct {p0}, Lchat/ola/vn/me/OlaUserMePageActivity;->K()V

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->m:Lchat/ola/vn/b/u;

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
    .locals 5

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    const/4 v1, 0x0

    const/4 v2, 0x1

    if-nez v0, :cond_2

    iget-boolean v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->af:Z

    if-eqz v0, :cond_0

    return-void

    :cond_0
    iget-boolean v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->N:Z

    if-nez v0, :cond_1

    invoke-direct {p0, v2}, Lchat/ola/vn/me/OlaUserMePageActivity;->c(Z)V

    :cond_1
    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->X:Ljava/lang/String;

    new-instance v3, Lchat/ola/vn/me/OlaUserMePageActivity$13;

    invoke-direct {v3, p0}, Lchat/ola/vn/me/OlaUserMePageActivity$13;-><init>(Lchat/ola/vn/me/OlaUserMePageActivity;)V

    invoke-virtual {v0, v2, v3}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Lchat/ola/vn/p/d;)V

    goto/16 :goto_3

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->f:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    const/4 v3, 0x0

    invoke-virtual {v0, v3}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setAdapter(Landroid/widget/BaseAdapter;)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->f:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    iget-object v3, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-object v3, v3, Lchat/ola/vn/entity/ag;->c:Ljava/lang/String;

    invoke-virtual {v0, v3}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->f:Lchat/ola/vn/view/OlaQuickTypingSuggestedText;

    iget-object v3, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->K:Lchat/ola/vn/b/q;

    invoke-virtual {v0, v3}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText;->setAdapter(Landroid/widget/BaseAdapter;)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-object v0, v0, Lchat/ola/vn/entity/ag;->a:Ljava/lang/CharSequence;

    if-eqz v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->g:Landroid/widget/TextView;

    iget-object v3, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-object v3, v3, Lchat/ola/vn/entity/ag;->a:Ljava/lang/CharSequence;

    invoke-interface {v3}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :cond_3
    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-boolean v0, v0, Lchat/ola/vn/entity/ag;->x:Z

    if-eqz v0, :cond_4

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->h:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    goto :goto_0

    :cond_4
    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->h:Landroid/view/View;

    const/16 v3, 0x8

    invoke-virtual {v0, v3}, Landroid/view/View;->setVisibility(I)V

    :goto_0
    invoke-direct {p0}, Lchat/ola/vn/me/OlaUserMePageActivity;->L()V

    invoke-direct {p0}, Lchat/ola/vn/me/OlaUserMePageActivity;->R()V

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->i:Landroid/widget/TextView;

    iget-object v3, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget v3, v3, Lchat/ola/vn/entity/ag;->r:I

    int-to-long v3, v3

    invoke-static {v3, v4}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget v0, v0, Lchat/ola/vn/entity/ag;->t:I

    if-nez v0, :cond_5

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->k:Landroid/widget/TextView;

    const v2, 0x7f0f057a

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setText(I)V

    goto :goto_2

    :cond_5
    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget v0, v0, Lchat/ola/vn/entity/ag;->t:I

    if-le v0, v2, :cond_6

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->k:Landroid/widget/TextView;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v3, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget v3, v3, Lchat/ola/vn/entity/ag;->t:I

    int-to-long v3, v3

    invoke-static {v3, v4}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v3, " "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v3, 0x7f0f0530

    invoke-virtual {p0, v3}, Lchat/ola/vn/me/OlaUserMePageActivity;->getString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :goto_1
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_2

    :cond_6
    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->k:Landroid/widget/TextView;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v3, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget v3, v3, Lchat/ola/vn/entity/ag;->t:I

    int-to-long v3, v3

    invoke-static {v3, v4}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v3, " "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v3, 0x7f0f052f

    invoke-virtual {p0, v3}, Lchat/ola/vn/me/OlaUserMePageActivity;->getString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_1

    :goto_2
    invoke-direct {p0}, Lchat/ola/vn/me/OlaUserMePageActivity;->U()V

    invoke-direct {p0}, Lchat/ola/vn/me/OlaUserMePageActivity;->Q()V

    invoke-direct {p0}, Lchat/ola/vn/me/OlaUserMePageActivity;->P()V

    invoke-direct {p0}, Lchat/ola/vn/me/OlaUserMePageActivity;->O()V

    invoke-direct {p0}, Lchat/ola/vn/me/OlaUserMePageActivity;->N()V

    invoke-direct {p0}, Lchat/ola/vn/me/OlaUserMePageActivity;->M()V

    invoke-direct {p0}, Lchat/ola/vn/me/OlaUserMePageActivity;->S()V

    invoke-direct {p0}, Lchat/ola/vn/me/OlaUserMePageActivity;->T()V

    :goto_3
    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->n:Lchat/ola/vn/r/a/e;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/e;->j()I

    move-result v0

    if-nez v0, :cond_7

    invoke-virtual {p0, v1}, Lchat/ola/vn/me/OlaUserMePageActivity;->a_(I)V

    :cond_7
    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->K:Lchat/ola/vn/b/q;

    invoke-virtual {v0}, Lchat/ola/vn/b/q;->notifyDataSetChanged()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private L()V
    .locals 6

    invoke-direct {p0}, Lchat/ola/vn/me/OlaUserMePageActivity;->V()Z

    move-result v0

    const/16 v1, 0x8

    const/4 v2, 0x0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->p:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->r:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->Y:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->p:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->r:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->Y:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    :goto_0
    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    iget-object v3, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-object v3, v3, Lchat/ola/vn/entity/ag;->c:Ljava/lang/String;

    iget-object v4, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->q:Lchat/ola/vn/view/OlaCachedImageView;

    iget-boolean v5, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->Z:Z

    invoke-virtual {v0, v3, v2, v4, v5}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;ZLchat/ola/vn/view/OlaCachedImageView;Z)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-object v0, v0, Lchat/ola/vn/entity/ag;->e:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->s:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, v2}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-object v1, v1, Lchat/ola/vn/entity/ag;->e:Ljava/lang/String;

    iget-object v3, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->s:Lchat/ola/vn/view/OlaCachedImageView;

    iget-boolean v4, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->Z:Z

    invoke-virtual {v0, v1, v2, v3, v4}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;ZLchat/ola/vn/view/OlaCachedImageView;Z)V

    goto :goto_1

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->s:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    :goto_1
    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-object v1, v1, Lchat/ola/vn/entity/ag;->c:Ljava/lang/String;

    iget-object v3, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->o:Lchat/ola/vn/view/OlaCachedImageView;

    iget-boolean v4, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->Z:Z

    invoke-virtual {v0, v1, v3, v4}, Lchat/ola/vn/c/t;->c(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Z)V

    iput-boolean v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->Z:Z

    return-void
.end method

.method private M()V
    .locals 5

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-wide v0, v0, Lchat/ola/vn/entity/ag;->l:J

    const-wide/16 v2, 0x0

    cmp-long v4, v0, v2

    if-nez v4, :cond_0

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->U:Landroid/widget/TextView;

    const v1, 0x7f0f0673

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    return-void

    :cond_0
    new-instance v0, Ljava/text/SimpleDateFormat;

    const-string v1, "dd/MM/yyyy"

    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v2

    invoke-direct {v0, v1, v2}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;Ljava/util/Locale;)V

    iget-object v1, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->U:Landroid/widget/TextView;

    new-instance v2, Ljava/util/Date;

    iget-object v3, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-wide v3, v3, Lchat/ola/vn/entity/ag;->l:J

    invoke-direct {v2, v3, v4}, Ljava/util/Date;-><init>(J)V

    invoke-virtual {v0, v2}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void
.end method

.method private N()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-object v0, v0, Lchat/ola/vn/entity/ag;->e:Ljava/lang/String;

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->T:Landroid/widget/TextView;

    const v1, 0x7f0f0554

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    return-void

    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const v1, 0x7f0f0555

    invoke-virtual {p0, v1}, Lchat/ola/vn/me/OlaUserMePageActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, " @"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-object v1, v1, Lchat/ola/vn/entity/ag;->e:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->T:Landroid/widget/TextView;

    invoke-static {v0}, Lchat/ola/vn/util/i;->c(Ljava/lang/String;)Ljava/lang/CharSequence;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void
.end method

.method private O()V
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-byte v0, v0, Lchat/ola/vn/entity/ag;->w:B

    const v1, 0x7f0806d4

    const/4 v2, 0x0

    packed-switch v0, :pswitch_data_0

    return-void

    :pswitch_0
    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->S:Landroid/widget/TextView;

    invoke-virtual {v0, v1, v2, v2, v2}, Landroid/widget/TextView;->setCompoundDrawablesWithIntrinsicBounds(IIII)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->S:Landroid/widget/TextView;

    const v1, 0x7f0f04f7

    goto :goto_0

    :pswitch_1
    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->S:Landroid/widget/TextView;

    const v1, 0x7f0806da

    invoke-virtual {v0, v1, v2, v2, v2}, Landroid/widget/TextView;->setCompoundDrawablesWithIntrinsicBounds(IIII)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->S:Landroid/widget/TextView;

    const v1, 0x7f0f0552

    goto :goto_0

    :pswitch_2
    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->S:Landroid/widget/TextView;

    const v1, 0x7f0806d6

    invoke-virtual {v0, v1, v2, v2, v2}, Landroid/widget/TextView;->setCompoundDrawablesWithIntrinsicBounds(IIII)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->S:Landroid/widget/TextView;

    const v1, 0x7f0f04ef

    goto :goto_0

    :pswitch_3
    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->S:Landroid/widget/TextView;

    invoke-virtual {v0, v1, v2, v2, v2}, Landroid/widget/TextView;->setCompoundDrawablesWithIntrinsicBounds(IIII)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->S:Landroid/widget/TextView;

    const v1, 0x7f0f0673

    :goto_0
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    return-void

    nop

    :pswitch_data_0
    .packed-switch -0x1
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private P()V
    .locals 10

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-wide v0, v0, Lchat/ola/vn/entity/ag;->m:J

    const-wide/16 v2, 0x0

    cmp-long v4, v0, v2

    if-eqz v4, :cond_0

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->R:Landroid/widget/TextView;

    const v1, 0x7f0f052e

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    iget-object v6, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-wide v6, v6, Lchat/ola/vn/entity/ag;->m:J

    sub-long v8, v4, v6

    invoke-static {}, Lchat/ola/vn/b;->d()Lchat/ola/vn/b;

    move-result-object v4

    invoke-virtual {v4}, Lchat/ola/vn/b;->a()[Ljava/lang/String;

    move-result-object v4

    invoke-static {}, Lchat/ola/vn/b;->d()Lchat/ola/vn/b;

    move-result-object v5

    invoke-virtual {v5}, Lchat/ola/vn/b;->b()[Ljava/lang/String;

    move-result-object v5

    invoke-static {v8, v9, v4, v5}, Lcom/mg/ola/common/d/i;->a(J[Ljava/lang/String;[Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    aput-object v4, v2, v3

    invoke-virtual {p0, v1, v2}, Lchat/ola/vn/me/OlaUserMePageActivity;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->R:Landroid/widget/TextView;

    const v1, 0x7f0f0673

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    return-void
.end method

.method private Q()V
    .locals 4

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-short v0, v0, Lchat/ola/vn/entity/ag;->u:S

    if-lez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->P:Landroid/view/View;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->Q:Lchat/ola/vn/view/OlaCachedImageView;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, ""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-short v2, v2, Lchat/ola/vn/entity/ag;->u:S

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->Q:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-static {}, Lchat/ola/vn/j;->a()Lchat/ola/vn/j;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-short v2, v2, Lchat/ola/vn/entity/ag;->u:S

    invoke-virtual {v1, v2}, Lchat/ola/vn/j;->a(I)Landroid/graphics/Bitmap;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, ""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v3, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-short v3, v3, Lchat/ola/vn/entity/ag;->u:S

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/view/OlaCachedImageView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->P:Landroid/view/View;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->Q:Lchat/ola/vn/view/OlaCachedImageView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1, v1}, Lchat/ola/vn/view/OlaCachedImageView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    :cond_1
    return-void
.end method

.method private R()V
    .locals 4

    invoke-direct {p0}, Lchat/ola/vn/me/OlaUserMePageActivity;->V()Z

    move-result v0

    const/4 v1, 0x0

    const/16 v2, 0x8

    if-eqz v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->aa:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->ab:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->ac:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    invoke-static {}, Lchat/ola/vn/c;->x()Z

    move-result v0

    if-eqz v0, :cond_0

    sget-object v0, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    iget-object v0, v0, Lchat/ola/vn/entity/ag;->f:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    sget-object v0, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    iget-boolean v0, v0, Lchat/ola/vn/entity/ag;->x:Z

    if-eqz v0, :cond_1

    :cond_0
    sget-object v0, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    iget-byte v0, v0, Lchat/ola/vn/entity/ag;->w:B

    const/4 v3, -0x1

    if-ne v0, v3, :cond_2

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->ad:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    return-void

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->ad:Landroid/view/View;

    goto :goto_0

    :cond_3
    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->ad:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->aa:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->ab:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->ac:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-boolean v0, v0, Lchat/ola/vn/entity/ag;->A:Z

    if-eqz v0, :cond_4

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->w:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->v:Landroid/view/View;

    :goto_0
    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    return-void

    :cond_4
    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->w:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->v:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-object v1, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-object v1, v1, Lchat/ola/vn/entity/ag;->c:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lchat/ola/vn/message/g;->d(Ljava/lang/String;)Lchat/ola/vn/message/f;

    move-result-object v0

    if-nez v0, :cond_5

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->G:Landroid/widget/ImageView;

    const v1, 0x7f080664

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->H:Landroid/widget/TextView;

    const v1, 0x7f0f0550

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->H:Landroid/widget/TextView;

    sget v1, Lchat/ola/vn/f;->A:I

    :goto_1
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    goto :goto_2

    :cond_5
    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->G:Landroid/widget/ImageView;

    const v1, 0x7f080788

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->H:Landroid/widget/TextView;

    const v1, 0x7f0f041e

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->H:Landroid/widget/TextView;

    sget v1, Lchat/ola/vn/f;->H:I

    goto :goto_1

    :goto_2
    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-boolean v0, v0, Lchat/ola/vn/entity/ag;->y:Z

    if-eqz v0, :cond_6

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->I:Landroid/widget/ImageView;

    const v1, 0x7f080787

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->J:Landroid/widget/TextView;

    const v1, 0x7f0f04f9

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->J:Landroid/widget/TextView;

    sget v1, Lchat/ola/vn/f;->H:I

    :goto_3
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    return-void

    :cond_6
    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->I:Landroid/widget/ImageView;

    const v1, 0x7f0806c7

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->J:Landroid/widget/TextView;

    const v1, 0x7f0f04f8

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->J:Landroid/widget/TextView;

    sget v1, Lchat/ola/vn/f;->A:I

    goto :goto_3

    return-void
.end method

.method private S()V
    .locals 8

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget v0, v0, Lchat/ola/vn/entity/ag;->o:I

    const/16 v1, 0x8

    if-lez v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->x:Landroid/view/View;

    const/4 v2, 0x0

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    const v0, 0x7f0f0563

    invoke-virtual {p0, v0}, Lchat/ola/vn/me/OlaUserMePageActivity;->getString(I)Ljava/lang/String;

    move-result-object v0

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v4, " \u00b7 "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v4, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget v4, v4, Lchat/ola/vn/entity/ag;->o:I

    int-to-long v4, v4

    invoke-static {v4, v5}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    new-instance v4, Landroid/text/SpannableStringBuilder;

    invoke-direct {v4, v3}, Landroid/text/SpannableStringBuilder;-><init>(Ljava/lang/CharSequence;)V

    new-instance v5, Landroid/text/style/ForegroundColorSpan;

    sget v6, Lchat/ola/vn/f;->y:I

    invoke-direct {v5, v6}, Landroid/text/style/ForegroundColorSpan;-><init>(I)V

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v6

    const/16 v7, 0x21

    invoke-virtual {v4, v5, v2, v6, v7}, Landroid/text/SpannableStringBuilder;->setSpan(Ljava/lang/Object;III)V

    new-instance v5, Landroid/text/style/ForegroundColorSpan;

    sget v6, Lchat/ola/vn/f;->z:I

    invoke-direct {v5, v6}, Landroid/text/style/ForegroundColorSpan;-><init>(I)V

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v3

    invoke-virtual {v4, v5, v0, v3, v7}, Landroid/text/SpannableStringBuilder;->setSpan(Ljava/lang/Object;III)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->y:Landroid/widget/TextView;

    invoke-virtual {v0, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    const/4 v0, 0x0

    :goto_0
    iget-object v3, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->t:[Lchat/ola/vn/view/OlaCachedImageView;

    array-length v3, v3

    if-ge v0, v3, :cond_0

    iget-object v3, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->t:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v3, v3, v0

    invoke-virtual {v3, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-object v0, v0, Lchat/ola/vn/entity/ag;->j:[Ljava/lang/String;

    if-eqz v0, :cond_4

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-object v0, v0, Lchat/ola/vn/entity/ag;->j:[Ljava/lang/String;

    array-length v0, v0

    const/4 v3, 0x3

    const/4 v4, 0x4

    if-le v0, v3, :cond_1

    const/4 v0, 0x0

    :goto_1
    iget-object v3, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->t:[Lchat/ola/vn/view/OlaCachedImageView;

    array-length v3, v3

    if-ge v0, v3, :cond_2

    iget-object v3, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->t:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v3, v3, v0

    invoke-virtual {v3, v4}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->t:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v0, v0, v2

    invoke-virtual {v0, v4}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->t:[Lchat/ola/vn/view/OlaCachedImageView;

    const/4 v3, 0x1

    aget-object v0, v0, v3

    invoke-virtual {v0, v4}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->t:[Lchat/ola/vn/view/OlaCachedImageView;

    const/4 v3, 0x2

    aget-object v0, v0, v3

    invoke-virtual {v0, v4}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    :cond_2
    const/4 v0, 0x0

    :goto_2
    iget-object v3, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->t:[Lchat/ola/vn/view/OlaCachedImageView;

    array-length v3, v3

    if-ge v0, v3, :cond_4

    iget-object v3, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-object v3, v3, Lchat/ola/vn/entity/ag;->j:[Ljava/lang/String;

    array-length v3, v3

    if-ge v0, v3, :cond_4

    iget-object v3, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->t:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v3, v3, v0

    invoke-virtual {v3, v2}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    iget-object v4, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-object v4, v4, Lchat/ola/vn/entity/ag;->j:[Ljava/lang/String;

    aget-object v4, v4, v0

    invoke-static {v4}, Lchat/ola/vn/entity/i;->i(Ljava/lang/String;)C

    move-result v4

    packed-switch v4, :pswitch_data_0

    invoke-virtual {v3, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    goto :goto_4

    :pswitch_0
    sget-object v4, Landroid/widget/ImageView$ScaleType;->CENTER_INSIDE:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {v3, v4}, Lchat/ola/vn/view/OlaCachedImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    const v4, 0x7f080717

    goto :goto_3

    :pswitch_1
    sget-object v4, Landroid/widget/ImageView$ScaleType;->CENTER_INSIDE:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {v3, v4}, Lchat/ola/vn/view/OlaCachedImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    const v4, 0x7f08071a

    :goto_3
    invoke-virtual {v3, v4}, Lchat/ola/vn/view/OlaCachedImageView;->setImageResource(I)V

    goto :goto_4

    :pswitch_2
    sget-object v4, Landroid/widget/ImageView$ScaleType;->CENTER_CROP:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {v3, v4}, Lchat/ola/vn/view/OlaCachedImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v4

    iget-object v5, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-object v5, v5, Lchat/ola/vn/entity/ag;->j:[Ljava/lang/String;

    aget-object v5, v5, v0

    invoke-virtual {v3}, Lchat/ola/vn/view/OlaCachedImageView;->getWidth()I

    move-result v6

    invoke-virtual {v4, v5, v3, v6}, Lchat/ola/vn/c/t;->b(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;I)V

    :goto_4
    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    :cond_3
    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->x:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    :cond_4
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private T()V
    .locals 7

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-object v0, v0, Lchat/ola/vn/entity/ag;->i:[Ljava/lang/String;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-object v0, v0, Lchat/ola/vn/entity/ag;->i:[Ljava/lang/String;

    array-length v0, v0

    if-lez v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->A:Landroid/view/View;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    const v0, 0x7f0f04f9

    invoke-virtual {p0, v0}, Lchat/ola/vn/me/OlaUserMePageActivity;->getString(I)Ljava/lang/String;

    move-result-object v0

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v3, " \u00b7 "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v3, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget v3, v3, Lchat/ola/vn/entity/ag;->p:I

    int-to-long v3, v3

    invoke-static {v3, v4}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    new-instance v3, Landroid/text/SpannableStringBuilder;

    invoke-direct {v3, v2}, Landroid/text/SpannableStringBuilder;-><init>(Ljava/lang/CharSequence;)V

    new-instance v4, Landroid/text/style/ForegroundColorSpan;

    sget v5, Lchat/ola/vn/f;->y:I

    invoke-direct {v4, v5}, Landroid/text/style/ForegroundColorSpan;-><init>(I)V

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v5

    const/16 v6, 0x21

    invoke-virtual {v3, v4, v1, v5, v6}, Landroid/text/SpannableStringBuilder;->setSpan(Ljava/lang/Object;III)V

    new-instance v4, Landroid/text/style/ForegroundColorSpan;

    sget v5, Lchat/ola/vn/f;->z:I

    invoke-direct {v4, v5}, Landroid/text/style/ForegroundColorSpan;-><init>(I)V

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v2

    invoke-virtual {v3, v4, v0, v2, v6}, Landroid/text/SpannableStringBuilder;->setSpan(Ljava/lang/Object;III)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->B:Landroid/widget/TextView;

    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    const/4 v0, 0x0

    :goto_0
    iget-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->z:[Landroid/view/View;

    array-length v2, v2

    if-ge v0, v2, :cond_0

    iget-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->z:[Landroid/view/View;

    aget-object v2, v2, v0

    const/4 v3, 0x4

    invoke-virtual {v2, v3}, Landroid/view/View;->setVisibility(I)V

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_1
    iget-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->z:[Landroid/view/View;

    array-length v2, v2

    if-ge v0, v2, :cond_2

    iget-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-object v2, v2, Lchat/ola/vn/entity/ag;->i:[Ljava/lang/String;

    array-length v2, v2

    if-ge v0, v2, :cond_2

    iget-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->z:[Landroid/view/View;

    aget-object v2, v2, v0

    invoke-virtual {v2, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->C:[Landroid/widget/TextView;

    aget-object v2, v2, v0

    iget-object v3, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-object v3, v3, Lchat/ola/vn/entity/ag;->i:[Ljava/lang/String;

    aget-object v3, v3, v0

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v2

    iget-object v3, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-object v3, v3, Lchat/ola/vn/entity/ag;->i:[Ljava/lang/String;

    aget-object v3, v3, v0

    iget-object v4, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->L:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v4, v4, v0

    invoke-virtual {v2, v3, v1, v4}, Lchat/ola/vn/c/t;->b(Ljava/lang/String;ZLchat/ola/vn/view/OlaCachedImageView;)V

    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->A:Landroid/view/View;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    :cond_2
    return-void
.end method

.method private U()V
    .locals 9

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-object v0, v0, Lchat/ola/vn/entity/ag;->d:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    const/16 v2, 0x8

    if-eqz v1, :cond_1

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->D:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    return-void

    :cond_1
    invoke-static {v0}, Lchat/ola/vn/util/i;->b(Ljava/lang/CharSequence;)Ljava/util/ArrayList;

    move-result-object v1

    const/4 v3, 0x0

    if-eqz v1, :cond_2

    invoke-virtual {v1}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v4

    if-nez v4, :cond_2

    const-string v4, ""

    invoke-static {v0, v4}, Lchat/ola/vn/util/i;->d(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    invoke-static {v1}, Lchat/ola/vn/util/o;->g(Ljava/lang/String;)S

    move-result v4

    packed-switch v4, :pswitch_data_0

    goto :goto_1

    :pswitch_0
    iget-object v4, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->F:Lchat/ola/vn/view/OlaCachedImageView;

    const v5, 0x7f080717

    goto :goto_0

    :pswitch_1
    iget-object v4, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->F:Lchat/ola/vn/view/OlaCachedImageView;

    const v5, 0x7f08071a

    :goto_0
    invoke-virtual {v4, v5}, Lchat/ola/vn/view/OlaCachedImageView;->setImageResource(I)V

    iget-object v4, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->F:Lchat/ola/vn/view/OlaCachedImageView;

    sget-object v5, Landroid/widget/ImageView$ScaleType;->CENTER_INSIDE:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {v4, v5}, Lchat/ola/vn/view/OlaCachedImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    goto :goto_1

    :pswitch_2
    iget-object v4, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->F:Lchat/ola/vn/view/OlaCachedImageView;

    sget-object v5, Landroid/widget/ImageView$ScaleType;->CENTER_CROP:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {v4, v5}, Lchat/ola/vn/view/OlaCachedImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v4

    iget-object v5, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->F:Lchat/ola/vn/view/OlaCachedImageView;

    const v6, 0x7f080714

    invoke-virtual {p0}, Lchat/ola/vn/me/OlaUserMePageActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v7

    const v8, 0x7f070114

    invoke-virtual {v7, v8}, Landroid/content/res/Resources;->getDimensionPixelOffset(I)I

    move-result v7

    div-int/lit8 v7, v7, 0x2

    invoke-virtual {v4, v1, v5, v6, v7}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;II)V

    :goto_1
    iget-object v4, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->F:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v4, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setTag(Ljava/lang/Object;)V

    iget-object v1, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->F:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v1, p0}, Lchat/ola/vn/view/OlaCachedImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v1, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->F:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v1, v3}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    goto :goto_2

    :cond_2
    iget-object v1, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->F:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v1, v2}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    :goto_2
    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->E:Landroid/widget/TextView;

    invoke-virtual {p0, v1, v0}, Lchat/ola/vn/me/OlaUserMePageActivity;->a(Landroid/view/View;Ljava/lang/CharSequence;)Ljava/lang/CharSequence;

    move-result-object v0

    invoke-static {}, Landroid/text/Spannable$Factory;->getInstance()Landroid/text/Spannable$Factory;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/text/Spannable$Factory;->newSpannable(Ljava/lang/CharSequence;)Landroid/text/Spannable;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->E:Landroid/widget/TextView;

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->D:Landroid/view/View;

    invoke-virtual {v0, v3}, Landroid/view/View;->setVisibility(I)V

    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private V()Z
    .locals 2

    :try_start_0
    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-object v1, v1, Lchat/ola/vn/entity/ag;->c:Ljava/lang/String;

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    :catch_0
    const/4 v0, 0x0

    return v0
.end method

.method private W()V
    .locals 3

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    const v1, 0x7f0f0461

    invoke-virtual {p0, v1}, Lchat/ola/vn/me/OlaUserMePageActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v1, 0x7f0f0459

    invoke-virtual {p0, v1}, Lchat/ola/vn/me/OlaUserMePageActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v1, 0x7f0f045c

    invoke-virtual {p0, v1}, Lchat/ola/vn/me/OlaUserMePageActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v1, Lchat/ola/vn/i/m;

    invoke-direct {v1, p0}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    invoke-virtual {v1, v0}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance v2, Lchat/ola/vn/me/OlaUserMePageActivity$14;

    invoke-direct {v2, p0, v0}, Lchat/ola/vn/me/OlaUserMePageActivity$14;-><init>(Lchat/ola/vn/me/OlaUserMePageActivity;Ljava/util/List;)V

    invoke-virtual {v1, v2}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {v1}, Lchat/ola/vn/i/m;->show()V

    return-void
.end method

.method private X()V
    .locals 3

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    const v1, 0x7f0f0439

    invoke-virtual {p0, v1}, Lchat/ola/vn/me/OlaUserMePageActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v1, 0x7f0f0492

    invoke-virtual {p0, v1}, Lchat/ola/vn/me/OlaUserMePageActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v1, 0x7f0f042f

    invoke-virtual {p0, v1}, Lchat/ola/vn/me/OlaUserMePageActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v1, Lchat/ola/vn/i/m;

    invoke-direct {v1, p0}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    invoke-virtual {v1, v0}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance v2, Lchat/ola/vn/me/OlaUserMePageActivity$2;

    invoke-direct {v2, p0, v0}, Lchat/ola/vn/me/OlaUserMePageActivity$2;-><init>(Lchat/ola/vn/me/OlaUserMePageActivity;Ljava/util/List;)V

    invoke-virtual {v1, v2}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {v1}, Lchat/ola/vn/i/m;->show()V

    return-void
.end method

.method private Y()V
    .locals 3

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    const v1, 0x7f0f055c

    invoke-virtual {p0, v1}, Lchat/ola/vn/me/OlaUserMePageActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v1, 0x7f0f0559

    invoke-virtual {p0, v1}, Lchat/ola/vn/me/OlaUserMePageActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v1, 0x7f0f055b

    invoke-virtual {p0, v1}, Lchat/ola/vn/me/OlaUserMePageActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v1, 0x7f0f055a

    invoke-virtual {p0, v1}, Lchat/ola/vn/me/OlaUserMePageActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v1, Lchat/ola/vn/i/m;

    invoke-direct {v1, p0}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    invoke-virtual {v1, v0}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance v2, Lchat/ola/vn/me/OlaUserMePageActivity$3;

    invoke-direct {v2, p0, v0}, Lchat/ola/vn/me/OlaUserMePageActivity$3;-><init>(Lchat/ola/vn/me/OlaUserMePageActivity;Ljava/util/List;)V

    invoke-virtual {v1, v2}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {v1}, Lchat/ola/vn/i/m;->show()V

    return-void
.end method

.method private Z()V
    .locals 9

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    if-nez v0, :cond_0

    return-void

    :cond_0
    new-instance v0, Lchat/ola/vn/me/OlaUserMePageActivity$4;

    invoke-direct {v0, p0}, Lchat/ola/vn/me/OlaUserMePageActivity$4;-><init>(Lchat/ola/vn/me/OlaUserMePageActivity;)V

    iget-object v1, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-boolean v1, v1, Lchat/ola/vn/entity/ag;->y:Z

    const/4 v2, 0x1

    if-eqz v1, :cond_1

    const v1, 0x7f0f009b

    invoke-virtual {p0, v1}, Lchat/ola/vn/me/OlaUserMePageActivity;->getString(I)Ljava/lang/String;

    move-result-object v4

    const v1, 0x7f0f0165

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "@"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v6, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-object v6, v6, Lchat/ola/vn/entity/ag;->c:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    aput-object v5, v2, v3

    invoke-virtual {p0, v1, v2}, Lchat/ola/vn/me/OlaUserMePageActivity;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    const v1, 0x7f0f057e

    invoke-virtual {p0, v1}, Lchat/ola/vn/me/OlaUserMePageActivity;->getString(I)Ljava/lang/String;

    move-result-object v6

    const v1, 0x7f0f0480

    invoke-virtual {p0, v1}, Lchat/ola/vn/me/OlaUserMePageActivity;->getString(I)Ljava/lang/String;

    move-result-object v7

    new-instance v8, Lchat/ola/vn/me/OlaUserMePageActivity$5;

    invoke-direct {v8, p0, v0}, Lchat/ola/vn/me/OlaUserMePageActivity$5;-><init>(Lchat/ola/vn/me/OlaUserMePageActivity;Lchat/ola/vn/entry/c/e;)V

    move-object v3, p0

    invoke-static/range {v3 .. v8}, Lchat/ola/vn/i/i;->d(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/content/DialogInterface$OnClickListener;)Lchat/ola/vn/i/f;

    return-void

    :cond_1
    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v3, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-object v3, v3, Lchat/ola/vn/entity/ag;->c:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/entry/c/f;->a(Lchat/ola/vn/entry/c/e;)S

    move-result v0

    invoke-virtual {v1, v3, v2, v0}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;ZS)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iput-boolean v2, v0, Lchat/ola/vn/entity/ag;->y:Z

    invoke-direct {p0}, Lchat/ola/vn/me/OlaUserMePageActivity;->K()V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/me/OlaUserMePageActivity;)Ljava/lang/Runnable;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->O:Ljava/lang/Runnable;

    return-object p0
.end method

.method static synthetic a(Lchat/ola/vn/me/OlaUserMePageActivity;Ljava/lang/Runnable;)Ljava/lang/Runnable;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->O:Ljava/lang/Runnable;

    return-object p1
.end method

.method public static a(Landroid/content/Context;Ljava/lang/String;)V
    .locals 1

    :try_start_0
    const-string v0, "#"

    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-static {p0, p1}, Lchat/ola/vn/me/OlaClanMePageActivity;->a(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :cond_0
    invoke-static {p0, p1}, Lchat/ola/vn/me/OlaUserMePageActivity;->b(Landroid/content/Context;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic a(Lchat/ola/vn/me/OlaUserMePageActivity;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/me/OlaUserMePageActivity;->g(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/me/OlaUserMePageActivity;Z)Z
    .locals 0

    iput-boolean p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->N:Z

    return p1
.end method

.method private aa()V
    .locals 3

    new-instance v0, Lchat/ola/vn/i/m;

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v1

    invoke-direct {v0, v1}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    new-instance v1, Ljava/util/ArrayList;

    const/4 v2, 0x0

    invoke-direct {v1, v2}, Ljava/util/ArrayList;-><init>(I)V

    iget-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-object v2, v2, Lchat/ola/vn/entity/ag;->a:Ljava/lang/CharSequence;

    if-eqz v2, :cond_0

    iget-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-object v2, v2, Lchat/ola/vn/entity/ag;->a:Ljava/lang/CharSequence;

    invoke-interface {v2}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v2

    :goto_0
    invoke-virtual {v0, v2}, Lchat/ola/vn/i/m;->a(Ljava/lang/String;)V

    goto :goto_1

    :cond_0
    iget-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-object v2, v2, Lchat/ola/vn/entity/ag;->c:Ljava/lang/String;

    goto :goto_0

    :goto_1
    iget-object v2, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-boolean v2, v2, Lchat/ola/vn/entity/ag;->y:Z

    if-eqz v2, :cond_1

    const v2, 0x7f0f057e

    :goto_2
    invoke-static {v2}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v2

    invoke-interface {v1, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_3

    :cond_1
    const v2, 0x7f0f04f8

    goto :goto_2

    :goto_3
    const v2, 0x7f0f066c

    invoke-static {v2}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v2

    invoke-interface {v1, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-virtual {v0, v1}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance v2, Lchat/ola/vn/me/OlaUserMePageActivity$6;

    invoke-direct {v2, p0, v1}, Lchat/ola/vn/me/OlaUserMePageActivity$6;-><init>(Lchat/ola/vn/me/OlaUserMePageActivity;Ljava/util/List;)V

    invoke-virtual {v0, v2}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {v0}, Lchat/ola/vn/i/m;->show()V

    return-void
.end method

.method private ab()V
    .locals 2

    :try_start_0
    iget-boolean v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->N:Z

    if-nez v0, :cond_1

    invoke-static {}, Lchat/ola/vn/c/x;->e()Z

    move-result v0

    if-eqz v0, :cond_0

    sget-object v0, Lchat/ola/vn/util/c/a;->s:Landroid/net/Uri;

    invoke-static {p0, v0}, Lchat/ola/vn/util/n;->a(Landroid/content/Context;Landroid/net/Uri;)Z

    :cond_0
    iget-boolean v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->N:Z

    const/4 v1, 0x1

    xor-int/2addr v0, v1

    iput-boolean v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->N:Z

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->M:Landroid/support/v4/widget/SwipeRefreshLayout;

    invoke-virtual {v0, v1}, Landroid/support/v4/widget/SwipeRefreshLayout;->setRefreshing(Z)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method

.method private ac()V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->O:Ljava/lang/Runnable;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->O:Ljava/lang/Runnable;

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->c(Ljava/lang/Runnable;)V

    :cond_0
    iget-boolean v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->N:Z

    if-eqz v0, :cond_2

    invoke-static {}, Lchat/ola/vn/c/x;->e()Z

    move-result v0

    if-eqz v0, :cond_1

    sget-object v0, Lchat/ola/vn/util/c/a;->t:Landroid/net/Uri;

    invoke-static {p0, v0}, Lchat/ola/vn/util/n;->a(Landroid/content/Context;Landroid/net/Uri;)Z

    :cond_1
    iget-boolean v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->N:Z

    xor-int/lit8 v0, v0, 0x1

    iput-boolean v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->N:Z

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->M:Landroid/support/v4/widget/SwipeRefreshLayout;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/support/v4/widget/SwipeRefreshLayout;->setRefreshing(Z)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_2
    return-void
.end method

.method private static b(Landroid/content/Context;Ljava/lang/String;)V
    .locals 2

    :try_start_0
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lchat/ola/vn/me/OlaUserMePageActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v1, "contactId"

    invoke-virtual {v0, v1, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    invoke-virtual {p0, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    check-cast p0, Landroid/app/Activity;

    const v0, 0x7f010038

    const v1, 0x7f010039

    invoke-virtual {p0, v0, v1}, Landroid/app/Activity;->overridePendingTransition(II)V

    invoke-static {p1}, Lchat/ola/vn/me/OlaUserMePageActivity;->h(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic b(Lchat/ola/vn/me/OlaUserMePageActivity;Z)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/me/OlaUserMePageActivity;->c(Z)V

    return-void
.end method

.method static synthetic b(Lchat/ola/vn/me/OlaUserMePageActivity;)Z
    .locals 0

    iget-boolean p0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->N:Z

    return p0
.end method

.method static synthetic c(Lchat/ola/vn/me/OlaUserMePageActivity;)Landroid/support/v4/widget/SwipeRefreshLayout;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->M:Landroid/support/v4/widget/SwipeRefreshLayout;

    return-object p0
.end method

.method private c(Z)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->u:Landroid/view/View;

    if-eqz p1, :cond_0

    const/4 p1, 0x0

    goto :goto_0

    :cond_0
    const/16 p1, 0x8

    :goto_0
    invoke-virtual {v0, p1}, Landroid/view/View;->setVisibility(I)V

    return-void
.end method

.method static synthetic c(Lchat/ola/vn/me/OlaUserMePageActivity;Z)Z
    .locals 0

    iput-boolean p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->af:Z

    return p1
.end method

.method static synthetic d(Lchat/ola/vn/me/OlaUserMePageActivity;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/me/OlaUserMePageActivity;->ab()V

    return-void
.end method

.method static synthetic e(Lchat/ola/vn/me/OlaUserMePageActivity;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/me/OlaUserMePageActivity;->I()V

    return-void
.end method

.method static synthetic f(Lchat/ola/vn/me/OlaUserMePageActivity;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/me/OlaUserMePageActivity;->K()V

    return-void
.end method

.method static synthetic g(Lchat/ola/vn/me/OlaUserMePageActivity;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/me/OlaUserMePageActivity;->Y()V

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
    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->u:Landroid/view/View;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->u:Landroid/view/View;

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

    invoke-direct {p0, v2}, Lchat/ola/vn/me/OlaUserMePageActivity;->c(Z)V

    if-eqz v1, :cond_1

    invoke-static {v0}, Lchat/ola/vn/util/m;->t(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    new-array v2, v2, [Ljava/lang/String;

    const-string v3, "name"

    aput-object v3, v2, p1

    new-instance p1, Lchat/ola/vn/me/OlaUserMePageActivity$11;

    invoke-direct {p1, p0}, Lchat/ola/vn/me/OlaUserMePageActivity$11;-><init>(Lchat/ola/vn/me/OlaUserMePageActivity;)V

    invoke-virtual {v1, v0, v2, p1}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;[Ljava/lang/String;Lchat/ola/vn/p/d;)V

    return-void

    :cond_1
    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    new-instance v1, Lchat/ola/vn/me/OlaUserMePageActivity$12;

    invoke-direct {v1, p0}, Lchat/ola/vn/me/OlaUserMePageActivity$12;-><init>(Lchat/ola/vn/me/OlaUserMePageActivity;)V

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

    invoke-static {}, Lchat/ola/vn/me/OlaUserMePageActivity;->J()V

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

    iget-boolean v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->V:Z

    return v0
.end method

.method public D()V
    .locals 1

    const/4 v0, 0x1

    iput-boolean v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->Z:Z

    invoke-direct {p0}, Lchat/ola/vn/me/OlaUserMePageActivity;->K()V

    return-void
.end method

.method public E()V
    .locals 1

    const/4 v0, 0x1

    iput-boolean v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->Z:Z

    invoke-direct {p0}, Lchat/ola/vn/me/OlaUserMePageActivity;->K()V

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

.method public a(Landroid/view/View;Ljava/lang/CharSequence;)Ljava/lang/CharSequence;
    .locals 3

    invoke-static {}, Lchat/ola/vn/util/h;->a()Lchat/ola/vn/util/h;

    move-result-object v0

    invoke-virtual {v0, p2}, Lchat/ola/vn/util/h;->a(Ljava/lang/CharSequence;)Ljava/lang/CharSequence;

    move-result-object p2

    invoke-static {}, Lchat/ola/vn/util/g;->a()Lchat/ola/vn/util/g;

    move-result-object v0

    invoke-virtual {v0, p2}, Lchat/ola/vn/util/g;->a(Ljava/lang/CharSequence;)Ljava/lang/CharSequence;

    move-result-object p2

    sget v0, Lchat/ola/vn/f;->a:I

    const/4 v1, 0x0

    const/4 v2, 0x0

    invoke-static {p1, p2, v2, v0, v1}, Lchat/ola/vn/util/i;->a(Landroid/view/View;Ljava/lang/CharSequence;Lcom/mg/ola/common/widget/OlaTextView$b;IZ)Ljava/lang/CharSequence;

    move-result-object p2

    sget v0, Lchat/ola/vn/f;->a:I

    invoke-static {p1, p2, v2, v0, v1}, Lchat/ola/vn/util/i;->b(Landroid/view/View;Ljava/lang/CharSequence;Lcom/mg/ola/common/widget/OlaTextView$b;IZ)Ljava/lang/CharSequence;

    move-result-object p2

    sget v0, Lchat/ola/vn/f;->a:I

    invoke-static {p1, p2, v2, v0, v1}, Lchat/ola/vn/util/i;->d(Landroid/view/View;Ljava/lang/CharSequence;Lcom/mg/ola/common/widget/OlaTextView$b;IZ)Ljava/lang/CharSequence;

    move-result-object p2

    sget v0, Lchat/ola/vn/f;->a:I

    invoke-static {p1, p2, v2, v0, v1}, Lchat/ola/vn/util/i;->c(Landroid/view/View;Ljava/lang/CharSequence;Lcom/mg/ola/common/widget/OlaTextView$b;IZ)Ljava/lang/CharSequence;

    move-result-object p1

    return-object p1
.end method

.method protected a()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/me/OlaUserMePageActivity;->K()V

    return-void
.end method

.method public a(ILjava/lang/String;[B[Lchat/ola/vn/entity/d;S)V
    .locals 0

    invoke-super/range {p0 .. p5}, Lchat/ola/vn/c;->a(ILjava/lang/String;[B[Lchat/ola/vn/entity/d;S)V

    const/16 p1, 0x4f

    if-ne p5, p1, :cond_0

    :try_start_0
    invoke-direct {p0}, Lchat/ola/vn/me/OlaUserMePageActivity;->ac()V

    const/4 p1, 0x0

    invoke-direct {p0, p1}, Lchat/ola/vn/me/OlaUserMePageActivity;->c(Z)V

    iput-boolean p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->W:Z

    iput-boolean p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->V:Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
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

    const/16 v0, 0x4f

    if-ne p4, v0, :cond_1

    :try_start_0
    invoke-direct {p0}, Lchat/ola/vn/me/OlaUserMePageActivity;->ac()V

    const/4 p4, 0x0

    invoke-direct {p0, p4}, Lchat/ola/vn/me/OlaUserMePageActivity;->c(Z)V

    iput-boolean p4, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->W:Z

    iget-object p4, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->n:Lchat/ola/vn/r/a/e;

    invoke-virtual {p4}, Lchat/ola/vn/r/a/e;->k()J

    move-result-wide v0

    const-wide/16 v2, 0x0

    cmp-long p4, v0, v2

    if-nez p4, :cond_0

    iget-object p4, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->n:Lchat/ola/vn/r/a/e;

    invoke-virtual {p4, p1, p2, p3}, Lchat/ola/vn/r/a/e;->b(Ljava/lang/String;SLjava/util/List;)V

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->n:Lchat/ola/vn/r/a/e;

    invoke-virtual {p1, p3}, Lchat/ola/vn/r/a/e;->c(Ljava/util/List;)V

    :goto_0
    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->m:Lchat/ola/vn/b/u;

    invoke-virtual {p1}, Lchat/ola/vn/b/u;->notifyDataSetChanged()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method

.method public a_(I)V
    .locals 4

    iget-boolean p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->W:Z

    if-nez p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    if-nez p1, :cond_0

    return-void

    :cond_0
    const/4 p1, 0x1

    iput-boolean p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->W:Z

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-object v0, v0, Lchat/ola/vn/entity/ag;->c:Ljava/lang/String;

    iget-object v1, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->n:Lchat/ola/vn/r/a/e;

    invoke-virtual {v1}, Lchat/ola/vn/r/a/e;->k()J

    move-result-wide v1

    const/16 v3, 0x4f

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
    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/me/OlaUserMePageActivity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public j()V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->m:Lchat/ola/vn/b/u;

    invoke-virtual {v0}, Lchat/ola/vn/b/u;->notifyDataSetChanged()V

    invoke-direct {p0}, Lchat/ola/vn/me/OlaUserMePageActivity;->K()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 7

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v0

    const/4 v1, 0x3

    const/4 v2, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x1

    sparse-switch v0, :sswitch_data_0

    return-void

    :sswitch_0
    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-object p1, p1, Lchat/ola/vn/entity/ag;->c:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_a

    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-object p1, p1, Lchat/ola/vn/entity/ag;->c:Ljava/lang/String;

    invoke-static {p0, p1}, Lchat/ola/vn/activity/OlaVipStoreActivity;->a(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :sswitch_1
    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-object p1, p1, Lchat/ola/vn/entity/ag;->c:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_a

    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget p1, p1, Lchat/ola/vn/entity/ag;->r:I

    if-lez p1, :cond_a

    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-object p1, p1, Lchat/ola/vn/entity/ag;->c:Ljava/lang/String;

    invoke-static {p0, p1}, Lchat/ola/vn/me/OlaPeopleListActivity;->a(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :sswitch_2
    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-object p1, p1, Lchat/ola/vn/entity/ag;->c:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_a

    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "rss://note/"

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-object v0, v0, Lchat/ola/vn/entity/ag;->c:Ljava/lang/String;

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p0, p1}, Lchat/ola/vn/m/j;->a(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :sswitch_3
    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-object p1, p1, Lchat/ola/vn/entity/ag;->c:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_a

    new-array p1, v4, [Lchat/ola/vn/mediastore/OlaMediaEntity;

    const/4 v0, 0x0

    :goto_0
    array-length v5, p1

    if-ge v0, v5, :cond_0

    new-instance v5, Lchat/ola/vn/mediastore/OlaMediaEntity;

    iget-object v6, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-object v6, v6, Lchat/ola/vn/entity/ag;->c:Ljava/lang/String;

    invoke-static {v6}, Lchat/ola/vn/c/f;->c(Ljava/lang/String;)Lchat/ola/vn/c/f;

    move-result-object v6

    invoke-virtual {v6}, Lchat/ola/vn/c/f;->b()Ljava/lang/String;

    move-result-object v6

    invoke-direct {v5, v6, v1, v4}, Lchat/ola/vn/mediastore/OlaMediaEntity;-><init>(Ljava/lang/String;IS)V

    aput-object v5, p1, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->q:Lchat/ola/vn/view/OlaCachedImageView;

    :goto_1
    invoke-static {p0, v0, v2, v3, p1}, Lchat/ola/vn/activity/OlaImageViewerActivity;->a(Landroid/content/Context;Landroid/view/View;Landroid/graphics/Bitmap;I[Lchat/ola/vn/mediastore/OlaMediaEntity;)V

    return-void

    :sswitch_4
    invoke-direct {p0}, Lchat/ola/vn/me/OlaUserMePageActivity;->V()Z

    move-result p1

    if-eqz p1, :cond_1

    invoke-static {p0}, Lchat/ola/vn/me/OlaMeComposerActivity;->a(Landroid/content/Context;)V

    return-void

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-object p1, p1, Lchat/ola/vn/entity/ag;->c:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->j(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_a

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "@"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p0, p1, v2}, Lchat/ola/vn/me/OlaMeComposerActivity;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V

    return-void

    :sswitch_5
    invoke-virtual {p0}, Lchat/ola/vn/me/OlaUserMePageActivity;->finish()V

    return-void

    :sswitch_6
    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-object p1, p1, Lchat/ola/vn/entity/ag;->c:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_a

    invoke-direct {p0}, Lchat/ola/vn/me/OlaUserMePageActivity;->V()Z

    move-result p1

    if-eqz p1, :cond_2

    invoke-direct {p0}, Lchat/ola/vn/me/OlaUserMePageActivity;->W()V

    return-void

    :cond_2
    invoke-direct {p0}, Lchat/ola/vn/me/OlaUserMePageActivity;->X()V

    return-void

    :sswitch_7
    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-object p1, p1, Lchat/ola/vn/entity/ag;->c:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_3

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-object v0, v0, Lchat/ola/vn/entity/ag;->c:Ljava/lang/String;

    invoke-static {p1, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_4

    :cond_3
    invoke-static {p0}, Lchat/ola/vn/cloud/OlaCloudAlbumListActivity;->a(Landroid/content/Context;)V

    return-void

    :cond_4
    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-object p1, p1, Lchat/ola/vn/entity/ag;->c:Ljava/lang/String;

    invoke-static {p0, p1}, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->a(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :sswitch_8
    invoke-direct {p0}, Lchat/ola/vn/me/OlaUserMePageActivity;->V()Z

    move-result v0

    if-nez v0, :cond_a

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-object v0, v0, Lchat/ola/vn/entity/ag;->c:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_a

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget v1, v0, Lchat/ola/vn/entity/ag;->t:I

    add-int/2addr v1, v4

    iput v1, v0, Lchat/ola/vn/entity/ag;->t:I

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v1, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-object v1, v1, Lchat/ola/vn/entity/ag;->c:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lchat/ola/vn/network/OlaNetworkService;->i(Ljava/lang/String;)V

    invoke-direct {p0}, Lchat/ola/vn/me/OlaUserMePageActivity;->K()V

    const v0, 0x7f010057

    invoke-static {p0, v0}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object v0

    const-wide/16 v1, 0x96

    invoke-virtual {v0, v1, v2}, Landroid/view/animation/Animation;->setDuration(J)V

    iget-object v1, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->j:Landroid/view/View;

    invoke-virtual {v1, v0}, Landroid/view/View;->startAnimation(Landroid/view/animation/Animation;)V

    invoke-virtual {p0}, Lchat/ola/vn/me/OlaUserMePageActivity;->z()Landroid/widget/FrameLayout;

    move-result-object v0

    invoke-virtual {p0, p1, v0}, Lchat/ola/vn/me/OlaUserMePageActivity;->a(Landroid/view/View;Landroid/widget/FrameLayout;)V

    return-void

    :sswitch_9
    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-object p1, p1, Lchat/ola/vn/entity/ag;->d:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/i;->b(Ljava/lang/CharSequence;)Ljava/util/ArrayList;

    move-result-object p1

    if-eqz p1, :cond_a

    invoke-virtual {p1}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_a

    invoke-virtual {p1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_5
    :goto_2
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_6

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    invoke-static {v1}, Lchat/ola/vn/entity/i;->i(Ljava/lang/String;)C

    move-result v1

    if-eq v1, v4, :cond_5

    invoke-interface {v0}, Ljava/util/Iterator;->remove()V

    goto :goto_2

    :cond_6
    if-eqz p1, :cond_a

    invoke-virtual {p1}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_a

    invoke-virtual {p1}, Ljava/util/ArrayList;->size()I

    move-result v0

    new-array v0, v0, [Lchat/ola/vn/mediastore/OlaMediaEntity;

    const/4 v1, 0x0

    :goto_3
    array-length v5, v0

    if-ge v1, v5, :cond_7

    invoke-virtual {p1, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    new-instance v6, Lchat/ola/vn/mediastore/OlaMediaEntity;

    invoke-direct {v6, v5, v4, v4}, Lchat/ola/vn/mediastore/OlaMediaEntity;-><init>(Ljava/lang/String;IS)V

    aput-object v6, v0, v1

    add-int/lit8 v1, v1, 0x1

    goto :goto_3

    :cond_7
    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->F:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-static {p0, p1, v2, v3, v0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->a(Landroid/content/Context;Landroid/view/View;Landroid/graphics/Bitmap;I[Lchat/ola/vn/mediastore/OlaMediaEntity;)V

    return-void

    :sswitch_a
    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-object p1, p1, Lchat/ola/vn/entity/ag;->e:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_a

    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-object p1, p1, Lchat/ola/vn/entity/ag;->e:Ljava/lang/String;

    invoke-static {p0, p1}, Lchat/ola/vn/me/OlaUserMePageActivity;->a(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :sswitch_b
    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-object p1, p1, Lchat/ola/vn/entity/ag;->c:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_a

    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget p1, p1, Lchat/ola/vn/entity/ag;->p:I

    if-lez p1, :cond_a

    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-object p1, p1, Lchat/ola/vn/entity/ag;->c:Ljava/lang/String;

    invoke-static {p0, p1}, Lchat/ola/vn/me/OlaPeopleListActivity;->b(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :sswitch_c
    invoke-direct {p0}, Lchat/ola/vn/me/OlaUserMePageActivity;->Z()V

    return-void

    :sswitch_d
    invoke-static {p0}, Lchat/ola/vn/activity/OlaUserProfileActivity;->a(Landroid/content/Context;)V

    return-void

    :sswitch_e
    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-object p1, p1, Lchat/ola/vn/entity/ag;->c:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_a

    invoke-static {p0, p0}, Lchat/ola/vn/activity/OlaCropImageActivity;->c(Landroid/content/Context;Lchat/ola/vn/activity/OlaCropImageActivity$a;)V

    return-void

    :sswitch_f
    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-object p1, p1, Lchat/ola/vn/entity/ag;->c:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_a

    invoke-static {p0, p0}, Lchat/ola/vn/activity/OlaCropImageActivity;->b(Landroid/content/Context;Lchat/ola/vn/activity/OlaCropImageActivity$a;)V

    return-void

    :sswitch_10
    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-object p1, p1, Lchat/ola/vn/entity/ag;->c:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_a

    new-array p1, v4, [Lchat/ola/vn/mediastore/OlaMediaEntity;

    const/4 v0, 0x0

    :goto_4
    array-length v5, p1

    if-ge v0, v5, :cond_8

    new-instance v5, Lchat/ola/vn/mediastore/OlaMediaEntity;

    iget-object v6, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-object v6, v6, Lchat/ola/vn/entity/ag;->c:Ljava/lang/String;

    invoke-static {v6}, Lchat/ola/vn/c/f;->d(Ljava/lang/String;)Lchat/ola/vn/c/f;

    move-result-object v6

    invoke-virtual {v6}, Lchat/ola/vn/c/f;->b()Ljava/lang/String;

    move-result-object v6

    invoke-direct {v5, v6, v1, v4}, Lchat/ola/vn/mediastore/OlaMediaEntity;-><init>(Ljava/lang/String;IS)V

    aput-object v5, p1, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_4

    :cond_8
    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->o:Lchat/ola/vn/view/OlaCachedImageView;

    goto/16 :goto_1

    :sswitch_11
    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-object p1, p1, Lchat/ola/vn/entity/ag;->c:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->j(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_a

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0, p1}, Lchat/ola/vn/network/OlaNetworkService;->o(Ljava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iput-boolean v3, p1, Lchat/ola/vn/entity/ag;->A:Z

    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iput-boolean v3, p1, Lchat/ola/vn/entity/ag;->y:Z

    :goto_5
    invoke-direct {p0}, Lchat/ola/vn/me/OlaUserMePageActivity;->K()V

    return-void

    :sswitch_12
    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-object p1, p1, Lchat/ola/vn/entity/ag;->c:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_a

    sget-object p1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-object v0, v0, Lchat/ola/vn/entity/ag;->c:Ljava/lang/String;

    invoke-virtual {p1, v0}, Lchat/ola/vn/message/g;->d(Ljava/lang/String;)Lchat/ola/vn/message/f;

    move-result-object p1

    if-nez p1, :cond_9

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-object v0, v0, Lchat/ola/vn/entity/ag;->c:Ljava/lang/String;

    invoke-virtual {p1, v0}, Lchat/ola/vn/network/OlaNetworkService;->d(Ljava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iput-boolean v4, p1, Lchat/ola/vn/entity/ag;->y:Z

    goto :goto_5

    :cond_9
    invoke-direct {p0}, Lchat/ola/vn/me/OlaUserMePageActivity;->aa()V

    return-void

    :sswitch_13
    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-object p1, p1, Lchat/ola/vn/entity/ag;->c:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->j(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_a

    invoke-static {p0, p1}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Landroid/content/Context;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_a
    return-void

    nop

    :sswitch_data_0
    .sparse-switch
        0x7f090030 -> :sswitch_13
        0x7f090035 -> :sswitch_12
        0x7f09012e -> :sswitch_11
        0x7f0901d5 -> :sswitch_10
        0x7f0901ef -> :sswitch_f
        0x7f0901f3 -> :sswitch_e
        0x7f0901f4 -> :sswitch_d
        0x7f090223 -> :sswitch_c
        0x7f090236 -> :sswitch_b
        0x7f09024b -> :sswitch_a
        0x7f0902a7 -> :sswitch_9
        0x7f0902c7 -> :sswitch_8
        0x7f090351 -> :sswitch_7
        0x7f090363 -> :sswitch_6
        0x7f09039a -> :sswitch_5
        0x7f0903de -> :sswitch_4
        0x7f0903e7 -> :sswitch_3
        0x7f090558 -> :sswitch_a
        0x7f090559 -> :sswitch_2
        0x7f0905d5 -> :sswitch_1
        0x7f0905ec -> :sswitch_0
    .end sparse-switch
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 0

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    const/4 p1, 0x0

    iput-boolean p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->af:Z

    const p1, 0x7f0b017d

    invoke-virtual {p0, p1}, Lchat/ola/vn/me/OlaUserMePageActivity;->setContentView(I)V

    invoke-direct {p0}, Lchat/ola/vn/me/OlaUserMePageActivity;->C()V

    return-void
.end method

.method protected onDestroy()V
    .locals 1

    invoke-super {p0}, Lchat/ola/vn/c;->onDestroy()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    return-void
.end method

.method protected onPause()V
    .locals 0

    invoke-super {p0}, Lchat/ola/vn/c;->onPause()V

    return-void
.end method

.method public z()Landroid/widget/FrameLayout;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;->ae:Landroid/widget/FrameLayout;

    return-object v0
.end method
