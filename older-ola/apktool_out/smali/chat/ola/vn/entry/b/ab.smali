.class public Lchat/ola/vn/entry/b/ab;
.super Lchat/ola/vn/entry/b/j;

# interfaces
.implements Lchat/ola/vn/p/a;


# instance fields
.field private A:Lchat/ola/vn/view/OlaCachedImageView;

.field private B:Landroid/view/View;

.field private C:Landroid/view/View;

.field private D:Landroid/view/View;

.field private E:Landroid/view/View;

.field private F:Landroid/widget/ImageView;

.field private G:Landroid/widget/ImageView;

.field private H:Landroid/view/View;

.field private I:Landroid/view/ViewGroup;

.field private J:Landroid/widget/TextView;

.field private K:Lchat/ola/vn/entry/b/a/b;

.field private L:Z

.field private M:Landroid/widget/TextView;

.field private N:Landroid/view/View;

.field private O:[Lchat/ola/vn/view/OlaCachedImageView;

.field private P:[Lchat/ola/vn/view/OlaCachedImageView;

.field private Q:Lchat/ola/vn/view/AutoScrollTextView;

.field private R:Landroid/widget/TextView;

.field private S:Lchat/ola/vn/view/OlaCachedImageView;

.field private T:Landroid/view/ViewStub;

.field private U:Landroid/view/ViewStub;

.field private V:Landroid/view/View;

.field private W:Landroid/view/View;

.field private X:Lchat/ola/vn/view/OlaCachedImageView;

.field private Y:Landroid/view/View;

.field private Z:Lchat/ola/vn/entity/y;

.field private aa:Landroid/widget/ImageView;

.field public i:Landroid/widget/TextView;

.field public j:Lcom/mg/ola/common/widget/CommpressTextView;

.field protected k:Lchat/ola/vn/view/OlaCachedImageView;

.field public l:Landroid/widget/TextView;

.field public m:Landroid/widget/TextView;

.field public n:Landroid/widget/TextView;

.field public o:Landroid/widget/TextView;

.field public p:Landroid/view/View;

.field public q:Landroid/widget/TextView;

.field public r:Landroid/widget/TextView;

.field public s:Landroid/widget/TextView;

.field public t:Landroid/view/View;

.field public u:Landroid/view/View;

.field v:Landroid/view/View;

.field w:Lchat/ola/vn/view/OlaGalleryView;

.field x:Lchat/ola/vn/b/al;

.field y:Landroid/widget/TextView;

.field private z:Lchat/ola/vn/view/OlaCachedImageView;


# direct methods
.method public constructor <init>(Landroid/view/View;I)V
    .locals 6

    invoke-direct {p0}, Lchat/ola/vn/entry/b/j;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lchat/ola/vn/entry/b/ab;->L:Z

    const/4 v1, 0x0

    iput-object v1, p0, Lchat/ola/vn/entry/b/ab;->T:Landroid/view/ViewStub;

    iput-object v1, p0, Lchat/ola/vn/entry/b/ab;->U:Landroid/view/ViewStub;

    iput-object v1, p0, Lchat/ola/vn/entry/b/ab;->V:Landroid/view/View;

    iput-object v1, p0, Lchat/ola/vn/entry/b/ab;->Z:Lchat/ola/vn/entity/y;

    const/4 v1, 0x1

    :try_start_0
    invoke-virtual {p1, v1}, Landroid/view/View;->setClickable(Z)V

    const v2, 0x7f09028e

    invoke-virtual {p1, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object v2, p0, Lchat/ola/vn/entry/b/ab;->z:Lchat/ola/vn/view/OlaCachedImageView;

    const v2, 0x7f0905f3

    invoke-virtual {p1, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object v2, p0, Lchat/ola/vn/entry/b/ab;->A:Lchat/ola/vn/view/OlaCachedImageView;

    const v2, 0x7f09033a

    invoke-virtual {p1, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    iput-object v2, p0, Lchat/ola/vn/entry/b/ab;->H:Landroid/view/View;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_5

    const v2, 0x7f090079

    :try_start_1
    invoke-virtual {p1, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/view/ViewGroup;

    iput-object v2, p0, Lchat/ola/vn/entry/b/ab;->I:Landroid/view/ViewGroup;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    const v2, 0x7f090056

    :try_start_2
    invoke-virtual {p1, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/TextView;

    iput-object v2, p0, Lchat/ola/vn/entry/b/ab;->J:Landroid/widget/TextView;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    const v2, 0x7f090337

    :try_start_3
    invoke-virtual {p1, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    iput-object v2, p0, Lchat/ola/vn/entry/b/ab;->d:Landroid/view/View;

    const v2, 0x7f090550

    invoke-virtual {p1, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/TextView;

    iput-object v2, p0, Lchat/ola/vn/entry/b/ab;->i:Landroid/widget/TextView;

    const v2, 0x7f09049c

    invoke-virtual {p1, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object v2, p0, Lchat/ola/vn/entry/b/ab;->k:Lchat/ola/vn/view/OlaCachedImageView;

    const v2, 0x7f090547

    invoke-virtual {p1, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Lcom/mg/ola/common/widget/CommpressTextView;

    iput-object v2, p0, Lchat/ola/vn/entry/b/ab;->j:Lcom/mg/ola/common/widget/CommpressTextView;

    iget-object v2, p0, Lchat/ola/vn/entry/b/ab;->j:Lcom/mg/ola/common/widget/CommpressTextView;

    const v3, 0x7f0f06a1

    invoke-static {v3}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/mg/ola/common/widget/CommpressTextView;->setMoreText(Ljava/lang/CharSequence;)V

    iget-object v2, p0, Lchat/ola/vn/entry/b/ab;->j:Lcom/mg/ola/common/widget/CommpressTextView;

    invoke-static {}, Lchat/ola/vn/q/a;->a()Lchat/ola/vn/q/a;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/mg/ola/common/widget/CommpressTextView;->setOlaSpanClickListener(Lcom/mg/ola/common/widget/OlaTextView$b;)V

    const v2, 0x7f090292

    invoke-virtual {p1, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/TextView;

    iput-object v2, p0, Lchat/ola/vn/entry/b/ab;->l:Landroid/widget/TextView;

    const v2, 0x7f090293

    invoke-virtual {p1, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/TextView;

    iput-object v2, p0, Lchat/ola/vn/entry/b/ab;->m:Landroid/widget/TextView;

    const v2, 0x7f09054f

    invoke-virtual {p1, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/TextView;

    iput-object v2, p0, Lchat/ola/vn/entry/b/ab;->n:Landroid/widget/TextView;

    const v2, 0x7f0900f8

    invoke-virtual {p1, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/TextView;

    iput-object v2, p0, Lchat/ola/vn/entry/b/ab;->o:Landroid/widget/TextView;

    const v2, 0x7f0900df

    invoke-virtual {p1, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/ImageView;

    iput-object v2, p0, Lchat/ola/vn/entry/b/ab;->aa:Landroid/widget/ImageView;

    const v2, 0x7f09054c

    invoke-virtual {p1, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/TextView;

    iput-object v2, p0, Lchat/ola/vn/entry/b/ab;->q:Landroid/widget/TextView;

    const v2, 0x7f09054d

    invoke-virtual {p1, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/TextView;

    iput-object v2, p0, Lchat/ola/vn/entry/b/ab;->r:Landroid/widget/TextView;

    const v2, 0x7f090549

    invoke-virtual {p1, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/TextView;

    iput-object v2, p0, Lchat/ola/vn/entry/b/ab;->s:Landroid/widget/TextView;

    const v2, 0x7f09054b

    invoke-virtual {p1, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/ImageView;

    iput-object v2, p0, Lchat/ola/vn/entry/b/ab;->F:Landroid/widget/ImageView;

    const v2, 0x7f090548

    invoke-virtual {p1, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/ImageView;

    iput-object v2, p0, Lchat/ola/vn/entry/b/ab;->G:Landroid/widget/ImageView;

    const v2, 0x7f09054e

    invoke-virtual {p1, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    iput-object v2, p0, Lchat/ola/vn/entry/b/ab;->D:Landroid/view/View;

    const v2, 0x7f09054a

    invoke-virtual {p1, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    iput-object v2, p0, Lchat/ola/vn/entry/b/ab;->E:Landroid/view/View;

    const v2, 0x7f0900f5

    invoke-virtual {p1, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    iput-object v2, p0, Lchat/ola/vn/entry/b/ab;->p:Landroid/view/View;

    const v2, 0x7f0900f4

    invoke-virtual {p1, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    iput-object v2, p0, Lchat/ola/vn/entry/b/ab;->B:Landroid/view/View;

    const v2, 0x7f0900f7

    invoke-virtual {p1, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    iput-object v2, p0, Lchat/ola/vn/entry/b/ab;->C:Landroid/view/View;
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_5

    const/4 v2, 0x2

    const/4 v3, 0x3

    :try_start_4
    new-array v4, v3, [Lchat/ola/vn/view/OlaCachedImageView;

    iput-object v4, p0, Lchat/ola/vn/entry/b/ab;->P:[Lchat/ola/vn/view/OlaCachedImageView;

    iget-object v4, p0, Lchat/ola/vn/entry/b/ab;->P:[Lchat/ola/vn/view/OlaCachedImageView;

    const v5, 0x7f09028f

    invoke-virtual {p1, v5}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v5

    check-cast v5, Lchat/ola/vn/view/OlaCachedImageView;

    aput-object v5, v4, v0

    iget-object v4, p0, Lchat/ola/vn/entry/b/ab;->P:[Lchat/ola/vn/view/OlaCachedImageView;

    const v5, 0x7f090290

    invoke-virtual {p1, v5}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v5

    check-cast v5, Lchat/ola/vn/view/OlaCachedImageView;

    aput-object v5, v4, v1

    iget-object v4, p0, Lchat/ola/vn/entry/b/ab;->P:[Lchat/ola/vn/view/OlaCachedImageView;

    const v5, 0x7f090291

    invoke-virtual {p1, v5}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v5

    check-cast v5, Lchat/ola/vn/view/OlaCachedImageView;

    aput-object v5, v4, v2
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_2
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_5

    :catch_2
    :try_start_5
    iget-object v4, p0, Lchat/ola/vn/entry/b/ab;->j:Lcom/mg/ola/common/widget/CommpressTextView;

    const/4 v5, 0x6

    invoke-virtual {v4, v5}, Lcom/mg/ola/common/widget/CommpressTextView;->setEclipesizeMaxLine(I)V

    const v4, 0x7f0900f0

    invoke-virtual {p1, v4}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v4

    iput-object v4, p0, Lchat/ola/vn/entry/b/ab;->t:Landroid/view/View;

    const v4, 0x7f0900f1

    invoke-virtual {p1, v4}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v4

    iput-object v4, p0, Lchat/ola/vn/entry/b/ab;->u:Landroid/view/View;
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_5

    :try_start_6
    iget-object v4, p0, Lchat/ola/vn/entry/b/ab;->j:Lcom/mg/ola/common/widget/CommpressTextView;

    sget v5, Lchat/ola/vn/f;->A:I

    invoke-virtual {v4, v5}, Lcom/mg/ola/common/widget/CommpressTextView;->setMoreTextColor(I)V
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_3

    goto :goto_0

    :catch_3
    move-exception v4

    :try_start_7
    invoke-virtual {v4}, Ljava/lang/Throwable;->printStackTrace()V

    :goto_0
    const v4, 0x7f090339

    invoke-virtual {p1, v4}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v4

    check-cast v4, Landroid/view/ViewStub;

    iput-object v4, p0, Lchat/ola/vn/entry/b/ab;->T:Landroid/view/ViewStub;

    if-eqz p2, :cond_0

    iget-object v4, p0, Lchat/ola/vn/entry/b/ab;->T:Landroid/view/ViewStub;

    invoke-virtual {v4, p2}, Landroid/view/ViewStub;->setLayoutResource(I)V

    iget-object p2, p0, Lchat/ola/vn/entry/b/ab;->T:Landroid/view/ViewStub;

    invoke-virtual {p2, v0}, Landroid/view/ViewStub;->setVisibility(I)V

    const/4 p2, 0x5

    new-array p2, p2, [Lchat/ola/vn/view/OlaCachedImageView;

    iput-object p2, p0, Lchat/ola/vn/entry/b/ab;->O:[Lchat/ola/vn/view/OlaCachedImageView;
    :try_end_7
    .catch Ljava/lang/Throwable; {:try_start_7 .. :try_end_7} :catch_5

    :try_start_8
    iget-object p2, p0, Lchat/ola/vn/entry/b/ab;->O:[Lchat/ola/vn/view/OlaCachedImageView;

    const v4, 0x7f090348

    invoke-virtual {p1, v4}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v4

    check-cast v4, Lchat/ola/vn/view/OlaCachedImageView;

    aput-object v4, p2, v0

    iget-object p2, p0, Lchat/ola/vn/entry/b/ab;->O:[Lchat/ola/vn/view/OlaCachedImageView;

    const v0, 0x7f090349

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaCachedImageView;

    aput-object v0, p2, v1

    iget-object p2, p0, Lchat/ola/vn/entry/b/ab;->O:[Lchat/ola/vn/view/OlaCachedImageView;

    const v0, 0x7f09034a

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaCachedImageView;

    aput-object v0, p2, v2

    iget-object p2, p0, Lchat/ola/vn/entry/b/ab;->O:[Lchat/ola/vn/view/OlaCachedImageView;

    const v0, 0x7f09034b

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaCachedImageView;

    aput-object v0, p2, v3

    iget-object p2, p0, Lchat/ola/vn/entry/b/ab;->O:[Lchat/ola/vn/view/OlaCachedImageView;

    const/4 v0, 0x4

    const v1, 0x7f09034c

    invoke-virtual {p1, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/view/OlaCachedImageView;

    aput-object v1, p2, v0

    const p2, 0x7f090361

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, p0, Lchat/ola/vn/entry/b/ab;->M:Landroid/widget/TextView;

    const p2, 0x7f0904c4

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    iput-object p2, p0, Lchat/ola/vn/entry/b/ab;->N:Landroid/view/View;
    :try_end_8
    .catch Ljava/lang/Throwable; {:try_start_8 .. :try_end_8} :catch_4

    goto :goto_1

    :cond_0
    :try_start_9
    iget-object p2, p0, Lchat/ola/vn/entry/b/ab;->T:Landroid/view/ViewStub;

    if-eqz p2, :cond_1

    iget-object p2, p0, Lchat/ola/vn/entry/b/ab;->T:Landroid/view/ViewStub;

    const/16 v0, 0x8

    invoke-virtual {p2, v0}, Landroid/view/ViewStub;->setVisibility(I)V

    :catch_4
    :cond_1
    :goto_1
    const p2, 0x7f090333

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/view/ViewStub;

    iput-object p1, p0, Lchat/ola/vn/entry/b/ab;->U:Landroid/view/ViewStub;
    :try_end_9
    .catch Ljava/lang/Throwable; {:try_start_9 .. :try_end_9} :catch_5

    :catch_5
    return-void
.end method

.method static synthetic a(Lchat/ola/vn/entry/b/ab;)Lchat/ola/vn/view/OlaCachedImageView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/entry/b/ab;->S:Lchat/ola/vn/view/OlaCachedImageView;

    return-object p0
.end method

.method private h()V
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->a:Landroid/view/View$OnClickListener;

    if-eqz v0, :cond_3

    new-instance v0, Lchat/ola/vn/entry/b/ab$1;

    invoke-direct {v0, p0}, Lchat/ola/vn/entry/b/ab$1;-><init>(Lchat/ola/vn/entry/b/ab;)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/ab;->z:Lchat/ola/vn/view/OlaCachedImageView;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/entry/b/ab;->z:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v1, v0}, Lchat/ola/vn/view/OlaCachedImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/ab;->z:Lchat/ola/vn/view/OlaCachedImageView;

    iget-object v2, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    invoke-virtual {v1, v2}, Lchat/ola/vn/view/OlaCachedImageView;->setTag(Ljava/lang/Object;)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/ab;->z:Lchat/ola/vn/view/OlaCachedImageView;

    iget-object v2, p0, Lchat/ola/vn/entry/b/ab;->e:Landroid/view/View$OnLongClickListener;

    invoke-virtual {v1, v2}, Lchat/ola/vn/view/OlaCachedImageView;->setOnLongClickListener(Landroid/view/View$OnLongClickListener;)V

    :cond_0
    iget-object v1, p0, Lchat/ola/vn/entry/b/ab;->H:Landroid/view/View;

    invoke-virtual {v1, v0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/ab;->H:Landroid/view/View;

    iget-object v2, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    invoke-virtual {v1, v2}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/ab;->H:Landroid/view/View;

    iget-object v2, p0, Lchat/ola/vn/entry/b/ab;->e:Landroid/view/View$OnLongClickListener;

    invoke-virtual {v1, v2}, Landroid/view/View;->setOnLongClickListener(Landroid/view/View$OnLongClickListener;)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/ab;->o:Landroid/widget/TextView;

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/ab;->p:Landroid/view/View;

    invoke-virtual {v1, v0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/ab;->m:Landroid/widget/TextView;

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/ab;->l:Landroid/widget/TextView;

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/ab;->B:Landroid/view/View;

    invoke-virtual {v1, v0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/ab;->D:Landroid/view/View;

    invoke-virtual {v1, v0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/ab;->E:Landroid/view/View;

    invoke-virtual {v1, v0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/ab;->C:Landroid/view/View;

    invoke-virtual {v1, v0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/ab;->p:Landroid/view/View;

    iget-object v2, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    invoke-virtual {v1, v2}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/ab;->p:Landroid/view/View;

    iget-object v2, p0, Lchat/ola/vn/entry/b/ab;->e:Landroid/view/View$OnLongClickListener;

    invoke-virtual {v1, v2}, Landroid/view/View;->setOnLongClickListener(Landroid/view/View$OnLongClickListener;)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/ab;->D:Landroid/view/View;

    iget-object v2, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    invoke-virtual {v1, v2}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/ab;->E:Landroid/view/View;

    iget-object v2, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    invoke-virtual {v1, v2}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/ab;->D:Landroid/view/View;

    iget-object v2, p0, Lchat/ola/vn/entry/b/ab;->e:Landroid/view/View$OnLongClickListener;

    invoke-virtual {v1, v2}, Landroid/view/View;->setOnLongClickListener(Landroid/view/View$OnLongClickListener;)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/ab;->J:Landroid/widget/TextView;

    if-eqz v1, :cond_1

    iget-object v1, p0, Lchat/ola/vn/entry/b/ab;->J:Landroid/widget/TextView;

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    :cond_1
    iget-object v1, p0, Lchat/ola/vn/entry/b/ab;->aa:Landroid/widget/ImageView;

    if-eqz v1, :cond_2

    iget-object v1, p0, Lchat/ola/vn/entry/b/ab;->aa:Landroid/widget/ImageView;

    invoke-virtual {v1, v0}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    :cond_2
    iget-object v1, p0, Lchat/ola/vn/entry/b/ab;->v:Landroid/view/View;

    if-eqz v1, :cond_3

    iget-object v1, p0, Lchat/ola/vn/entry/b/ab;->v:Landroid/view/View;

    iget-object v2, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    invoke-virtual {v1, v2}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/ab;->v:Landroid/view/View;

    invoke-virtual {v1, v0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    :cond_3
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->e:Landroid/view/View$OnLongClickListener;

    if-eqz v0, :cond_4

    new-instance v0, Lchat/ola/vn/entry/b/ab$2;

    invoke-direct {v0, p0}, Lchat/ola/vn/entry/b/ab$2;-><init>(Lchat/ola/vn/entry/b/ab;)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/ab;->m:Landroid/widget/TextView;

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setOnLongClickListener(Landroid/view/View$OnLongClickListener;)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/ab;->l:Landroid/widget/TextView;

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setOnLongClickListener(Landroid/view/View$OnLongClickListener;)V

    :cond_4
    return-void
.end method

.method private i()V
    .locals 5

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->z()Ljava/lang/String;

    move-result-object v0

    const/16 v1, 0x8

    if-eqz v0, :cond_12

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->U:Landroid/view/ViewStub;

    const/4 v2, 0x0

    if-eqz v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->R:Landroid/widget/TextView;

    if-nez v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    invoke-virtual {v0}, Lchat/ola/vn/entry/b;->g()Ljava/util/List;

    move-result-object v0

    const v3, 0x7f0905d0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    invoke-virtual {v0}, Lchat/ola/vn/entry/b;->g()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->U:Landroid/view/ViewStub;

    const v4, 0x7f0b00f3

    invoke-virtual {v0, v4}, Landroid/view/ViewStub;->setLayoutResource(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->U:Landroid/view/ViewStub;

    invoke-virtual {v0}, Landroid/view/ViewStub;->inflate()Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/entry/b/ab;->W:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->W:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->W:Landroid/view/View;

    invoke-virtual {v0, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/entry/b/ab;->Y:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->Y:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    goto :goto_1

    :cond_1
    :goto_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->U:Landroid/view/ViewStub;

    const v4, 0x7f0b00f2

    invoke-virtual {v0, v4}, Landroid/view/ViewStub;->setLayoutResource(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->U:Landroid/view/ViewStub;

    invoke-virtual {v0}, Landroid/view/ViewStub;->inflate()Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/entry/b/ab;->W:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->W:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->W:Landroid/view/View;

    invoke-virtual {v0, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/entry/b/ab;->Y:Landroid/view/View;

    :goto_1
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->W:Landroid/view/View;

    iget-object v3, p0, Lchat/ola/vn/entry/b/ab;->a:Landroid/view/View$OnClickListener;

    invoke-virtual {v0, v3}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->Y:Landroid/view/View;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->Y:Landroid/view/View;

    iget-object v3, p0, Lchat/ola/vn/entry/b/ab;->a:Landroid/view/View$OnClickListener;

    invoke-virtual {v0, v3}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_2

    :cond_2
    :try_start_1
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->W:Landroid/view/View;

    const v3, 0x7f090256

    invoke-virtual {v0, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object v0, p0, Lchat/ola/vn/entry/b/ab;->S:Lchat/ola/vn/view/OlaCachedImageView;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :try_start_2
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->W:Landroid/view/View;

    const v3, 0x7f090503

    invoke-virtual {v0, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/AutoScrollTextView;

    iput-object v0, p0, Lchat/ola/vn/entry/b/ab;->Q:Lchat/ola/vn/view/AutoScrollTextView;

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->W:Landroid/view/View;

    const v3, 0x7f090505

    invoke-virtual {v0, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/entry/b/ab;->R:Landroid/widget/TextView;

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->W:Landroid/view/View;

    const v3, 0x7f090268

    invoke-virtual {v0, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object v0, p0, Lchat/ola/vn/entry/b/ab;->X:Lchat/ola/vn/view/OlaCachedImageView;

    :cond_3
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    iget-object v0, v0, Lchat/ola/vn/entity/g;->e:Lchat/ola/vn/entity/o;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    if-eqz v0, :cond_e

    :try_start_3
    invoke-direct {p0}, Lchat/ola/vn/entry/b/ab;->j()V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->W:Landroid/view/View;

    iget-object v3, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v3, v3, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    iget-object v3, v3, Lchat/ola/vn/entity/g;->e:Lchat/ola/vn/entity/o;

    invoke-virtual {v0, v3}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->Y:Landroid/view/View;

    if-eqz v0, :cond_4

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->Y:Landroid/view/View;

    iget-object v3, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v3, v3, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    iget-object v3, v3, Lchat/ola/vn/entity/g;->e:Lchat/ola/vn/entity/o;

    invoke-virtual {v0, v3}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    :cond_4
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    iget-object v0, v0, Lchat/ola/vn/entity/g;->e:Lchat/ola/vn/entity/o;

    invoke-virtual {v0}, Lchat/ola/vn/entity/o;->b()Lchat/ola/vn/entity/OlaCheckInActionEntity;

    move-result-object v0
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_3

    const/4 v3, 0x0

    if-eqz v0, :cond_a

    :try_start_4
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    iget-object v0, v0, Lchat/ola/vn/entity/g;->e:Lchat/ola/vn/entity/o;

    invoke-virtual {v0}, Lchat/ola/vn/entity/o;->c()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entity/OlaCheckInItemEntity;
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_1

    goto :goto_2

    :catch_1
    move-object v0, v3

    :goto_2
    const v1, 0x7f080698

    if-eqz v0, :cond_5

    :try_start_5
    invoke-virtual {v0}, Lchat/ola/vn/entity/OlaCheckInItemEntity;->d()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_5

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v3

    iget-object v4, p0, Lchat/ola/vn/entry/b/ab;->X:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0}, Lchat/ola/vn/entity/OlaCheckInItemEntity;->d()Ljava/lang/String;

    move-result-object v0

    invoke-static {v3, v4, v0, v1, v2}, Lchat/ola/vn/c/f;->a(Landroid/content/Context;Lchat/ola/vn/view/OlaCachedImageView;Ljava/lang/String;IZ)V

    goto :goto_3

    :cond_5
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    iget-object v0, v0, Lchat/ola/vn/entity/g;->e:Lchat/ola/vn/entity/o;

    invoke-virtual {v0}, Lchat/ola/vn/entity/o;->b()Lchat/ola/vn/entity/OlaCheckInActionEntity;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/entity/OlaCheckInActionEntity;->c()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_6

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v0

    iget-object v3, p0, Lchat/ola/vn/entry/b/ab;->X:Lchat/ola/vn/view/OlaCachedImageView;

    iget-object v4, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v4, v4, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    iget-object v4, v4, Lchat/ola/vn/entity/g;->e:Lchat/ola/vn/entity/o;

    invoke-virtual {v4}, Lchat/ola/vn/entity/o;->b()Lchat/ola/vn/entity/OlaCheckInActionEntity;

    move-result-object v4

    invoke-virtual {v4}, Lchat/ola/vn/entity/OlaCheckInActionEntity;->c()Ljava/lang/String;

    move-result-object v4

    invoke-static {v0, v3, v4, v1, v2}, Lchat/ola/vn/c/f;->a(Landroid/content/Context;Lchat/ola/vn/view/OlaCachedImageView;Ljava/lang/String;IZ)V

    :cond_6
    :goto_3
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    iget-object v0, v0, Lchat/ola/vn/entity/g;->e:Lchat/ola/vn/entity/o;

    invoke-virtual {v0}, Lchat/ola/vn/entity/o;->b()Lchat/ola/vn/entity/OlaCheckInActionEntity;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/entity/OlaCheckInActionEntity;->b()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_c

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    iget-object v0, v0, Lchat/ola/vn/entity/g;->e:Lchat/ola/vn/entity/o;

    invoke-virtual {v0}, Lchat/ola/vn/entity/o;->e()Ljava/lang/CharSequence;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->c(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_7

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->Q:Lchat/ola/vn/view/AutoScrollTextView;

    iget-object v1, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v1, v1, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    iget-object v1, v1, Lchat/ola/vn/entity/g;->e:Lchat/ola/vn/entity/o;

    invoke-virtual {v1}, Lchat/ola/vn/entity/o;->e()Ljava/lang/CharSequence;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/AutoScrollTextView;->setText(Ljava/lang/CharSequence;)V

    goto/16 :goto_5

    :cond_7
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    iget-object v0, v0, Lchat/ola/vn/entity/g;->e:Lchat/ola/vn/entity/o;

    invoke-virtual {v0}, Lchat/ola/vn/entity/o;->b()Lchat/ola/vn/entity/OlaCheckInActionEntity;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/entity/OlaCheckInActionEntity;->b()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/entry/b/ab;->Q:Lchat/ola/vn/view/AutoScrollTextView;

    invoke-virtual {v1, v0}, Lchat/ola/vn/view/AutoScrollTextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    iget-object v0, v0, Lchat/ola/vn/entity/g;->e:Lchat/ola/vn/entity/o;

    invoke-virtual {v0}, Lchat/ola/vn/entity/o;->c()Ljava/util/List;

    move-result-object v0

    if-eqz v0, :cond_9

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    iget-object v0, v0, Lchat/ola/vn/entity/g;->e:Lchat/ola/vn/entity/o;

    invoke-virtual {v0}, Lchat/ola/vn/entity/o;->c()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_9

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    iget-object v0, v0, Lchat/ola/vn/entity/g;->e:Lchat/ola/vn/entity/o;

    invoke-virtual {v0}, Lchat/ola/vn/entity/o;->c()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entity/OlaCheckInItemEntity;

    invoke-virtual {v0}, Lchat/ola/vn/entity/OlaCheckInItemEntity;->b()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_9

    iget-object v1, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v1, v1, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    iget-object v1, v1, Lchat/ola/vn/entity/g;->e:Lchat/ola/vn/entity/o;

    invoke-virtual {v1}, Lchat/ola/vn/entity/o;->c()Ljava/util/List;

    move-result-object v1

    invoke-interface {v1, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/entity/OlaCheckInItemEntity;

    invoke-virtual {v1}, Lchat/ola/vn/entity/OlaCheckInItemEntity;->g()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_8

    new-instance v1, Landroid/text/SpannableString;

    invoke-direct {v1, v0}, Landroid/text/SpannableString;-><init>(Ljava/lang/CharSequence;)V

    new-instance v3, Landroid/text/style/ForegroundColorSpan;

    sget v4, Lchat/ola/vn/f;->A:I

    invoke-direct {v3, v4}, Landroid/text/style/ForegroundColorSpan;-><init>(I)V

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    const/16 v4, 0x21

    invoke-virtual {v1, v3, v2, v0, v4}, Landroid/text/SpannableString;->setSpan(Ljava/lang/Object;III)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->Q:Lchat/ola/vn/view/AutoScrollTextView;

    const-string v3, " "

    invoke-virtual {v0, v3}, Lchat/ola/vn/view/AutoScrollTextView;->append(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->Q:Lchat/ola/vn/view/AutoScrollTextView;

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/AutoScrollTextView;->append(Ljava/lang/CharSequence;)V

    goto :goto_4

    :cond_8
    iget-object v1, p0, Lchat/ola/vn/entry/b/ab;->Q:Lchat/ola/vn/view/AutoScrollTextView;

    const-string v3, " "

    invoke-virtual {v1, v3}, Lchat/ola/vn/view/AutoScrollTextView;->append(Ljava/lang/CharSequence;)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/ab;->Q:Lchat/ola/vn/view/AutoScrollTextView;

    invoke-virtual {v1, v0}, Lchat/ola/vn/view/AutoScrollTextView;->append(Ljava/lang/CharSequence;)V

    :goto_4
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    iget-object v0, v0, Lchat/ola/vn/entity/g;->e:Lchat/ola/vn/entity/o;

    iget-object v1, p0, Lchat/ola/vn/entry/b/ab;->Q:Lchat/ola/vn/view/AutoScrollTextView;

    invoke-virtual {v1}, Lchat/ola/vn/view/AutoScrollTextView;->getText()Ljava/lang/CharSequence;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/o;->a(Ljava/lang/CharSequence;)V

    :cond_9
    :goto_5
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->R:Landroid/widget/TextView;

    iget-object v1, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v1, v1, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    iget-object v1, v1, Lchat/ola/vn/entity/g;->e:Lchat/ola/vn/entity/o;

    invoke-virtual {v1}, Lchat/ola/vn/entity/o;->d()Lchat/ola/vn/entity/OlaVenueEntity;

    move-result-object v1

    invoke-virtual {v1}, Lchat/ola/vn/entity/OlaVenueEntity;->c()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_7

    :cond_a
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->Q:Lchat/ola/vn/view/AutoScrollTextView;

    iget-object v4, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v4, v4, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    iget-object v4, v4, Lchat/ola/vn/entity/g;->e:Lchat/ola/vn/entity/o;

    invoke-virtual {v4}, Lchat/ola/vn/entity/o;->d()Lchat/ola/vn/entity/OlaVenueEntity;

    move-result-object v4

    invoke-virtual {v4}, Lchat/ola/vn/entity/OlaVenueEntity;->c()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v0, v4}, Lchat/ola/vn/view/AutoScrollTextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    iget-object v0, v0, Lchat/ola/vn/entity/g;->e:Lchat/ola/vn/entity/o;

    invoke-virtual {v0}, Lchat/ola/vn/entity/o;->d()Lchat/ola/vn/entity/OlaVenueEntity;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/entity/OlaVenueEntity;->e()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_b

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->R:Landroid/widget/TextView;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    goto :goto_6

    :cond_b
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->R:Landroid/widget/TextView;

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->R:Landroid/widget/TextView;

    iget-object v1, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v1, v1, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    iget-object v1, v1, Lchat/ola/vn/entity/g;->e:Lchat/ola/vn/entity/o;

    invoke-virtual {v1}, Lchat/ola/vn/entity/o;->d()Lchat/ola/vn/entity/OlaVenueEntity;

    move-result-object v1

    invoke-virtual {v1}, Lchat/ola/vn/entity/OlaVenueEntity;->e()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :goto_6
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->X:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v1

    invoke-virtual {v1}, Lchat/ola/vn/c;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const v4, 0x7f080695

    invoke-static {v1, v4}, Landroid/graphics/BitmapFactory;->decodeResource(Landroid/content/res/Resources;I)Landroid/graphics/Bitmap;

    move-result-object v1

    invoke-virtual {v0, v1, v3}, Lchat/ola/vn/view/OlaCachedImageView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    :cond_c
    :goto_7
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->U:Landroid/view/ViewStub;

    invoke-virtual {v0, v2}, Landroid/view/ViewStub;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->Y:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    iget-object v0, v0, Lchat/ola/vn/entity/g;->e:Lchat/ola/vn/entity/o;

    invoke-virtual {v0}, Lchat/ola/vn/entity/o;->c()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entity/OlaCheckInItemEntity;

    invoke-virtual {v0}, Lchat/ola/vn/entity/OlaCheckInItemEntity;->g()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_d

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->Q:Lchat/ola/vn/view/AutoScrollTextView;

    new-instance v1, Lchat/ola/vn/entry/b/ab$3;

    invoke-direct {v1, p0}, Lchat/ola/vn/entry/b/ab$3;-><init>(Lchat/ola/vn/entry/b/ab;)V

    :goto_8
    invoke-virtual {v0, v1}, Lchat/ola/vn/view/AutoScrollTextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    return-void

    :cond_d
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->Q:Lchat/ola/vn/view/AutoScrollTextView;

    iget-object v1, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v1, v1, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    iget-object v1, v1, Lchat/ola/vn/entity/g;->e:Lchat/ola/vn/entity/o;

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/AutoScrollTextView;->setTag(Ljava/lang/Object;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->Q:Lchat/ola/vn/view/AutoScrollTextView;

    iget-object v1, p0, Lchat/ola/vn/entry/b/ab;->a:Landroid/view/View$OnClickListener;
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_3

    goto :goto_8

    :cond_e
    :try_start_6
    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz v0, :cond_f

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v3, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v3, v3, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v3}, Lchat/ola/vn/entity/g;->z()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3, p0}, Lchat/ola/vn/network/OlaNetworkService;->b(Ljava/lang/String;Lchat/ola/vn/p/a;)V

    :cond_f
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->U:Landroid/view/ViewStub;

    if-eqz v0, :cond_13

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    invoke-virtual {v0}, Lchat/ola/vn/entry/b;->g()Ljava/util/List;

    move-result-object v0

    if-eqz v0, :cond_11

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    invoke-virtual {v0}, Lchat/ola/vn/entry/b;->g()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-nez v0, :cond_10

    goto :goto_a

    :cond_10
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->W:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->Y:Landroid/view/View;

    :goto_9
    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    return-void

    :cond_11
    :goto_a
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->W:Landroid/view/View;

    goto :goto_9

    :cond_12
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->U:Landroid/view/ViewStub;

    if-eqz v0, :cond_13

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->U:Landroid/view/ViewStub;

    invoke-virtual {v0, v1}, Landroid/view/ViewStub;->setVisibility(I)V
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_2

    return-void

    :catch_2
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    :catch_3
    :cond_13
    return-void
.end method

.method private j()V
    .locals 5

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->S:Lchat/ola/vn/view/OlaCachedImageView;

    if-eqz v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->Z:Lchat/ola/vn/entity/y;

    if-nez v0, :cond_1

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz v0, :cond_0

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v1, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v1, v1, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    iget-object v1, v1, Lchat/ola/vn/entity/g;->e:Lchat/ola/vn/entity/o;

    invoke-virtual {v1}, Lchat/ola/vn/entity/o;->d()Lchat/ola/vn/entity/OlaVenueEntity;

    move-result-object v1

    invoke-virtual {v1}, Lchat/ola/vn/entity/OlaVenueEntity;->b()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1, p0}, Lchat/ola/vn/network/OlaNetworkService;->c(Ljava/lang/String;Lchat/ola/vn/p/a;)V

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->S:Lchat/ola/vn/view/OlaCachedImageView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1, v1}, Lchat/ola/vn/view/OlaCachedImageView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    return-void

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->Z:Lchat/ola/vn/entity/y;

    invoke-virtual {v0}, Lchat/ola/vn/entity/y;->i()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->Z:Lchat/ola/vn/entity/y;

    invoke-virtual {v0}, Lchat/ola/vn/entity/y;->f()Ljava/lang/String;

    move-result-object v0

    iget-object v2, p0, Lchat/ola/vn/entry/b/ab;->Z:Lchat/ola/vn/entity/y;

    invoke-virtual {v2}, Lchat/ola/vn/entity/y;->g()Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lchat/ola/vn/entry/b/ab;->S:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v3, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/ab;->S:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v1}, Lchat/ola/vn/view/OlaCachedImageView;->getWidth()I

    move-result v1

    iget-object v3, p0, Lchat/ola/vn/entry/b/ab;->S:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v3}, Lchat/ola/vn/view/OlaCachedImageView;->getHeight()I

    move-result v3

    const/16 v4, 0x10

    invoke-static {v2, v0, v1, v3, v4}, Lchat/ola/vn/c/f;->a(Ljava/lang/String;Ljava/lang/String;III)Lchat/ola/vn/c/f;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/c/f;->e()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/entry/b/ab;->S:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v2, v1}, Lchat/ola/vn/view/OlaCachedImageView;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_3

    iget-object v2, p0, Lchat/ola/vn/entry/b/ab;->S:Lchat/ola/vn/view/OlaCachedImageView;

    sget-object v3, Landroid/widget/ImageView$ScaleType;->CENTER_INSIDE:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {v2, v3}, Lchat/ola/vn/view/OlaCachedImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    iget-object v2, p0, Lchat/ola/vn/entry/b/ab;->S:Lchat/ola/vn/view/OlaCachedImageView;

    const v3, 0x7f080711

    invoke-virtual {v2, v3}, Lchat/ola/vn/view/OlaCachedImageView;->setImageResource(I)V

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v2

    new-instance v3, Lchat/ola/vn/entry/b/ab$4;

    invoke-direct {v3, p0, v1, v0}, Lchat/ola/vn/entry/b/ab$4;-><init>(Lchat/ola/vn/entry/b/ab;Ljava/lang/String;Lchat/ola/vn/c/f;)V

    invoke-virtual {v2, v1, v3}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/c/w;)V

    return-void

    :cond_2
    invoke-direct {p0}, Lchat/ola/vn/entry/b/ab;->k()V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->S:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_3
    return-void
.end method

.method private k()V
    .locals 4

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->Z:Lchat/ola/vn/entity/y;

    invoke-virtual {v0}, Lchat/ola/vn/entity/y;->i()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_1

    invoke-static {v0}, Lchat/ola/vn/c/f;->o(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/entry/b/ab;->S:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v1, v0, v2}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V

    return-void

    :cond_0
    sget v1, Lchat/ola/vn/e;->c:I

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v2

    iget-object v3, p0, Lchat/ola/vn/entry/b/ab;->S:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v2, v0, v3, v1}, Lchat/ola/vn/c/t;->b(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->S:Lchat/ola/vn/view/OlaCachedImageView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1, v1}, Lchat/ola/vn/view/OlaCachedImageView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->S:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setLoadingUrl(Ljava/lang/String;)V

    :cond_1
    return-void
.end method

.method private l()V
    .locals 6

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->j:Ljava/util/List;

    const/16 v1, 0x8

    const/4 v2, 0x1

    const/4 v3, 0x0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->j:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_1

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->m:Landroid/widget/TextView;

    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->j:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-ne v0, v2, :cond_1

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->m:Landroid/widget/TextView;

    const-string v4, ""

    invoke-virtual {v0, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_0

    :cond_1
    iget-object v4, p0, Lchat/ola/vn/entry/b/ab;->m:Landroid/widget/TextView;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v0, ""

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v4, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :goto_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->m:Landroid/widget/TextView;

    const v4, 0x7f08071a

    invoke-virtual {v0, v4}, Landroid/widget/TextView;->setBackgroundResource(I)V

    goto :goto_2

    :cond_2
    :goto_1
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->m:Landroid/widget/TextView;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    :goto_2
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->k:Ljava/util/List;

    if-eqz v0, :cond_5

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->k:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_3

    goto :goto_3

    :cond_3
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->l:Landroid/widget/TextView;

    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->k:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    iget-object v1, p0, Lchat/ola/vn/entry/b/ab;->l:Landroid/widget/TextView;

    const v3, 0x7f080717

    invoke-virtual {v1, v3}, Landroid/widget/TextView;->setBackgroundResource(I)V

    if-ne v0, v2, :cond_4

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->l:Landroid/widget/TextView;

    const-string v1, ""

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_4
    iget-object v1, p0, Lchat/ola/vn/entry/b/ab;->l:Landroid/widget/TextView;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v0, ""

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_5
    :goto_3
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->l:Landroid/widget/TextView;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    return-void
.end method

.method private m()V
    .locals 9

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->j:Lcom/mg/ola/common/widget/CommpressTextView;

    iget-object v1, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v1, v1, Lchat/ola/vn/entry/b;->c:Ljava/lang/CharSequence;

    invoke-virtual {v0, v1}, Lcom/mg/ola/common/widget/CommpressTextView;->setFullText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->j:Lcom/mg/ola/common/widget/CommpressTextView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/mg/ola/common/widget/CommpressTextView;->setOnEclipesizeListener(Lcom/mg/ola/common/widget/CommpressTextView$a;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    invoke-virtual {v0}, Lchat/ola/vn/entry/b;->e()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->j:Lcom/mg/ola/common/widget/CommpressTextView;

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/CommpressTextView;->a()V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->j:Lcom/mg/ola/common/widget/CommpressTextView;

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/CommpressTextView;->b()V

    :goto_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->j:Lcom/mg/ola/common/widget/CommpressTextView;

    new-instance v1, Lchat/ola/vn/entry/b/ab$7;

    invoke-direct {v1, p0}, Lchat/ola/vn/entry/b/ab$7;-><init>(Lchat/ola/vn/entry/b/ab;)V

    invoke-virtual {v0, v1}, Lcom/mg/ola/common/widget/CommpressTextView;->setOnEclipesizeListener(Lcom/mg/ola/common/widget/CommpressTextView$a;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->B()Lchat/ola/vn/entity/w;

    move-result-object v0

    const/16 v1, 0x8

    if-eqz v0, :cond_2

    iget-object v2, p0, Lchat/ola/vn/entry/b/ab;->k:Lchat/ola/vn/view/OlaCachedImageView;

    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    invoke-virtual {v0}, Lchat/ola/vn/entity/w;->a()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_1

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v3

    invoke-virtual {v0}, Lchat/ola/vn/entity/w;->a()Ljava/lang/String;

    move-result-object v4

    iget-object v5, p0, Lchat/ola/vn/entry/b/ab;->k:Lchat/ola/vn/view/OlaCachedImageView;

    sget-object v6, Landroid/widget/ImageView$ScaleType;->CENTER_INSIDE:Landroid/widget/ImageView$ScaleType;

    const/4 v7, 0x0

    const/16 v8, 0xf0

    invoke-virtual/range {v3 .. v8}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Landroid/widget/ImageView$ScaleType;Landroid/view/View;I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->k:Lchat/ola/vn/view/OlaCachedImageView;

    sget-object v1, Landroid/widget/ImageView$ScaleType;->CENTER_INSIDE:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    return-void

    :cond_1
    invoke-virtual {v0}, Lchat/ola/vn/entity/w;->c()I

    move-result v2

    if-lez v2, :cond_2

    iget-object v1, p0, Lchat/ola/vn/entry/b/ab;->k:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0}, Lchat/ola/vn/entity/w;->c()I

    move-result v0

    invoke-static {v0}, Lchat/ola/vn/util/c;->a(I)I

    move-result v0

    invoke-virtual {v1, v0}, Lchat/ola/vn/view/OlaCachedImageView;->setImageResource(I)V

    return-void

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->k:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    return-void
.end method

.method private n()V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->i:Landroid/widget/TextView;

    iget-object v1, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    invoke-virtual {v1}, Lchat/ola/vn/entry/b;->b()Ljava/lang/CharSequence;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->h()S

    move-result v0

    const/4 v1, 0x0

    packed-switch v0, :pswitch_data_0

    invoke-direct {p0}, Lchat/ola/vn/entry/b/ab;->y()V

    return-void

    :pswitch_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->A:Lchat/ola/vn/view/OlaCachedImageView;

    if-eqz v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->A:Lchat/ola/vn/view/OlaCachedImageView;

    const-string v2, "2131232415"

    invoke-virtual {v0, v2}, Lchat/ola/vn/view/OlaCachedImageView;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->A:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->A:Lchat/ola/vn/view/OlaCachedImageView;

    const v1, 0x7f08069f

    :goto_0
    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setImageResource(I)V

    return-void

    :pswitch_1
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->A:Lchat/ola/vn/view/OlaCachedImageView;

    if-eqz v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->A:Lchat/ola/vn/view/OlaCachedImageView;

    const-string v2, "2131232416"

    invoke-virtual {v0, v2}, Lchat/ola/vn/view/OlaCachedImageView;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    return-void

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->A:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->A:Lchat/ola/vn/view/OlaCachedImageView;

    const v1, 0x7f0806a0

    goto :goto_0

    :pswitch_2
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->A:Lchat/ola/vn/view/OlaCachedImageView;

    if-eqz v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->A:Lchat/ola/vn/view/OlaCachedImageView;

    const-string v2, "2131232414"

    invoke-virtual {v0, v2}, Lchat/ola/vn/view/OlaCachedImageView;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    return-void

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->A:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->A:Lchat/ola/vn/view/OlaCachedImageView;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    const v1, 0x7f08069e

    goto :goto_0

    :catch_0
    :cond_3
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private o()V
    .locals 11

    iget-boolean v0, p0, Lchat/ola/vn/entry/b/ab;->L:Z

    const/16 v1, 0x8

    if-eqz v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->k()S

    move-result v0

    const/16 v2, 0xb

    if-eq v0, v2, :cond_3

    const v2, 0x7f0f0698

    const v3, 0x7f0f0486

    const v4, 0x7f0f0487

    const/4 v5, 0x1

    const/4 v6, 0x0

    packed-switch v0, :pswitch_data_0

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->g()I

    move-result v0

    if-eqz v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->o:Landroid/widget/TextView;

    invoke-virtual {v0, v6}, Landroid/widget/TextView;->setVisibility(I)V

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->g()I

    move-result v0

    if-le v0, v5, :cond_0

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->o:Landroid/widget/TextView;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v2, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v2, v2, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v2}, Lchat/ola/vn/entity/g;->g()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v2, " "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {v4}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :goto_0
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->o:Landroid/widget/TextView;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v2, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v2, v2, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v2}, Lchat/ola/vn/entity/g;->g()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v2, " "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {v3}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :pswitch_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->v()J

    move-result-wide v7

    const-wide/16 v9, 0x0

    cmp-long v0, v7, v9

    if-lez v0, :cond_1

    goto :goto_1

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->g()I

    move-result v0

    if-eqz v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->o:Landroid/widget/TextView;

    invoke-virtual {v0, v6}, Landroid/widget/TextView;->setVisibility(I)V

    :try_start_1
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->g()I

    move-result v0

    if-le v0, v5, :cond_2

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->o:Landroid/widget/TextView;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v2, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v2, v2, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v2}, Lchat/ola/vn/entity/g;->g()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v2, " "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {v4}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_0

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->o:Landroid/widget/TextView;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v2, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v2, v2, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v2}, Lchat/ola/vn/entity/g;->g()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v2, " "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {v3}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto/16 :goto_0

    :goto_1
    :pswitch_1
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->o:Landroid/widget/TextView;

    invoke-virtual {v0, v6}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->o:Landroid/widget/TextView;

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setText(I)V

    return-void

    :cond_3
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->o:Landroid/widget/TextView;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    :catch_0
    return-void

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private p()V
    .locals 3

    const/16 v0, 0x8

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/entry/b/ab;->K:Lchat/ola/vn/entry/b/a/b;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/entry/b/ab;->I:Landroid/view/ViewGroup;

    invoke-virtual {v1}, Landroid/view/ViewGroup;->removeAllViews()V

    const/4 v1, 0x0

    iput-object v1, p0, Lchat/ola/vn/entry/b/ab;->K:Lchat/ola/vn/entry/b/a/b;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_0
    :goto_0
    iget-object v1, p0, Lchat/ola/vn/entry/b/ab;->I:Landroid/view/ViewGroup;

    invoke-virtual {v1, v0}, Landroid/view/ViewGroup;->setVisibility(I)V

    return-void

    :catchall_0
    move-exception v1

    goto :goto_1

    :catch_0
    move-exception v1

    :try_start_1
    invoke-virtual {v1}, Ljava/lang/Throwable;->printStackTrace()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    return-void

    :goto_1
    iget-object v2, p0, Lchat/ola/vn/entry/b/ab;->I:Landroid/view/ViewGroup;

    invoke-virtual {v2, v0}, Landroid/view/ViewGroup;->setVisibility(I)V

    throw v1
.end method

.method private q()V
    .locals 2

    :try_start_0
    iget-boolean v0, p0, Lchat/ola/vn/entry/b/ab;->L:Z

    if-eqz v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->k()S

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_2

    const/16 v1, 0xb

    if-eq v0, v1, :cond_0

    packed-switch v0, :pswitch_data_0

    goto :goto_0

    :cond_0
    :pswitch_0
    :try_start_1
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget-boolean v0, v0, Lchat/ola/vn/entity/f;->a:Z

    if-eqz v0, :cond_1

    invoke-direct {p0}, Lchat/ola/vn/entry/b/ab;->p()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    return-void

    :catch_0
    :cond_1
    :try_start_2
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->I:Landroid/view/ViewGroup;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/view/ViewGroup;->setVisibility(I)V

    invoke-direct {p0}, Lchat/ola/vn/entry/b/ab;->s()V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->K:Lchat/ola/vn/entry/b/a/b;

    iget-object v1, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    invoke-virtual {v0, p0, v1}, Lchat/ola/vn/entry/b/a/b;->a(Lchat/ola/vn/entry/b/ab;Lchat/ola/vn/entry/b;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    return-void

    :catch_1
    move-exception v0

    :try_start_3
    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    invoke-direct {p0}, Lchat/ola/vn/entry/b/ab;->p()V

    return-void

    :cond_2
    :goto_0
    invoke-direct {p0}, Lchat/ola/vn/entry/b/ab;->p()V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_2

    :catch_2
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_0
    .end packed-switch
.end method

.method private r()V
    .locals 8

    const/16 v0, 0x8

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v1, v1, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v1}, Lchat/ola/vn/entity/g;->A()J

    move-result-wide v1

    const-wide/16 v3, 0x0

    cmp-long v5, v1, v3

    const/4 v3, 0x0

    if-lez v5, :cond_2

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, ""

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {v1, v2}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    const-wide/32 v5, 0x3b9aca00

    cmp-long v7, v1, v5

    const-wide/32 v5, 0xf4240

    if-ltz v7, :cond_0

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    div-long/2addr v1, v5

    invoke-static {v1, v2}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "M"

    :goto_0
    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    goto :goto_1

    :cond_0
    cmp-long v7, v1, v5

    if-ltz v7, :cond_1

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-wide/16 v5, 0x3e8

    div-long/2addr v1, v5

    invoke-static {v1, v2}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "K"

    goto :goto_0

    :cond_1
    :goto_1
    iget-object v1, p0, Lchat/ola/vn/entry/b/ab;->J:Landroid/widget/TextView;

    invoke-virtual {v1, v3}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/ab;->J:Landroid/widget/TextView;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v3, " "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v3, 0x7f0f0699

    invoke-static {v3}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    :goto_2
    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_2
    iget-object v1, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v1, v1, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    iget-boolean v1, v1, Lchat/ola/vn/entity/g;->c:Z

    if-eqz v1, :cond_3

    iget-object v1, p0, Lchat/ola/vn/entry/b/ab;->J:Landroid/widget/TextView;

    invoke-virtual {v1, v3}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/ab;->J:Landroid/widget/TextView;

    const v2, 0x7f0f0368

    invoke-static {v2}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v2

    goto :goto_2

    :cond_3
    iget-object v1, p0, Lchat/ola/vn/entry/b/ab;->J:Landroid/widget/TextView;

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    iget-object v1, p0, Lchat/ola/vn/entry/b/ab;->J:Landroid/widget/TextView;

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    return-void
.end method

.method private s()V
    .locals 4

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->k()S

    move-result v0

    const/16 v1, 0xb

    const/4 v2, 0x0

    if-eq v0, v1, :cond_4

    packed-switch v0, :pswitch_data_0

    return-void

    :pswitch_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->K:Lchat/ola/vn/entry/b/a/b;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->K:Lchat/ola/vn/entry/b/a/b;

    invoke-static {}, Lchat/ola/vn/entry/b/a/c;->a()B

    move-result v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/entry/b/a/b;->a(B)Z

    move-result v0

    if-nez v0, :cond_0

    iput-object v2, p0, Lchat/ola/vn/entry/b/ab;->K:Lchat/ola/vn/entry/b/a/b;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->K:Lchat/ola/vn/entry/b/a/b;

    if-nez v0, :cond_1

    new-instance v0, Lchat/ola/vn/entry/b/a/c;

    invoke-virtual {p0}, Lchat/ola/vn/entry/b/ab;->d()Landroid/content/Context;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/entry/b/ab;->I:Landroid/view/ViewGroup;

    iget-object v3, p0, Lchat/ola/vn/entry/b/ab;->a:Landroid/view/View$OnClickListener;

    invoke-direct {v0, v1, v2, v3}, Lchat/ola/vn/entry/b/a/c;-><init>(Landroid/content/Context;Landroid/view/ViewGroup;Landroid/view/View$OnClickListener;)V

    iput-object v0, p0, Lchat/ola/vn/entry/b/ab;->K:Lchat/ola/vn/entry/b/a/b;

    :cond_1
    return-void

    :pswitch_1
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->K:Lchat/ola/vn/entry/b/a/b;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->K:Lchat/ola/vn/entry/b/a/b;

    invoke-static {}, Lchat/ola/vn/entry/b/a/a;->a()B

    move-result v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/entry/b/a/b;->a(B)Z

    move-result v0

    if-nez v0, :cond_2

    iput-object v2, p0, Lchat/ola/vn/entry/b/ab;->K:Lchat/ola/vn/entry/b/a/b;

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->K:Lchat/ola/vn/entry/b/a/b;

    if-nez v0, :cond_3

    new-instance v0, Lchat/ola/vn/entry/b/a/a;

    invoke-virtual {p0}, Lchat/ola/vn/entry/b/ab;->d()Landroid/content/Context;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/entry/b/ab;->I:Landroid/view/ViewGroup;

    iget-object v3, p0, Lchat/ola/vn/entry/b/ab;->a:Landroid/view/View$OnClickListener;

    invoke-direct {v0, v1, v2, v3}, Lchat/ola/vn/entry/b/a/a;-><init>(Landroid/content/Context;Landroid/view/ViewGroup;Landroid/view/View$OnClickListener;)V

    iput-object v0, p0, Lchat/ola/vn/entry/b/ab;->K:Lchat/ola/vn/entry/b/a/b;

    :cond_3
    return-void

    :cond_4
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->K:Lchat/ola/vn/entry/b/a/b;

    if-eqz v0, :cond_5

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->K:Lchat/ola/vn/entry/b/a/b;

    invoke-static {}, Lchat/ola/vn/entry/b/a/c;->a()B

    move-result v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/entry/b/a/b;->a(B)Z

    move-result v0

    if-nez v0, :cond_5

    iput-object v2, p0, Lchat/ola/vn/entry/b/ab;->K:Lchat/ola/vn/entry/b/a/b;

    :cond_5
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->K:Lchat/ola/vn/entry/b/a/b;

    if-nez v0, :cond_6

    new-instance v0, Lchat/ola/vn/entry/b/a/c;

    invoke-virtual {p0}, Lchat/ola/vn/entry/b/ab;->d()Landroid/content/Context;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/entry/b/ab;->I:Landroid/view/ViewGroup;

    iget-object v3, p0, Lchat/ola/vn/entry/b/ab;->a:Landroid/view/View$OnClickListener;

    invoke-direct {v0, v1, v2, v3}, Lchat/ola/vn/entry/b/a/c;-><init>(Landroid/content/Context;Landroid/view/ViewGroup;Landroid/view/View$OnClickListener;)V

    iput-object v0, p0, Lchat/ola/vn/entry/b/ab;->K:Lchat/ola/vn/entry/b/a/b;

    :cond_6
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private t()V
    .locals 9

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    invoke-virtual {v0}, Lchat/ola/vn/entry/b;->h()B

    move-result v0

    const/4 v1, 0x1

    if-eq v0, v1, :cond_6

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    invoke-virtual {v0}, Lchat/ola/vn/entry/b;->h()B

    move-result v0

    const/4 v2, 0x2

    if-ne v0, v2, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->C:Landroid/view/View;

    const/4 v3, 0x0

    invoke-virtual {v0, v3}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->u:Landroid/view/View;

    invoke-virtual {v0, v3}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->f()I

    move-result v0

    iget-object v4, p0, Lchat/ola/vn/entry/b/ab;->r:Landroid/widget/TextView;

    sget v5, Lchat/ola/vn/f;->A:I

    invoke-virtual {v4, v5}, Landroid/widget/TextView;->setTextColor(I)V

    const/16 v4, 0x8

    if-lez v0, :cond_2

    iget-object v5, p0, Lchat/ola/vn/entry/b/ab;->q:Landroid/widget/TextView;

    invoke-virtual {v5, v3}, Landroid/widget/TextView;->setVisibility(I)V

    if-le v0, v1, :cond_1

    iget-object v5, p0, Lchat/ola/vn/entry/b/ab;->q:Landroid/widget/TextView;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    int-to-long v7, v0

    invoke-static {v7, v8}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v0, " "

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v0, 0x7f0f0538

    :goto_0
    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v5, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_1

    :cond_1
    iget-object v5, p0, Lchat/ola/vn/entry/b/ab;->q:Landroid/widget/TextView;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    int-to-long v7, v0

    invoke-static {v7, v8}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v0, " "

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v0, 0x7f0f0539

    goto :goto_0

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->q:Landroid/widget/TextView;

    invoke-virtual {v0, v4}, Landroid/widget/TextView;->setVisibility(I)V

    :goto_1
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->i()S

    move-result v0

    if-ne v0, v1, :cond_3

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->F:Landroid/widget/ImageView;

    const v5, 0x7f080701

    invoke-virtual {v0, v5}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->r:Landroid/widget/TextView;

    sget v5, Lchat/ola/vn/f;->H:I

    invoke-virtual {v0, v5}, Landroid/widget/TextView;->setTextColor(I)V

    goto :goto_2

    :cond_3
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->F:Landroid/widget/ImageView;

    const v5, 0x7f080700

    invoke-virtual {v0, v5}, Landroid/widget/ImageView;->setImageResource(I)V

    :goto_2
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->E()[Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_5

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->E()[Ljava/lang/String;

    move-result-object v0

    array-length v0, v0

    const/4 v5, 0x0

    packed-switch v0, :pswitch_data_0

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->P:[Lchat/ola/vn/view/OlaCachedImageView;

    goto :goto_4

    :pswitch_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->P:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v0, v0, v3

    invoke-virtual {v0, v3}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->P:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v0, v0, v1

    invoke-virtual {v0, v3}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    invoke-direct {p0}, Lchat/ola/vn/entry/b/ab;->w()V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->P:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v0, v0, v2

    invoke-virtual {v0, v5, v5}, Lchat/ola/vn/view/OlaCachedImageView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->P:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v0, v0, v2

    :goto_3
    invoke-virtual {v0, v4}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    return-void

    :pswitch_1
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->P:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v0, v0, v3

    if-eqz v0, :cond_4

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->P:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v0, v0, v3

    invoke-virtual {v0, v3}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    :cond_4
    invoke-direct {p0}, Lchat/ola/vn/entry/b/ab;->w()V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->P:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v0, v0, v1

    invoke-virtual {v0, v5, v5}, Lchat/ola/vn/view/OlaCachedImageView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->P:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v0, v0, v1

    invoke-virtual {v0, v4}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->P:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v0, v0, v2

    invoke-virtual {v0, v5, v5}, Lchat/ola/vn/view/OlaCachedImageView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->P:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v0, v0, v2

    goto :goto_3

    :goto_4
    aget-object v0, v0, v3

    invoke-virtual {v0, v3}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->P:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v0, v0, v1

    invoke-virtual {v0, v3}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->P:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v0, v0, v2

    invoke-virtual {v0, v3}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    invoke-direct {p0}, Lchat/ola/vn/entry/b/ab;->w()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :cond_5
    :pswitch_2
    invoke-direct {p0}, Lchat/ola/vn/entry/b/ab;->u()V

    :catch_0
    :cond_6
    return-void

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private u()V
    .locals 5

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->P:[Lchat/ola/vn/view/OlaCachedImageView;

    const/4 v1, 0x0

    aget-object v0, v0, v1

    const/4 v2, 0x0

    invoke-virtual {v0, v2, v2}, Lchat/ola/vn/view/OlaCachedImageView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->P:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v0, v0, v1

    const/16 v3, 0x8

    invoke-virtual {v0, v3}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->P:[Lchat/ola/vn/view/OlaCachedImageView;

    const/4 v4, 0x1

    aget-object v0, v0, v4

    invoke-virtual {v0, v2, v2}, Lchat/ola/vn/view/OlaCachedImageView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->P:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v0, v0, v4

    invoke-virtual {v0, v3}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->P:[Lchat/ola/vn/view/OlaCachedImageView;

    const/4 v4, 0x2

    aget-object v0, v0, v4

    invoke-virtual {v0, v2, v2}, Lchat/ola/vn/view/OlaCachedImageView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->P:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v0, v0, v4

    invoke-virtual {v0, v3}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->f()I

    move-result v0

    if-lez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->q:Landroid/widget/TextView;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->q:Landroid/widget/TextView;

    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private v()V
    .locals 8

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    invoke-virtual {v0}, Lchat/ola/vn/entry/b;->h()B

    move-result v0

    const/4 v1, 0x1

    if-eq v0, v1, :cond_3

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    invoke-virtual {v0}, Lchat/ola/vn/entry/b;->h()B

    move-result v0

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->D()I

    move-result v0

    iget-object v2, p0, Lchat/ola/vn/entry/b/ab;->s:Landroid/widget/TextView;

    sget v3, Lchat/ola/vn/f;->A:I

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setTextColor(I)V

    const v2, 0x7f0806af

    const v3, 0x7f0f04c0

    if-lez v0, :cond_2

    iget-object v4, p0, Lchat/ola/vn/entry/b/ab;->s:Landroid/widget/TextView;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {v3}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v3, " ("

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    int-to-long v6, v0

    invoke-static {v6, v7}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v0, ")"

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v4, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->i()S

    move-result v0

    if-ne v0, v1, :cond_1

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->G:Landroid/widget/ImageView;

    const v1, 0x7f0806ae

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->s:Landroid/widget/TextView;

    sget v1, Lchat/ola/vn/f;->y:I

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    return-void

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->G:Landroid/widget/ImageView;

    invoke-virtual {v0, v2}, Landroid/widget/ImageView;->setImageResource(I)V

    return-void

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->G:Landroid/widget/ImageView;

    invoke-virtual {v0, v2}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->s:Landroid/widget/TextView;

    invoke-static {v3}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_3
    return-void
.end method

.method private w()V
    .locals 5

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->P:[Lchat/ola/vn/view/OlaCachedImageView;

    if-eqz v0, :cond_1

    const/4 v0, 0x0

    const/4 v1, 0x0

    :goto_0
    iget-object v2, p0, Lchat/ola/vn/entry/b/ab;->P:[Lchat/ola/vn/view/OlaCachedImageView;

    array-length v2, v2

    if-ge v1, v2, :cond_1

    iget-object v2, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v2, v2, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v2}, Lchat/ola/vn/entity/g;->E()[Ljava/lang/String;

    move-result-object v2

    array-length v2, v2

    if-ge v1, v2, :cond_1

    iget-object v2, p0, Lchat/ola/vn/entry/b/ab;->P:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v2, v2, v1

    if-eqz v2, :cond_0

    iget-object v2, p0, Lchat/ola/vn/entry/b/ab;->P:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v2, v2, v1

    invoke-virtual {v2, v0}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v2

    iget-object v3, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v3, v3, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v3}, Lchat/ola/vn/entity/g;->E()[Ljava/lang/String;

    move-result-object v3

    aget-object v3, v3, v1

    iget-object v4, p0, Lchat/ola/vn/entry/b/ab;->P:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v4, v4, v1

    invoke-virtual {v2, v3, v4}, Lchat/ola/vn/c/t;->f(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_1
    return-void
.end method

.method private x()V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->z:Lchat/ola/vn/view/OlaCachedImageView;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->z:Lchat/ola/vn/view/OlaCachedImageView;

    iget-object v1, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v1, v1, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v1}, Lchat/ola/vn/entity/g;->a()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->a()Ljava/lang/String;

    move-result-object v0

    const-string v1, "#"

    invoke-virtual {v0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v1

    invoke-static {v0}, Lchat/ola/vn/util/m;->k(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iget-object v2, p0, Lchat/ola/vn/entry/b/ab;->z:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v1, v0, v2}, Lchat/ola/vn/c/t;->j(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V

    return-void

    :cond_1
    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/entry/b/ab;->z:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v1, v0, v2}, Lchat/ola/vn/c/t;->g(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_2
    return-void
.end method

.method private y()V
    .locals 4

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->A:Lchat/ola/vn/view/OlaCachedImageView;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->o()S

    move-result v0

    if-gtz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->A:Lchat/ola/vn/view/OlaCachedImageView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1, v1}, Lchat/ola/vn/view/OlaCachedImageView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->A:Lchat/ola/vn/view/OlaCachedImageView;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    return-void

    :cond_0
    iget-object v1, p0, Lchat/ola/vn/entry/b/ab;->A:Lchat/ola/vn/view/OlaCachedImageView;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v3, ""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lchat/ola/vn/view/OlaCachedImageView;->a(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    return-void

    :cond_1
    iget-object v1, p0, Lchat/ola/vn/entry/b/ab;->A:Lchat/ola/vn/view/OlaCachedImageView;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/ab;->A:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-static {}, Lchat/ola/vn/j;->a()Lchat/ola/vn/j;

    move-result-object v2

    invoke-virtual {v2, v0}, Lchat/ola/vn/j;->a(I)Landroid/graphics/Bitmap;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v0, ""

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v2, v0}, Lchat/ola/vn/view/OlaCachedImageView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    :cond_2
    return-void
.end method


# virtual methods
.method public a()V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-direct {p0}, Lchat/ola/vn/entry/b/ab;->h()V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    if-nez v0, :cond_1

    return-void

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->q()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->n:Landroid/widget/TextView;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v2, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v2, v2, Lchat/ola/vn/entry/b;->h:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, " - "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v2, v2, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v2}, Lchat/ola/vn/entity/g;->q()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    :goto_0
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_1

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->n:Landroid/widget/TextView;

    iget-object v1, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v1, v1, Lchat/ola/vn/entry/b;->h:Ljava/lang/String;

    goto :goto_0

    :goto_1
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->n:Landroid/widget/TextView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    invoke-direct {p0}, Lchat/ola/vn/entry/b/ab;->o()V

    invoke-direct {p0}, Lchat/ola/vn/entry/b/ab;->x()V

    invoke-direct {p0}, Lchat/ola/vn/entry/b/ab;->n()V

    invoke-virtual {p0}, Lchat/ola/vn/entry/b/ab;->f()V

    invoke-direct {p0}, Lchat/ola/vn/entry/b/ab;->i()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_2

    :try_start_1
    invoke-direct {p0}, Lchat/ola/vn/entry/b/ab;->t()V

    invoke-direct {p0}, Lchat/ola/vn/entry/b/ab;->v()V

    invoke-direct {p0}, Lchat/ola/vn/entry/b/ab;->l()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_2

    :catch_0
    move-exception v0

    :try_start_2
    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    :goto_2
    :try_start_3
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    invoke-virtual {v0}, Lchat/ola/vn/entry/b;->h()B

    move-result v0

    const/4 v2, 0x1

    if-eq v0, v2, :cond_4

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    invoke-virtual {v0}, Lchat/ola/vn/entry/b;->h()B

    move-result v0

    const/4 v2, 0x2

    if-eq v0, v2, :cond_4

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->k()S

    move-result v0

    const/16 v2, 0xb

    if-ne v0, v2, :cond_3

    goto :goto_4

    :cond_3
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->t:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->u:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    :goto_3
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->C:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    goto :goto_5

    :cond_4
    :goto_4
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->t:Landroid/view/View;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->u:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_1

    goto :goto_3

    :catch_1
    :goto_5
    :try_start_4
    invoke-direct {p0}, Lchat/ola/vn/entry/b/ab;->m()V

    invoke-direct {p0}, Lchat/ola/vn/entry/b/ab;->q()V

    invoke-direct {p0}, Lchat/ola/vn/entry/b/ab;->r()V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_2

    return-void

    :catch_2
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public a(I)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->d:Landroid/view/View;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->d:Landroid/view/View;

    invoke-virtual {v0, p1}, Landroid/view/View;->setBackgroundResource(I)V

    :cond_0
    return-void
.end method

.method public a(IIII)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->c:Landroid/view/View;

    invoke-virtual {v0, p1, p2, p3, p4}, Landroid/view/View;->setPadding(IIII)V

    return-void
.end method

.method public a(Landroid/view/View;)V
    .locals 0

    invoke-super {p0, p1}, Lchat/ola/vn/entry/b/j;->a(Landroid/view/View;)V

    return-void
.end method

.method public a(Landroid/view/View;[Ljava/lang/String;Ljava/lang/String;)V
    .locals 5

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->V:Landroid/view/View;

    if-nez v0, :cond_0

    const v0, 0x7f09033b

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/view/ViewStub;

    invoke-virtual {v0}, Landroid/view/ViewStub;->inflate()Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/entry/b/ab;->V:Landroid/view/View;

    :cond_0
    const v0, 0x7f0905e6

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/entry/b/ab;->v:Landroid/view/View;

    const v0, 0x7f0904aa

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaGalleryView;

    iput-object v0, p0, Lchat/ola/vn/entry/b/ab;->w:Lchat/ola/vn/view/OlaGalleryView;

    const v0, 0x7f0904ab

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/entry/b/ab;->y:Landroid/widget/TextView;

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->y:Landroid/widget/TextView;

    invoke-virtual {p1}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v1

    const v2, 0x7f0f056c

    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    aput-object p3, v3, v4

    invoke-virtual {v1, v2, v3}, Landroid/content/Context;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p3

    invoke-virtual {v0, p3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    new-instance p3, Lchat/ola/vn/b/al;

    invoke-virtual {p1}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object p1

    invoke-direct {p3, p1}, Lchat/ola/vn/b/al;-><init>(Landroid/content/Context;)V

    iput-object p3, p0, Lchat/ola/vn/entry/b/ab;->x:Lchat/ola/vn/b/al;

    iget-object p1, p0, Lchat/ola/vn/entry/b/ab;->w:Lchat/ola/vn/view/OlaGalleryView;

    iget-object p3, p0, Lchat/ola/vn/entry/b/ab;->x:Lchat/ola/vn/b/al;

    invoke-virtual {p1, p3}, Lchat/ola/vn/view/OlaGalleryView;->setAdapter(Landroid/widget/ListAdapter;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/ab;->x:Lchat/ola/vn/b/al;

    invoke-virtual {p1, p2}, Lchat/ola/vn/b/al;->a([Ljava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/ab;->V:Landroid/view/View;

    invoke-virtual {p1, v4}, Landroid/view/View;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
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

.method public a(Lchat/ola/vn/entity/o;)V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->z()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1}, Lchat/ola/vn/entity/o;->a()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    iput-object p1, v0, Lchat/ola/vn/entity/g;->e:Lchat/ola/vn/entity/o;

    invoke-direct {p0}, Lchat/ola/vn/entry/b/ab;->i()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_0
    return-void
.end method

.method public a(Lchat/ola/vn/entity/y;)V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    iget-object v0, v0, Lchat/ola/vn/entity/g;->e:Lchat/ola/vn/entity/o;

    invoke-virtual {v0}, Lchat/ola/vn/entity/o;->d()Lchat/ola/vn/entity/OlaVenueEntity;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/entity/OlaVenueEntity;->b()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1}, Lchat/ola/vn/entity/y;->a()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    iput-object p1, p0, Lchat/ola/vn/entry/b/ab;->Z:Lchat/ola/vn/entity/y;

    invoke-direct {p0}, Lchat/ola/vn/entry/b/ab;->j()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public a(Ljava/util/List;J)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/g;",
            ">;J)V"
        }
    .end annotation

    return-void
.end method

.method public a(SLjava/lang/String;)V
    .locals 0

    return-void
.end method

.method public a(Z)V
    .locals 1

    invoke-super {p0, p1}, Lchat/ola/vn/entry/b/j;->a(Z)V

    iput-boolean p1, p0, Lchat/ola/vn/entry/b/ab;->L:Z

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/entry/b/ab;->o:Landroid/widget/TextView;

    const/4 v0, 0x0

    :goto_0
    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/entry/b/ab;->o:Landroid/widget/TextView;

    const/16 v0, 0x8

    goto :goto_0

    return-void
.end method

.method public b()V
    .locals 4

    :try_start_0
    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    invoke-virtual {v1}, Lchat/ola/vn/entry/b;->c()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    const/16 v1, 0x8

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->aa:Landroid/widget/ImageView;

    :goto_0
    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setVisibility(I)V

    return-void

    :cond_0
    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-object v2, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    invoke-virtual {v2}, Lchat/ola/vn/entry/b;->c()Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x0

    invoke-virtual {v0, v2, v3}, Lchat/ola/vn/message/g;->e(Ljava/lang/String;S)Lchat/ola/vn/message/f;

    move-result-object v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->aa:Landroid/widget/ImageView;

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->aa:Landroid/widget/ImageView;

    invoke-virtual {v0, v3}, Landroid/widget/ImageView;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public b(Lchat/ola/vn/entity/OlaVenueEntity;)V
    .locals 0

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

.method public d()Landroid/content/Context;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->c:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v0

    return-object v0
.end method

.method public e()V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->V:Landroid/view/View;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->V:Landroid/view/View;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    :cond_0
    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/entry/b/ab;->v:Landroid/view/View;

    iput-object v0, p0, Lchat/ola/vn/entry/b/ab;->w:Lchat/ola/vn/view/OlaGalleryView;

    iput-object v0, p0, Lchat/ola/vn/entry/b/ab;->x:Lchat/ola/vn/b/al;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public f()V
    .locals 10

    const/16 v0, 0x8

    const/4 v1, 0x0

    :try_start_0
    iget-object v2, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    if-nez v2, :cond_0

    return-void

    :cond_0
    iget-object v2, p0, Lchat/ola/vn/entry/b/ab;->a:Landroid/view/View$OnClickListener;

    if-eqz v2, :cond_1

    new-instance v2, Lchat/ola/vn/entry/b/ab$5;

    invoke-direct {v2, p0}, Lchat/ola/vn/entry/b/ab$5;-><init>(Lchat/ola/vn/entry/b/ab;)V

    const/4 v3, 0x0

    :goto_0
    iget-object v4, p0, Lchat/ola/vn/entry/b/ab;->O:[Lchat/ola/vn/view/OlaCachedImageView;

    array-length v4, v4

    if-ge v3, v4, :cond_1

    iget-object v4, p0, Lchat/ola/vn/entry/b/ab;->O:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v4, v4, v3

    invoke-virtual {v4, v2}, Lchat/ola/vn/view/OlaCachedImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :cond_1
    iget-object v2, p0, Lchat/ola/vn/entry/b/ab;->e:Landroid/view/View$OnLongClickListener;

    if-eqz v2, :cond_2

    new-instance v2, Lchat/ola/vn/entry/b/ab$6;

    invoke-direct {v2, p0}, Lchat/ola/vn/entry/b/ab$6;-><init>(Lchat/ola/vn/entry/b/ab;)V

    const/4 v3, 0x0

    :goto_1
    iget-object v4, p0, Lchat/ola/vn/entry/b/ab;->O:[Lchat/ola/vn/view/OlaCachedImageView;

    array-length v4, v4

    if-ge v3, v4, :cond_2

    iget-object v4, p0, Lchat/ola/vn/entry/b/ab;->O:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v4, v4, v3

    invoke-virtual {v4, v2}, Lchat/ola/vn/view/OlaCachedImageView;->setOnLongClickListener(Landroid/view/View$OnLongClickListener;)V

    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    :cond_2
    const/4 v2, 0x0

    :goto_2
    iget-object v3, p0, Lchat/ola/vn/entry/b/ab;->O:[Lchat/ola/vn/view/OlaCachedImageView;

    array-length v3, v3

    if-ge v2, v3, :cond_3

    iget-object v3, p0, Lchat/ola/vn/entry/b/ab;->O:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v3, v3, v2

    invoke-virtual {v3, v0}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    add-int/lit8 v2, v2, 0x1

    goto :goto_2

    :cond_3
    iget-object v2, p0, Lchat/ola/vn/entry/b/ab;->N:Landroid/view/View;

    invoke-virtual {v2, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object v2, p0, Lchat/ola/vn/entry/b/ab;->M:Landroid/widget/TextView;

    invoke-virtual {v2, v0}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v2, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v2, v2, Lchat/ola/vn/entry/b;->i:Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v2

    if-lez v2, :cond_12

    const/4 v3, 0x5

    if-le v2, v3, :cond_5

    iget-object v4, p0, Lchat/ola/vn/entry/b/ab;->N:Landroid/view/View;

    if-eqz v4, :cond_4

    iget-object v4, p0, Lchat/ola/vn/entry/b/ab;->N:Landroid/view/View;

    invoke-virtual {v4, v1}, Landroid/view/View;->setVisibility(I)V

    :cond_4
    iget-object v4, p0, Lchat/ola/vn/entry/b/ab;->M:Landroid/widget/TextView;

    invoke-virtual {v4, v1}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v4, p0, Lchat/ola/vn/entry/b/ab;->M:Landroid/widget/TextView;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "+"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    add-int/lit8 v6, v2, -0x5

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_3

    :cond_5
    if-ne v2, v3, :cond_6

    iget-object v4, p0, Lchat/ola/vn/entry/b/ab;->N:Landroid/view/View;

    if-eqz v4, :cond_7

    iget-object v4, p0, Lchat/ola/vn/entry/b/ab;->N:Landroid/view/View;

    invoke-virtual {v4, v1}, Landroid/view/View;->setVisibility(I)V

    goto :goto_3

    :cond_6
    iget-object v4, p0, Lchat/ola/vn/entry/b/ab;->M:Landroid/widget/TextView;

    invoke-virtual {v4, v0}, Landroid/widget/TextView;->setVisibility(I)V

    :cond_7
    :goto_3
    const/4 v4, 0x0

    :goto_4
    iget-object v5, p0, Lchat/ola/vn/entry/b/ab;->O:[Lchat/ola/vn/view/OlaCachedImageView;

    array-length v5, v5

    if-ge v4, v5, :cond_12

    if-ge v4, v2, :cond_12

    iget-object v5, p0, Lchat/ola/vn/entry/b/ab;->O:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v5, v5, v4

    invoke-virtual {v5, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    iget-object v5, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v5, v5, Lchat/ola/vn/entry/b;->i:Ljava/util/List;

    invoke-interface {v5, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v6

    iget-object v7, p0, Lchat/ola/vn/entry/b/ab;->O:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v7, v7, v4

    iget v8, p0, Lchat/ola/vn/entry/b/ab;->g:I

    invoke-virtual {v6, v5, v7, v8}, Lchat/ola/vn/c/t;->b(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;I)V

    const/4 v5, 0x2

    const-wide/high16 v6, 0x3ff0000000000000L    # 1.0

    const/4 v8, 0x1

    if-eq v2, v3, :cond_d

    packed-switch v2, :pswitch_data_0

    if-nez v4, :cond_8

    iget-object v9, p0, Lchat/ola/vn/entry/b/ab;->O:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v9, v9, v1

    check-cast v9, Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v9, v6, v7}, Lchat/ola/vn/view/OlaRatioImageView;->setRatio(D)V

    :cond_8
    if-ne v4, v8, :cond_9

    iget-object v9, p0, Lchat/ola/vn/entry/b/ab;->O:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v8, v9, v8

    check-cast v8, Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v8, v6, v7}, Lchat/ola/vn/view/OlaRatioImageView;->setRatio(D)V

    :cond_9
    if-ne v4, v5, :cond_10

    iget-object v8, p0, Lchat/ola/vn/entry/b/ab;->O:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v5, v8, v5

    :goto_5
    check-cast v5, Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v5, v6, v7}, Lchat/ola/vn/view/OlaRatioImageView;->setRatio(D)V

    goto :goto_6

    :pswitch_0
    if-nez v4, :cond_a

    iget-object v9, p0, Lchat/ola/vn/entry/b/ab;->O:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v9, v9, v1

    check-cast v9, Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v9, v6, v7}, Lchat/ola/vn/view/OlaRatioImageView;->setRatio(D)V

    :cond_a
    if-ne v4, v8, :cond_b

    iget-object v9, p0, Lchat/ola/vn/entry/b/ab;->O:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v8, v9, v8

    check-cast v8, Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v8, v6, v7}, Lchat/ola/vn/view/OlaRatioImageView;->setRatio(D)V

    :cond_b
    if-ne v4, v5, :cond_10

    iget-object v6, p0, Lchat/ola/vn/entry/b/ab;->O:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v5, v6, v5

    check-cast v5, Lchat/ola/vn/view/OlaRatioImageView;

    const-wide v6, 0x3ffc71c71c71c71cL    # 1.7777777777777777

    invoke-virtual {v5, v6, v7}, Lchat/ola/vn/view/OlaRatioImageView;->setRatio(D)V

    goto :goto_6

    :pswitch_1
    const-wide/high16 v5, 0x3fe2000000000000L    # 0.5625

    if-nez v4, :cond_c

    iget-object v7, p0, Lchat/ola/vn/entry/b/ab;->O:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v7, v7, v1

    check-cast v7, Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v7, v5, v6}, Lchat/ola/vn/view/OlaRatioImageView;->setRatio(D)V

    :cond_c
    if-ne v4, v8, :cond_10

    iget-object v7, p0, Lchat/ola/vn/entry/b/ab;->O:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v7, v7, v8

    check-cast v7, Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v7, v5, v6}, Lchat/ola/vn/view/OlaRatioImageView;->setRatio(D)V

    goto :goto_6

    :cond_d
    if-nez v4, :cond_e

    iget-object v9, p0, Lchat/ola/vn/entry/b/ab;->O:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v9, v9, v1

    check-cast v9, Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v9, v6, v7}, Lchat/ola/vn/view/OlaRatioImageView;->setRatio(D)V

    :cond_e
    if-ne v4, v8, :cond_f

    iget-object v9, p0, Lchat/ola/vn/entry/b/ab;->O:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v8, v9, v8

    check-cast v8, Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v8, v6, v7}, Lchat/ola/vn/view/OlaRatioImageView;->setRatio(D)V

    :cond_f
    if-ne v4, v5, :cond_10

    iget-object v8, p0, Lchat/ola/vn/entry/b/ab;->O:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v5, v8, v5
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_5

    :cond_10
    :goto_6
    :pswitch_2
    add-int/lit8 v4, v4, 0x1

    goto/16 :goto_4

    :catch_0
    :try_start_1
    iget-object v2, p0, Lchat/ola/vn/entry/b/ab;->O:[Lchat/ola/vn/view/OlaCachedImageView;

    if-eqz v2, :cond_12

    iget-object v2, p0, Lchat/ola/vn/entry/b/ab;->N:Landroid/view/View;

    if-eqz v2, :cond_11

    iget-object v2, p0, Lchat/ola/vn/entry/b/ab;->N:Landroid/view/View;

    invoke-virtual {v2, v0}, Landroid/view/View;->setVisibility(I)V

    :cond_11
    :goto_7
    iget-object v2, p0, Lchat/ola/vn/entry/b/ab;->O:[Lchat/ola/vn/view/OlaCachedImageView;

    array-length v2, v2

    if-ge v1, v2, :cond_12

    iget-object v2, p0, Lchat/ola/vn/entry/b/ab;->O:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v2, v2, v1

    invoke-virtual {v2, v0}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    add-int/lit8 v1, v1, 0x1

    goto :goto_7

    :catch_1
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_12
    return-void

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public f(Ljava/lang/String;)V
    .locals 0

    return-void
.end method

.method public g()V
    .locals 5

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->e()J

    move-result-wide v0

    iget-object v2, p0, Lchat/ola/vn/entry/b/ab;->K:Lchat/ola/vn/entry/b/a/b;

    invoke-virtual {v2}, Lchat/ola/vn/entry/b/a/b;->b()Lchat/ola/vn/entry/b;

    move-result-object v2

    iget-object v2, v2, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v2}, Lchat/ola/vn/entity/g;->e()J

    move-result-wide v2
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    cmp-long v4, v0, v2

    if-nez v4, :cond_0

    const/16 v0, 0x8

    :try_start_1
    iget-object v1, p0, Lchat/ola/vn/entry/b/ab;->I:Landroid/view/ViewGroup;

    invoke-virtual {v1}, Landroid/view/ViewGroup;->removeAllViews()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :goto_0
    :try_start_2
    iget-object v1, p0, Lchat/ola/vn/entry/b/ab;->I:Landroid/view/ViewGroup;

    invoke-virtual {v1, v0}, Landroid/view/ViewGroup;->setVisibility(I)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    return-void

    :catchall_0
    move-exception v1

    goto :goto_1

    :catch_0
    move-exception v1

    :try_start_3
    invoke-virtual {v1}, Ljava/lang/Throwable;->printStackTrace()V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    goto :goto_0

    :goto_1
    :try_start_4
    iget-object v2, p0, Lchat/ola/vn/entry/b/ab;->I:Landroid/view/ViewGroup;

    invoke-virtual {v2, v0}, Landroid/view/ViewGroup;->setVisibility(I)V

    throw v1
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_1

    :catch_1
    :cond_0
    return-void
.end method
