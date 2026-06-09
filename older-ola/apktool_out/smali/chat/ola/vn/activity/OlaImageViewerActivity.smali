.class public Lchat/ola/vn/activity/OlaImageViewerActivity;
.super Lchat/ola/vn/c;

# interfaces
.implements Landroid/support/v4/view/ViewPager$OnPageChangeListener;
.implements Landroid/view/View$OnClickListener;
.implements Landroid/view/View$OnLongClickListener;
.implements Lchat/ola/vn/f/a;
.implements Lcom/mg/ola/common/widget/image/viewer/b$f;
.implements Lcom/mg/ola/common/widget/image/viewer/b$g;


# annotations
.annotation build Landroid/annotation/SuppressLint;
    value = {
        "DefaultLocale"
    }
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/activity/OlaImageViewerActivity$b;,
        Lchat/ola/vn/activity/OlaImageViewerActivity$a;
    }
.end annotation


# instance fields
.field private A:Landroid/widget/ImageView;

.field private B:J

.field private C:Ljava/lang/String;

.field private D:I

.field private E:I

.field private F:I

.field private G:S

.field private H:Landroid/view/View;

.field private I:Landroid/view/animation/Animation;

.field private J:Landroid/view/animation/Animation;

.field private K:Landroid/view/animation/Animation;

.field private L:Landroid/view/animation/Animation;

.field private M:Landroid/view/View;

.field private N:Landroid/widget/ImageView;

.field private O:Ljava/lang/String;

.field private P:Ljava/lang/Float;

.field private Q:Ljava/lang/Float;

.field private e:Lcom/mg/ola/common/widget/OlaViewPager;

.field private f:Landroid/view/View;

.field private g:Landroid/view/animation/Animation;

.field private h:Landroid/view/animation/Animation;

.field private i:Landroid/support/v4/view/PagerAdapter;

.field private j:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Lchat/ola/vn/mediastore/OlaMediaEntity;",
            ">;"
        }
    .end annotation
.end field

.field private k:Z

.field private l:Landroid/view/View;

.field private o:Landroid/view/View;

.field private p:Landroid/widget/TextView;

.field private q:Landroid/graphics/Rect;

.field private r:Landroid/graphics/Rect;

.field private s:J

.field private t:Lcom/mg/ola/a/a/b/c;

.field private u:Landroid/widget/FrameLayout;

.field private v:Landroid/widget/TextView;

.field private w:Landroid/widget/TextView;

.field private x:Landroid/widget/TextView;

.field private y:Landroid/widget/TextView;

.field private z:Landroid/widget/ImageView;


# direct methods
.method public constructor <init>()V
    .locals 2

    invoke-direct {p0}, Lchat/ola/vn/c;-><init>()V

    const/4 v0, 0x1

    iput-boolean v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->k:Z

    const-wide/16 v0, 0xc8

    iput-wide v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->s:J

    return-void
.end method

.method private B()V
    .locals 5
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "NewApi"
        }
    .end annotation

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    const-string v1, "extra_src_animation_rect"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->getParcelableExtra(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object v0

    check-cast v0, Landroid/graphics/Rect;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->q:Landroid/graphics/Rect;

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    const-string v1, "extra_target_animation_rect"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->getParcelableExtra(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object v0

    check-cast v0, Landroid/graphics/Rect;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->r:Landroid/graphics/Rect;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->q:Landroid/graphics/Rect;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->r:Landroid/graphics/Rect;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->q:Landroid/graphics/Rect;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->r:Landroid/graphics/Rect;

    invoke-direct {p0, v0, v1}, Lchat/ola/vn/activity/OlaImageViewerActivity;->b(Landroid/graphics/Rect;Landroid/graphics/Rect;)V

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->e:Lcom/mg/ola/common/widget/OlaViewPager;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/mg/ola/common/widget/OlaViewPager;->setVisibility(I)V

    const/4 v0, 0x2

    new-array v2, v0, [Landroid/graphics/drawable/ColorDrawable;

    new-instance v3, Landroid/graphics/drawable/ColorDrawable;

    invoke-direct {v3, v1}, Landroid/graphics/drawable/ColorDrawable;-><init>(I)V

    aput-object v3, v2, v1

    const/4 v1, 0x1

    new-instance v3, Landroid/graphics/drawable/ColorDrawable;

    const/high16 v4, -0x1000000

    invoke-direct {v3, v4}, Landroid/graphics/drawable/ColorDrawable;-><init>(I)V

    aput-object v3, v2, v1

    new-instance v1, Landroid/graphics/drawable/TransitionDrawable;

    invoke-direct {v1, v2}, Landroid/graphics/drawable/TransitionDrawable;-><init>([Landroid/graphics/drawable/Drawable;)V

    invoke-static {}, Lcom/mg/ola/common/d/g;->g()Z

    move-result v2

    if-eqz v2, :cond_1

    iget-object v2, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->u:Landroid/widget/FrameLayout;

    invoke-virtual {v2, v1}, Landroid/widget/FrameLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    goto :goto_0

    :cond_1
    iget-object v2, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->u:Landroid/widget/FrameLayout;

    invoke-virtual {v2, v1}, Landroid/widget/FrameLayout;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    :goto_0
    iget-wide v2, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->s:J

    long-to-int v2, v2

    div-int/2addr v2, v0

    invoke-virtual {v1, v2}, Landroid/graphics/drawable/TransitionDrawable;->startTransition(I)V

    return-void
.end method

.method private C()V
    .locals 3

    const v0, 0x7f090242

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/FrameLayout;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->u:Landroid/widget/FrameLayout;

    const v0, 0x7f090306

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->f:Landroid/view/View;

    const v0, 0x7f0903b1

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lcom/mg/ola/common/widget/OlaViewPager;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->e:Lcom/mg/ola/common/widget/OlaViewPager;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->e:Lcom/mg/ola/common/widget/OlaViewPager;

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const v2, 0x7f070125

    invoke-virtual {v1, v2}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/mg/ola/common/widget/OlaViewPager;->setPageMargin(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->e:Lcom/mg/ola/common/widget/OlaViewPager;

    new-instance v1, Lchat/ola/vn/view/k;

    invoke-direct {v1}, Lchat/ola/vn/view/k;-><init>()V

    const/4 v2, 0x1

    invoke-virtual {v0, v2, v1}, Lcom/mg/ola/common/widget/OlaViewPager;->setPageTransformer(ZLandroid/support/v4/view/ViewPager$PageTransformer;)V

    const v0, 0x7f0903af

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->p:Landroid/widget/TextView;

    const v0, 0x7f090362

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->l:Landroid/view/View;

    const v0, 0x7f090119

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->o:Landroid/view/View;

    const v0, 0x7f0900d3

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->M:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->M:Landroid/view/View;

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->l:Landroid/view/View;

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->o:Landroid/view/View;

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f0902fa

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->H:Landroid/view/View;

    const v0, 0x7f0901eb

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->w:Landroid/widget/TextView;

    const v0, 0x7f090525

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->v:Landroid/widget/TextView;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->v:Landroid/widget/TextView;

    invoke-virtual {v0, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f0902d5

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f0901ec

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f09027f

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->z:Landroid/widget/ImageView;

    const v0, 0x7f0902d4

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->y:Landroid/widget/TextView;

    const v0, 0x7f09027e

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->A:Landroid/widget/ImageView;

    const v0, 0x7f090524

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->x:Landroid/widget/TextView;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->x:Landroid/widget/TextView;

    invoke-virtual {v0, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f090280

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->N:Landroid/widget/ImageView;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->N:Landroid/widget/ImageView;

    invoke-virtual {v0, p0}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    return-void
.end method

.method private D()V
    .locals 8

    iget-wide v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->B:J

    const-wide/16 v2, 0x0

    cmp-long v4, v0, v2

    const/16 v0, 0x8

    if-eqz v4, :cond_7

    iget-object v1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->H:Landroid/view/View;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Landroid/view/View;->setVisibility(I)V

    iget-short v1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->G:S

    const/4 v3, 0x1

    if-ne v1, v3, :cond_0

    iget-object v1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->z:Landroid/widget/ImageView;

    const v4, 0x7f080701

    invoke-virtual {v1, v4}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object v1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->y:Landroid/widget/TextView;

    sget v4, Lchat/ola/vn/f;->H:I

    :goto_0
    invoke-virtual {v1, v4}, Landroid/widget/TextView;->setTextColor(I)V

    goto :goto_1

    :cond_0
    iget-object v1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->z:Landroid/widget/ImageView;

    const v4, 0x7f080702

    invoke-virtual {v1, v4}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object v1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->y:Landroid/widget/TextView;

    sget v4, Lchat/ola/vn/f;->g:I

    goto :goto_0

    :goto_1
    iget-short v1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->G:S

    const/4 v4, 0x2

    if-ne v1, v4, :cond_1

    iget-object v1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->A:Landroid/widget/ImageView;

    const v4, 0x7f0806b0

    invoke-virtual {v1, v4}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object v1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->w:Landroid/widget/TextView;

    sget v4, Lchat/ola/vn/f;->H:I

    :goto_2
    invoke-virtual {v1, v4}, Landroid/widget/TextView;->setTextColor(I)V

    goto :goto_3

    :cond_1
    iget-object v1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->A:Landroid/widget/ImageView;

    const v4, 0x7f0806b1

    invoke-virtual {v1, v4}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object v1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->w:Landroid/widget/TextView;

    sget v4, Lchat/ola/vn/f;->g:I

    goto :goto_2

    :goto_3
    iget v1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->E:I

    if-nez v1, :cond_2

    iget-object v1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->v:Landroid/widget/TextView;

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    goto :goto_5

    :cond_2
    iget-object v1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->v:Landroid/widget/TextView;

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setVisibility(I)V

    iget v1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->E:I

    if-le v1, v3, :cond_3

    iget-object v1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->v:Landroid/widget/TextView;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    iget v5, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->E:I

    int-to-long v5, v5

    invoke-static {v5, v6}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v5, " "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v5, 0x7f0f0538

    :goto_4
    invoke-virtual {p0, v5}, Lchat/ola/vn/activity/OlaImageViewerActivity;->getString(I)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_5

    :cond_3
    iget-object v1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->v:Landroid/widget/TextView;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    iget v5, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->E:I

    int-to-long v5, v5

    invoke-static {v5, v6}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v5, " "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v5, 0x7f0f0539

    goto :goto_4

    :goto_5
    iget v1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->F:I

    const v4, 0x7f0f04c0

    if-nez v1, :cond_4

    iget-object v1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->w:Landroid/widget/TextView;

    invoke-virtual {v1, v4}, Landroid/widget/TextView;->setText(I)V

    goto :goto_6

    :cond_4
    iget-object v1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->w:Landroid/widget/TextView;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0, v4}, Lchat/ola/vn/activity/OlaImageViewerActivity;->getString(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v4, " ("

    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v4, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->F:I

    int-to-long v6, v4

    invoke-static {v6, v7}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v4, ")"

    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :goto_6
    iget v1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->D:I

    if-nez v1, :cond_5

    iget-object v1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->x:Landroid/widget/TextView;

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    return-void

    :cond_5
    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->x:Landroid/widget/TextView;

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setVisibility(I)V

    iget v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->D:I

    if-le v0, v3, :cond_6

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->x:Landroid/widget/TextView;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget v2, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->D:I

    int-to-long v2, v2

    invoke-static {v2, v3}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, " "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v2, 0x7f0f0487

    :goto_7
    invoke-virtual {p0, v2}, Lchat/ola/vn/activity/OlaImageViewerActivity;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_6
    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->x:Landroid/widget/TextView;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget v2, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->D:I

    int-to-long v2, v2

    invoke-static {v2, v3}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, " "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v2, 0x7f0f0486

    goto :goto_7

    :cond_7
    iget-object v1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->H:Landroid/view/View;

    invoke-virtual {v1, v0}, Landroid/view/View;->setVisibility(I)V

    return-void
.end method

.method private E()I
    .locals 7

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    const/4 v1, 0x0

    if-nez v0, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->finish()V

    return v1

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    const-string v2, "extra_media_entry_array_list"

    invoke-virtual {v0, v2}, Landroid/content/Intent;->getParcelableArrayListExtra(Ljava/lang/String;)Ljava/util/ArrayList;

    move-result-object v0

    if-eqz v0, :cond_2

    invoke-virtual {v0}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_2

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_1
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_2

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/mediastore/OlaMediaEntity;

    if-eqz v2, :cond_1

    iget-object v3, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->j:Ljava/util/ArrayList;

    invoke-virtual {v3, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->j:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_3

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->finish()V

    return v1

    :cond_3
    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    const-string v2, "_me_id"

    const-wide/16 v3, 0x0

    invoke-virtual {v0, v2, v3, v4}, Landroid/content/Intent;->getLongExtra(Ljava/lang/String;J)J

    move-result-wide v5

    iput-wide v5, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->B:J

    iget-wide v5, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->B:J

    cmp-long v0, v5, v3

    if-eqz v0, :cond_4

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    const-string v2, "_sender"

    invoke-virtual {v0, v2}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->O:Ljava/lang/String;

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    const-string v2, "me_message"

    invoke-virtual {v0, v2}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->C:Ljava/lang/String;

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    const-string v2, "me_comment_count"

    invoke-virtual {v0, v2, v1}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v0

    iput v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->D:I

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    const-string v2, "me_like_count"

    invoke-virtual {v0, v2, v1}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v0

    iput v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->E:I

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    const-string v2, "me_dislike_count"

    invoke-virtual {v0, v2, v1}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v0

    iput v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->F:I

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    const-string v2, "me_like_state"

    invoke-virtual {v0, v2, v1}, Landroid/content/Intent;->getShortExtra(Ljava/lang/String;S)S

    move-result v0

    iput-short v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->G:S

    :cond_4
    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    const-string v2, "_index"

    invoke-virtual {v0, v2, v1}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v0

    invoke-static {v1, v0}, Ljava/lang/Math;->max(II)I

    move-result v0

    iget-object v2, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->j:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    const/4 v3, 0x1

    if-ne v2, v3, :cond_5

    iget-object v2, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->p:Landroid/widget/TextView;

    const/16 v4, 0x8

    invoke-virtual {v2, v4}, Landroid/widget/TextView;->setVisibility(I)V

    goto :goto_1

    :cond_5
    iget-object v2, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->p:Landroid/widget/TextView;

    invoke-virtual {v2, v1}, Landroid/widget/TextView;->setVisibility(I)V

    :goto_1
    iget-object v2, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->p:Landroid/widget/TextView;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    add-int/lit8 v5, v0, 0x1

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v5, "/"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v5, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->j:Ljava/util/ArrayList;

    invoke-virtual {v5}, Ljava/util/ArrayList;->size()I

    move-result v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v2, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->j:Ljava/util/ArrayList;

    invoke-virtual {v2, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/mediastore/OlaMediaEntity;

    invoke-virtual {v2}, Lchat/ola/vn/mediastore/OlaMediaEntity;->a()I

    move-result v2

    const/4 v4, 0x4

    if-ne v2, v3, :cond_6

    iget-object v2, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->M:Landroid/view/View;

    invoke-virtual {v2, v1}, Landroid/view/View;->setVisibility(I)V

    goto :goto_2

    :cond_6
    iget-object v1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->M:Landroid/view/View;

    invoke-virtual {v1, v4}, Landroid/view/View;->setVisibility(I)V

    :goto_2
    iget-object v1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->e:Lcom/mg/ola/common/widget/OlaViewPager;

    invoke-virtual {v1, v4}, Lcom/mg/ola/common/widget/OlaViewPager;->setVisibility(I)V

    iget-object v1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->e:Lcom/mg/ola/common/widget/OlaViewPager;

    new-instance v2, Lchat/ola/vn/activity/OlaImageViewerActivity$2;

    invoke-direct {v2, p0}, Lchat/ola/vn/activity/OlaImageViewerActivity$2;-><init>(Lchat/ola/vn/activity/OlaImageViewerActivity;)V

    invoke-virtual {v1, v2}, Lcom/mg/ola/common/widget/OlaViewPager;->post(Ljava/lang/Runnable;)Z

    return v0
.end method

.method private F()Lchat/ola/vn/activity/OlaImageViewerActivity$b;
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->e:Lcom/mg/ola/common/widget/OlaViewPager;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "page_"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->e:Lcom/mg/ola/common/widget/OlaViewPager;

    invoke-virtual {v2}, Lcom/mg/ola/common/widget/OlaViewPager;->getCurrentItem()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mg/ola/common/widget/OlaViewPager;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    new-instance v2, Lchat/ola/vn/activity/OlaImageViewerActivity$b;

    invoke-direct {v2, p0, v0, v1}, Lchat/ola/vn/activity/OlaImageViewerActivity$b;-><init>(Lchat/ola/vn/activity/OlaImageViewerActivity;Landroid/view/View;Lchat/ola/vn/activity/OlaImageViewerActivity$1;)V

    return-object v2

    :cond_0
    return-object v1
.end method

.method private static a(Landroid/graphics/Rect;FF)Landroid/graphics/Rect;
    .locals 2

    div-float/2addr p1, p2

    invoke-virtual {p0}, Landroid/graphics/Rect;->width()I

    move-result p2

    int-to-float p2, p2

    invoke-virtual {p0}, Landroid/graphics/Rect;->height()I

    move-result v0

    int-to-float v0, v0

    div-float/2addr p2, v0

    cmpl-float p2, p2, p1

    if-lez p2, :cond_0

    invoke-virtual {p0}, Landroid/graphics/Rect;->width()I

    move-result p2

    int-to-float p2, p2

    invoke-virtual {p0}, Landroid/graphics/Rect;->width()I

    move-result v0

    int-to-float v0, v0

    div-float/2addr v0, p1

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Landroid/graphics/Rect;->height()I

    move-result p2

    int-to-float p2, p2

    mul-float p2, p2, p1

    invoke-virtual {p0}, Landroid/graphics/Rect;->height()I

    move-result p1

    int-to-float v0, p1

    :goto_0
    new-instance p1, Landroid/graphics/Rect;

    float-to-int p2, p2

    float-to-int v0, v0

    const/4 v1, 0x0

    invoke-direct {p1, v1, v1, p2, v0}, Landroid/graphics/Rect;-><init>(IIII)V

    invoke-virtual {p0}, Landroid/graphics/Rect;->centerX()I

    move-result p2

    invoke-virtual {p1}, Landroid/graphics/Rect;->centerX()I

    move-result v0

    sub-int/2addr p2, v0

    invoke-virtual {p0}, Landroid/graphics/Rect;->centerY()I

    move-result p0

    invoke-virtual {p1}, Landroid/graphics/Rect;->centerY()I

    move-result v0

    sub-int/2addr p0, v0

    invoke-virtual {p1, p2, p0}, Landroid/graphics/Rect;->offset(II)V

    return-object p1
.end method

.method private static a(Landroid/graphics/Rect;Landroid/graphics/Rect;)Landroid/graphics/Rect;
    .locals 3

    invoke-virtual {p0}, Landroid/graphics/Rect;->width()I

    move-result v0

    int-to-float v0, v0

    invoke-virtual {p0}, Landroid/graphics/Rect;->height()I

    move-result v1

    int-to-float v1, v1

    div-float/2addr v0, v1

    invoke-virtual {p1}, Landroid/graphics/Rect;->width()I

    move-result v1

    int-to-float v1, v1

    invoke-virtual {p1}, Landroid/graphics/Rect;->height()I

    move-result p1

    int-to-float p1, p1

    div-float/2addr v1, p1

    cmpl-float p1, v0, v1

    if-lez p1, :cond_0

    invoke-virtual {p0}, Landroid/graphics/Rect;->width()I

    move-result p1

    int-to-float p1, p1

    invoke-virtual {p0}, Landroid/graphics/Rect;->width()I

    move-result v0

    int-to-float v0, v0

    div-float/2addr v0, v1

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Landroid/graphics/Rect;->height()I

    move-result p1

    int-to-float p1, p1

    mul-float p1, p1, v1

    invoke-virtual {p0}, Landroid/graphics/Rect;->height()I

    move-result v0

    int-to-float v0, v0

    :goto_0
    new-instance v1, Landroid/graphics/Rect;

    float-to-int p1, p1

    float-to-int v0, v0

    const/4 v2, 0x0

    invoke-direct {v1, v2, v2, p1, v0}, Landroid/graphics/Rect;-><init>(IIII)V

    invoke-virtual {p0}, Landroid/graphics/Rect;->centerX()I

    move-result p1

    invoke-virtual {v1}, Landroid/graphics/Rect;->centerX()I

    move-result v0

    sub-int/2addr p1, v0

    invoke-virtual {p0}, Landroid/graphics/Rect;->centerY()I

    move-result p0

    invoke-virtual {v1}, Landroid/graphics/Rect;->centerY()I

    move-result v0

    sub-int/2addr p0, v0

    invoke-virtual {v1, p1, p0}, Landroid/graphics/Rect;->offset(II)V

    return-object v1
.end method

.method static synthetic a(Lchat/ola/vn/activity/OlaImageViewerActivity;Lcom/mg/ola/a/a/b/c;)Lcom/mg/ola/a/a/b/c;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->t:Lcom/mg/ola/a/a/b/c;

    return-object p1
.end method

.method private a(JLjava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 6

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "@"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {p4, v0}, Lchat/ola/vn/util/i;->b(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v0, " "

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {p4}, Lchat/ola/vn/util/i;->a(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object p4

    invoke-virtual {v1, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p4

    :goto_0
    move-object v2, p4

    goto :goto_1

    :cond_0
    invoke-static {p4}, Lchat/ola/vn/util/i;->a(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object p4

    goto :goto_0

    :goto_1
    new-instance p4, Ljava/lang/StringBuilder;

    invoke-direct {p4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "@"

    invoke-virtual {p4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p4, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    move-object v0, p0

    move-object v3, p5

    move-wide v4, p1

    invoke-static/range {v0 .. v5}, Lchat/ola/vn/me/OlaMeComposerActivity;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;J)V

    return-void
.end method

.method public static a(Landroid/content/Context;Landroid/view/View;ILchat/ola/vn/entry/b;)V
    .locals 4

    :try_start_0
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.intent.action.VIEW"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    const-class v1, Lchat/ola/vn/activity/OlaImageViewerActivity;

    invoke-virtual {v0, p0, v1}, Landroid/content/Intent;->setClass(Landroid/content/Context;Ljava/lang/Class;)Landroid/content/Intent;

    invoke-virtual {p3}, Lchat/ola/vn/entry/b;->f()Ljava/util/List;

    move-result-object v1

    if-eqz v1, :cond_0

    invoke-interface {v1}, Ljava/util/List;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_0

    const-string v2, "extra_media_entry_array_list"

    invoke-static {v1}, Lchat/ola/vn/mediastore/OlaMediaEntity;->a(Ljava/util/List;)Ljava/util/ArrayList;

    move-result-object v1

    invoke-virtual {v0, v2, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/io/Serializable;)Landroid/content/Intent;

    :cond_0
    const-string v1, "_index"

    invoke-virtual {v0, v1, p2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    if-eqz p3, :cond_1

    const-string p2, "_me_id"

    iget-object v1, p3, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v1}, Lchat/ola/vn/entity/g;->e()J

    move-result-wide v1

    invoke-virtual {v0, p2, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;J)Landroid/content/Intent;

    const-string p2, "_sender"

    iget-object v1, p3, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v1}, Lchat/ola/vn/entity/g;->a()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, p2, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string p2, "me_message"

    iget-object v1, p3, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v1}, Lchat/ola/vn/entity/g;->b()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, p2, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string p2, "me_comment_count"

    iget-object v1, p3, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v1}, Lchat/ola/vn/entity/g;->g()I

    move-result v1

    invoke-virtual {v0, p2, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    const-string p2, "me_like_count"

    iget-object v1, p3, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v1}, Lchat/ola/vn/entity/g;->f()I

    move-result v1

    invoke-virtual {v0, p2, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    const-string p2, "me_dislike_count"

    iget-object v1, p3, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v1}, Lchat/ola/vn/entity/g;->D()I

    move-result v1

    invoke-virtual {v0, p2, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    const-string p2, "me_like_state"

    iget-object p3, p3, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {p3}, Lchat/ola/vn/entity/g;->i()S

    move-result p3

    invoke-virtual {v0, p2, p3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;S)Landroid/content/Intent;

    :cond_1
    const/4 p2, 0x0

    if-eqz p1, :cond_4

    invoke-static {p0}, Lchat/ola/vn/util/n;->a(Landroid/content/Context;)I

    move-result p3

    new-instance v1, Landroid/graphics/Rect;

    sget v2, Lchat/ola/vn/e;->c:I

    sget v3, Lchat/ola/vn/e;->d:I

    invoke-direct {v1, p2, p3, v2, v3}, Landroid/graphics/Rect;-><init>(IIII)V

    new-instance p3, Landroid/graphics/Rect;

    invoke-direct {p3}, Landroid/graphics/Rect;-><init>()V

    invoke-virtual {p1, p3}, Landroid/view/View;->getGlobalVisibleRect(Landroid/graphics/Rect;)Z

    instance-of v2, p1, Landroid/widget/ImageView;

    if-eqz v2, :cond_3

    check-cast p1, Landroid/widget/ImageView;

    invoke-virtual {p1}, Landroid/widget/ImageView;->getDrawable()Landroid/graphics/drawable/Drawable;

    move-result-object p1

    if-eqz p1, :cond_2

    invoke-virtual {p1}, Landroid/graphics/drawable/Drawable;->getIntrinsicWidth()I

    move-result v2

    int-to-float v2, v2

    invoke-virtual {p1}, Landroid/graphics/drawable/Drawable;->getIntrinsicHeight()I

    move-result p1

    int-to-float p1, p1

    invoke-static {p3, v2, p1}, Lchat/ola/vn/activity/OlaImageViewerActivity;->a(Landroid/graphics/Rect;FF)Landroid/graphics/Rect;

    move-result-object p1

    const-string p3, "extra_src_animation_rect"

    invoke-static {p1, v1}, Lchat/ola/vn/activity/OlaImageViewerActivity;->a(Landroid/graphics/Rect;Landroid/graphics/Rect;)Landroid/graphics/Rect;

    move-result-object p1

    invoke-virtual {v0, p3, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Parcelable;)Landroid/content/Intent;

    :goto_0
    const-string p1, "extra_target_animation_rect"

    invoke-virtual {v0, p1, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Parcelable;)Landroid/content/Intent;

    goto :goto_1

    :cond_2
    const-string p1, "extra_src_animation_rect"

    invoke-static {p3, v1}, Lchat/ola/vn/activity/OlaImageViewerActivity;->a(Landroid/graphics/Rect;Landroid/graphics/Rect;)Landroid/graphics/Rect;

    move-result-object p3

    invoke-virtual {v0, p1, p3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Parcelable;)Landroid/content/Intent;

    goto :goto_0

    :cond_3
    const-string p1, "extra_src_animation_rect"

    invoke-static {p3, v1}, Lchat/ola/vn/activity/OlaImageViewerActivity;->a(Landroid/graphics/Rect;Landroid/graphics/Rect;)Landroid/graphics/Rect;

    move-result-object p3

    invoke-virtual {v0, p1, p3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Parcelable;)Landroid/content/Intent;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    goto :goto_0

    :cond_4
    :goto_1
    :try_start_1
    move-object p1, p0

    check-cast p1, Landroid/support/v4/app/FragmentActivity;

    invoke-virtual {p1, v0, p2}, Landroid/support/v4/app/FragmentActivity;->startActivityForResult(Landroid/content/Intent;I)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    return-void

    :catch_0
    :try_start_2
    invoke-virtual {p0, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    return-void
.end method

.method public static a(Landroid/content/Context;Landroid/view/View;Landroid/graphics/Bitmap;ILjava/util/ArrayList;)V
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Landroid/view/View;",
            "Landroid/graphics/Bitmap;",
            "I",
            "Ljava/util/ArrayList<",
            "Lchat/ola/vn/mediastore/OlaMediaEntity;",
            ">;)V"
        }
    .end annotation

    if-eqz p4, :cond_6

    invoke-virtual {p4}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    const/4 v0, 0x0

    invoke-static {v0, p3}, Ljava/lang/Math;->max(II)I

    move-result p3

    invoke-virtual {p4}, Ljava/util/ArrayList;->size()I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    invoke-static {p3, v1}, Ljava/lang/Math;->min(II)I

    move-result p3

    :try_start_0
    invoke-virtual {p4}, Ljava/util/ArrayList;->size()I

    move-result v1

    const/16 v2, 0x2bc

    if-le v1, v2, :cond_2

    add-int/lit16 v2, p3, -0x15e

    invoke-static {v0, v2}, Ljava/lang/Math;->max(II)I

    move-result v2

    add-int/lit16 v3, v2, 0x2bc

    invoke-static {v1, v3}, Ljava/lang/Math;->min(II)I

    move-result v1

    new-instance v3, Ljava/util/ArrayList;

    invoke-virtual {p4, v2, v1}, Ljava/util/ArrayList;->subList(II)Ljava/util/List;

    move-result-object v1

    invoke-direct {v3, v1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    if-nez v2, :cond_1

    goto :goto_0

    :cond_1
    sub-int/2addr p3, v2

    :goto_0
    :try_start_1
    invoke-static {v0, p3}, Ljava/lang/Math;->max(II)I

    move-result p4

    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    invoke-static {p4, v1}, Ljava/lang/Math;->min(II)I

    move-result p4
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    move p3, p4

    move-object p4, v3

    goto :goto_2

    :catch_0
    move-exception p4

    move-object v1, p4

    move-object p4, v3

    goto :goto_1

    :catch_1
    move-exception v1

    :goto_1
    invoke-virtual {v1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_2
    :goto_2
    new-instance v1, Landroid/content/Intent;

    const-string v2, "android.intent.action.VIEW"

    invoke-direct {v1, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    const-class v2, Lchat/ola/vn/activity/OlaImageViewerActivity;

    invoke-virtual {v1, p0, v2}, Landroid/content/Intent;->setClass(Landroid/content/Context;Ljava/lang/Class;)Landroid/content/Intent;

    const-string v2, "_index"

    invoke-virtual {v1, v2, p3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    const-string p3, "extra_media_entry_array_list"

    invoke-virtual {v1, p3, p4}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/io/Serializable;)Landroid/content/Intent;

    if-eqz p1, :cond_5

    invoke-static {p0}, Lchat/ola/vn/util/n;->a(Landroid/content/Context;)I

    move-result p3

    new-instance p4, Landroid/graphics/Rect;

    sget v2, Lchat/ola/vn/e;->c:I

    sget v3, Lchat/ola/vn/e;->d:I

    invoke-direct {p4, v0, p3, v2, v3}, Landroid/graphics/Rect;-><init>(IIII)V

    new-instance p3, Landroid/graphics/Rect;

    invoke-direct {p3}, Landroid/graphics/Rect;-><init>()V

    invoke-virtual {p1, p3}, Landroid/view/View;->getGlobalVisibleRect(Landroid/graphics/Rect;)Z

    if-eqz p2, :cond_3

    invoke-virtual {p2}, Landroid/graphics/Bitmap;->getWidth()I

    move-result p1

    int-to-float p1, p1

    invoke-virtual {p2}, Landroid/graphics/Bitmap;->getHeight()I

    move-result p2

    int-to-float p2, p2

    invoke-static {p3, p1, p2}, Lchat/ola/vn/activity/OlaImageViewerActivity;->a(Landroid/graphics/Rect;FF)Landroid/graphics/Rect;

    move-result-object p1

    :goto_3
    const-string p2, "extra_src_animation_rect"

    invoke-static {p1, p4}, Lchat/ola/vn/activity/OlaImageViewerActivity;->a(Landroid/graphics/Rect;Landroid/graphics/Rect;)Landroid/graphics/Rect;

    move-result-object p1

    invoke-virtual {v1, p2, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Parcelable;)Landroid/content/Intent;

    :goto_4
    const-string p1, "extra_target_animation_rect"

    invoke-virtual {v1, p1, p4}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Parcelable;)Landroid/content/Intent;

    goto :goto_5

    :cond_3
    instance-of p2, p1, Landroid/widget/ImageView;

    if-eqz p2, :cond_4

    check-cast p1, Landroid/widget/ImageView;

    invoke-virtual {p1}, Landroid/widget/ImageView;->getDrawable()Landroid/graphics/drawable/Drawable;

    move-result-object p1

    if-eqz p1, :cond_5

    invoke-virtual {p1}, Landroid/graphics/drawable/Drawable;->getIntrinsicWidth()I

    move-result p2

    int-to-float p2, p2

    invoke-virtual {p1}, Landroid/graphics/drawable/Drawable;->getIntrinsicHeight()I

    move-result p1

    int-to-float p1, p1

    invoke-static {p3, p2, p1}, Lchat/ola/vn/activity/OlaImageViewerActivity;->a(Landroid/graphics/Rect;FF)Landroid/graphics/Rect;

    move-result-object p1

    goto :goto_3

    :cond_4
    const-string p1, "extra_src_animation_rect"

    invoke-static {p3, p4}, Lchat/ola/vn/activity/OlaImageViewerActivity;->a(Landroid/graphics/Rect;Landroid/graphics/Rect;)Landroid/graphics/Rect;

    move-result-object p2

    invoke-virtual {v1, p1, p2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Parcelable;)Landroid/content/Intent;

    goto :goto_4

    :cond_5
    :goto_5
    invoke-virtual {p0, v1}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    :cond_6
    return-void
.end method

.method public static varargs a(Landroid/content/Context;Landroid/view/View;Landroid/graphics/Bitmap;I[Lchat/ola/vn/mediastore/OlaMediaEntity;)V
    .locals 1

    if-eqz p4, :cond_1

    array-length v0, p4

    if-nez v0, :cond_0

    return-void

    :cond_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-static {p4}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object p4

    invoke-direct {v0, p4}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    invoke-static {p0, p1, p2, p3, v0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->a(Landroid/content/Context;Landroid/view/View;Landroid/graphics/Bitmap;ILjava/util/ArrayList;)V

    :cond_1
    return-void
.end method

.method static synthetic a(Lchat/ola/vn/activity/OlaImageViewerActivity;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->B()V

    return-void
.end method

.method static synthetic b(Lchat/ola/vn/activity/OlaImageViewerActivity;)Ljava/util/ArrayList;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->j:Ljava/util/ArrayList;

    return-object p0
.end method

.method private b(Landroid/graphics/Rect;Landroid/graphics/Rect;)V
    .locals 10
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "NewApi"
        }
    .end annotation

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->e:Lcom/mg/ola/common/widget/OlaViewPager;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/mg/ola/common/widget/OlaViewPager;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->t:Lcom/mg/ola/a/a/b/c;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->t:Lcom/mg/ola/a/a/b/c;

    invoke-virtual {v0}, Lcom/mg/ola/a/a/b/c;->b()V

    :cond_0
    if-eqz p1, :cond_3

    if-nez p2, :cond_1

    return-void

    :cond_1
    new-instance v0, Landroid/graphics/Rect;

    invoke-direct {v0, p1}, Landroid/graphics/Rect;-><init>(Landroid/graphics/Rect;)V

    new-instance p1, Landroid/graphics/Rect;

    invoke-direct {p1, p2}, Landroid/graphics/Rect;-><init>(Landroid/graphics/Rect;)V

    invoke-static {p0}, Lchat/ola/vn/util/n;->a(Landroid/content/Context;)I

    move-result p2

    neg-int p2, p2

    invoke-virtual {v0, v1, p2}, Landroid/graphics/Rect;->offset(II)V

    invoke-virtual {p1, v1, p2}, Landroid/graphics/Rect;->offset(II)V

    invoke-virtual {v0}, Landroid/graphics/Rect;->width()I

    move-result p2

    int-to-float p2, p2

    invoke-virtual {p1}, Landroid/graphics/Rect;->width()I

    move-result v2

    int-to-float v2, v2

    div-float/2addr p2, v2

    iget-object v2, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->e:Lcom/mg/ola/common/widget/OlaViewPager;

    const/4 v3, 0x0

    invoke-static {v2, v3}, Lcom/mg/ola/a/a/c/b;->b(Landroid/view/View;F)V

    iget-object v2, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->e:Lcom/mg/ola/common/widget/OlaViewPager;

    invoke-static {v2, v3}, Lcom/mg/ola/a/a/c/b;->c(Landroid/view/View;F)V

    new-instance v2, Lcom/mg/ola/a/a/b/c;

    invoke-direct {v2}, Lcom/mg/ola/a/a/b/c;-><init>()V

    iget-object v3, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->e:Lcom/mg/ola/common/widget/OlaViewPager;

    const-string v4, "translationX"

    const/4 v5, 0x2

    new-array v6, v5, [F

    iget v7, v0, Landroid/graphics/Rect;->left:I

    int-to-float v7, v7

    aput v7, v6, v1

    iget v7, p1, Landroid/graphics/Rect;->left:I

    int-to-float v7, v7

    const/4 v8, 0x1

    aput v7, v6, v8

    invoke-static {v3, v4, v6}, Lcom/mg/ola/a/a/b/j;->a(Ljava/lang/Object;Ljava/lang/String;[F)Lcom/mg/ola/a/a/b/j;

    move-result-object v3

    iget-object v4, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->e:Lcom/mg/ola/common/widget/OlaViewPager;

    const-string v6, "translationY"

    new-array v7, v5, [F

    iget v0, v0, Landroid/graphics/Rect;->top:I

    int-to-float v0, v0

    aput v0, v7, v1

    iget p1, p1, Landroid/graphics/Rect;->top:I

    int-to-float p1, p1

    aput p1, v7, v8

    invoke-static {v4, v6, v7}, Lcom/mg/ola/a/a/b/j;->a(Ljava/lang/Object;Ljava/lang/String;[F)Lcom/mg/ola/a/a/b/j;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->e:Lcom/mg/ola/common/widget/OlaViewPager;

    const-string v4, "scaleX"

    new-array v6, v5, [F

    aput p2, v6, v1

    const/high16 v7, 0x3f800000    # 1.0f

    aput v7, v6, v8

    invoke-static {v0, v4, v6}, Lcom/mg/ola/a/a/b/j;->a(Ljava/lang/Object;Ljava/lang/String;[F)Lcom/mg/ola/a/a/b/j;

    move-result-object v0

    iget-object v4, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->e:Lcom/mg/ola/common/widget/OlaViewPager;

    const-string v6, "scaleY"

    new-array v9, v5, [F

    aput p2, v9, v1

    aput v7, v9, v8

    invoke-static {v4, v6, v9}, Lcom/mg/ola/a/a/b/j;->a(Ljava/lang/Object;Ljava/lang/String;[F)Lcom/mg/ola/a/a/b/j;

    move-result-object p2

    new-array v4, v5, [Landroid/graphics/drawable/ColorDrawable;

    new-instance v6, Landroid/graphics/drawable/ColorDrawable;

    invoke-direct {v6, v1}, Landroid/graphics/drawable/ColorDrawable;-><init>(I)V

    aput-object v6, v4, v1

    new-instance v1, Landroid/graphics/drawable/ColorDrawable;

    const/high16 v6, -0x1000000

    invoke-direct {v1, v6}, Landroid/graphics/drawable/ColorDrawable;-><init>(I)V

    aput-object v1, v4, v8

    new-instance v1, Landroid/graphics/drawable/TransitionDrawable;

    invoke-direct {v1, v4}, Landroid/graphics/drawable/TransitionDrawable;-><init>([Landroid/graphics/drawable/Drawable;)V

    invoke-static {}, Lcom/mg/ola/common/d/g;->g()Z

    move-result v4

    if-eqz v4, :cond_2

    iget-object v4, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->u:Landroid/widget/FrameLayout;

    invoke-virtual {v4, v1}, Landroid/widget/FrameLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    goto :goto_0

    :cond_2
    iget-object v4, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->u:Landroid/widget/FrameLayout;

    invoke-virtual {v4, v1}, Landroid/widget/FrameLayout;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    :goto_0
    invoke-virtual {v2, v3}, Lcom/mg/ola/a/a/b/c;->a(Lcom/mg/ola/a/a/b/a;)Lcom/mg/ola/a/a/b/c$b;

    move-result-object v3

    invoke-virtual {v3, p1}, Lcom/mg/ola/a/a/b/c$b;->a(Lcom/mg/ola/a/a/b/a;)Lcom/mg/ola/a/a/b/c$b;

    move-result-object p1

    invoke-virtual {p1, v0}, Lcom/mg/ola/a/a/b/c$b;->a(Lcom/mg/ola/a/a/b/a;)Lcom/mg/ola/a/a/b/c$b;

    move-result-object p1

    invoke-virtual {p1, p2}, Lcom/mg/ola/a/a/b/c$b;->a(Lcom/mg/ola/a/a/b/a;)Lcom/mg/ola/a/a/b/c$b;

    iget-wide p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->s:J

    long-to-int p1, p1

    mul-int/lit8 p1, p1, 0x2

    div-int/lit8 p1, p1, 0x3

    invoke-virtual {v1, p1}, Landroid/graphics/drawable/TransitionDrawable;->startTransition(I)V

    iget-wide p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->s:J

    invoke-virtual {v2, p1, p2}, Lcom/mg/ola/a/a/b/c;->b(J)Lcom/mg/ola/a/a/b/c;

    new-instance p1, Landroid/view/animation/DecelerateInterpolator;

    invoke-direct {p1}, Landroid/view/animation/DecelerateInterpolator;-><init>()V

    invoke-virtual {v2, p1}, Lcom/mg/ola/a/a/b/c;->a(Landroid/view/animation/Interpolator;)V

    new-instance p1, Lchat/ola/vn/activity/OlaImageViewerActivity$6;

    invoke-direct {p1, p0}, Lchat/ola/vn/activity/OlaImageViewerActivity$6;-><init>(Lchat/ola/vn/activity/OlaImageViewerActivity;)V

    invoke-virtual {v2, p1}, Lcom/mg/ola/a/a/b/c;->a(Lcom/mg/ola/a/a/b/a$a;)V

    invoke-virtual {v2}, Lcom/mg/ola/a/a/b/c;->a()V

    iput-object v2, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->t:Lcom/mg/ola/a/a/b/c;

    :cond_3
    return-void
.end method

.method private c(Landroid/graphics/Rect;Landroid/graphics/Rect;)V
    .locals 7

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->t:Lcom/mg/ola/a/a/b/c;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->t:Lcom/mg/ola/a/a/b/c;

    invoke-virtual {v0}, Lcom/mg/ola/a/a/b/c;->b()V

    :cond_0
    if-eqz p1, :cond_3

    if-nez p2, :cond_1

    goto/16 :goto_0

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->e:Lcom/mg/ola/common/widget/OlaViewPager;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/mg/ola/a/a/c/b;->b(Landroid/view/View;F)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->e:Lcom/mg/ola/common/widget/OlaViewPager;

    invoke-static {v0, v1}, Lcom/mg/ola/a/a/c/b;->c(Landroid/view/View;F)V

    new-instance v0, Landroid/graphics/Rect;

    invoke-direct {v0, p1}, Landroid/graphics/Rect;-><init>(Landroid/graphics/Rect;)V

    new-instance p1, Landroid/graphics/Rect;

    invoke-direct {p1, p2}, Landroid/graphics/Rect;-><init>(Landroid/graphics/Rect;)V

    invoke-static {p0}, Lchat/ola/vn/util/n;->a(Landroid/content/Context;)I

    move-result p2

    neg-int p2, p2

    const/4 v1, 0x0

    invoke-virtual {v0, v1, p2}, Landroid/graphics/Rect;->offset(II)V

    invoke-virtual {p1, v1, p2}, Landroid/graphics/Rect;->offset(II)V

    invoke-virtual {v0}, Landroid/graphics/Rect;->height()I

    move-result p2

    int-to-float p2, p2

    invoke-virtual {p1}, Landroid/graphics/Rect;->height()I

    move-result p1

    int-to-float p1, p1

    div-float/2addr p2, p1

    new-instance p1, Lcom/mg/ola/a/a/b/c;

    invoke-direct {p1}, Lcom/mg/ola/a/a/b/c;-><init>()V

    iget-object v2, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->e:Lcom/mg/ola/common/widget/OlaViewPager;

    const-string v3, "translationX"

    const/4 v4, 0x1

    new-array v5, v4, [F

    iget v6, v0, Landroid/graphics/Rect;->left:I

    int-to-float v6, v6

    aput v6, v5, v1

    invoke-static {v2, v3, v5}, Lcom/mg/ola/a/a/b/j;->a(Ljava/lang/Object;Ljava/lang/String;[F)Lcom/mg/ola/a/a/b/j;

    move-result-object v2

    iget-object v3, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->e:Lcom/mg/ola/common/widget/OlaViewPager;

    const-string v5, "translationY"

    new-array v6, v4, [F

    iget v0, v0, Landroid/graphics/Rect;->top:I

    int-to-float v0, v0

    aput v0, v6, v1

    invoke-static {v3, v5, v6}, Lcom/mg/ola/a/a/b/j;->a(Ljava/lang/Object;Ljava/lang/String;[F)Lcom/mg/ola/a/a/b/j;

    move-result-object v0

    iget-object v3, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->e:Lcom/mg/ola/common/widget/OlaViewPager;

    const-string v5, "scaleX"

    new-array v6, v4, [F

    aput p2, v6, v1

    invoke-static {v3, v5, v6}, Lcom/mg/ola/a/a/b/j;->a(Ljava/lang/Object;Ljava/lang/String;[F)Lcom/mg/ola/a/a/b/j;

    move-result-object v3

    iget-object v5, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->e:Lcom/mg/ola/common/widget/OlaViewPager;

    const-string v6, "scaleY"

    new-array v4, v4, [F

    aput p2, v4, v1

    invoke-static {v5, v6, v4}, Lcom/mg/ola/a/a/b/j;->a(Ljava/lang/Object;Ljava/lang/String;[F)Lcom/mg/ola/a/a/b/j;

    move-result-object p2

    invoke-virtual {p1, v2}, Lcom/mg/ola/a/a/b/c;->a(Lcom/mg/ola/a/a/b/a;)Lcom/mg/ola/a/a/b/c$b;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/mg/ola/a/a/b/c$b;->a(Lcom/mg/ola/a/a/b/a;)Lcom/mg/ola/a/a/b/c$b;

    move-result-object v0

    invoke-virtual {v0, v3}, Lcom/mg/ola/a/a/b/c$b;->a(Lcom/mg/ola/a/a/b/a;)Lcom/mg/ola/a/a/b/c$b;

    move-result-object v0

    invoke-virtual {v0, p2}, Lcom/mg/ola/a/a/b/c$b;->a(Lcom/mg/ola/a/a/b/a;)Lcom/mg/ola/a/a/b/c$b;

    iget-wide v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->s:J

    invoke-virtual {p1, v0, v1}, Lcom/mg/ola/a/a/b/c;->b(J)Lcom/mg/ola/a/a/b/c;

    new-instance p2, Landroid/view/animation/DecelerateInterpolator;

    invoke-direct {p2}, Landroid/view/animation/DecelerateInterpolator;-><init>()V

    invoke-virtual {p1, p2}, Lcom/mg/ola/a/a/b/c;->a(Landroid/view/animation/Interpolator;)V

    new-instance p2, Lchat/ola/vn/activity/OlaImageViewerActivity$7;

    invoke-direct {p2, p0}, Lchat/ola/vn/activity/OlaImageViewerActivity$7;-><init>(Lchat/ola/vn/activity/OlaImageViewerActivity;)V

    invoke-virtual {p1, p2}, Lcom/mg/ola/a/a/b/c;->a(Lcom/mg/ola/a/a/b/a$a;)V

    invoke-virtual {p1}, Lcom/mg/ola/a/a/b/c;->a()V

    iget-object p2, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->u:Landroid/widget/FrameLayout;

    if-eqz p2, :cond_2

    iget-object p2, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->u:Landroid/widget/FrameLayout;

    invoke-virtual {p2}, Landroid/widget/FrameLayout;->getBackground()Landroid/graphics/drawable/Drawable;

    move-result-object p2

    if-eqz p2, :cond_2

    iget-object p2, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->u:Landroid/widget/FrameLayout;

    invoke-virtual {p2}, Landroid/widget/FrameLayout;->getBackground()Landroid/graphics/drawable/Drawable;

    move-result-object p2

    instance-of p2, p2, Landroid/graphics/drawable/TransitionDrawable;

    if-eqz p2, :cond_2

    iget-object p2, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->u:Landroid/widget/FrameLayout;

    invoke-virtual {p2}, Landroid/widget/FrameLayout;->getBackground()Landroid/graphics/drawable/Drawable;

    move-result-object p2

    check-cast p2, Landroid/graphics/drawable/TransitionDrawable;

    iget-wide v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->s:J

    const-wide/16 v2, 0x2

    mul-long v0, v0, v2

    const-wide/16 v2, 0x3

    div-long/2addr v0, v2

    long-to-int v0, v0

    invoke-virtual {p2, v0}, Landroid/graphics/drawable/TransitionDrawable;->reverseTransition(I)V

    :cond_2
    iput-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->t:Lcom/mg/ola/a/a/b/c;

    return-void

    :cond_3
    :goto_0
    invoke-static {p0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->c(Lchat/ola/vn/activity/OlaImageViewerActivity;)V

    return-void
.end method

.method static synthetic c(Lchat/ola/vn/activity/OlaImageViewerActivity;)V
    .locals 0

    invoke-super {p0}, Lchat/ola/vn/c;->finish()V

    return-void
.end method

.method private c(Z)V
    .locals 7
    .annotation build Landroid/annotation/TargetApi;
        value = 0x10
    .end annotation

    const/4 v0, 0x1

    if-eqz p1, :cond_3

    invoke-static {}, Lcom/mg/ola/common/d/g;->g()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->getWindow()Landroid/view/Window;

    move-result-object v1

    invoke-virtual {v1}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/view/View;->setSystemUiVisibility(I)V

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->f:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getVisibility()I

    move-result v0

    const/4 v1, 0x4

    if-nez v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->f:Landroid/view/View;

    iget-object v2, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->g:Landroid/view/animation/Animation;

    invoke-virtual {v0, v2}, Landroid/view/View;->startAnimation(Landroid/view/animation/Animation;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->f:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->H:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getVisibility()I

    move-result v0

    if-nez v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->H:Landroid/view/View;

    iget-object v2, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->L:Landroid/view/animation/Animation;

    invoke-virtual {v0, v2}, Landroid/view/View;->startAnimation(Landroid/view/animation/Animation;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->H:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->M:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getVisibility()I

    move-result v0

    if-nez v0, :cond_7

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->M:Landroid/view/View;

    iget-object v2, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->L:Landroid/view/animation/Animation;

    invoke-virtual {v0, v2}, Landroid/view/View;->startAnimation(Landroid/view/animation/Animation;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->M:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    goto :goto_0

    :cond_3
    invoke-static {}, Lcom/mg/ola/common/d/g;->g()Z

    move-result v1

    const/4 v2, 0x0

    if-eqz v1, :cond_4

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->getWindow()Landroid/view/Window;

    move-result-object v1

    invoke-virtual {v1}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v1

    invoke-virtual {v1, v2}, Landroid/view/View;->setSystemUiVisibility(I)V

    :cond_4
    iget-object v1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->f:Landroid/view/View;

    invoke-virtual {v1}, Landroid/view/View;->getVisibility()I

    move-result v1

    if-eqz v1, :cond_5

    iget-object v1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->f:Landroid/view/View;

    iget-object v3, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->h:Landroid/view/animation/Animation;

    invoke-virtual {v1, v3}, Landroid/view/View;->startAnimation(Landroid/view/animation/Animation;)V

    iget-object v1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->f:Landroid/view/View;

    invoke-virtual {v1, v2}, Landroid/view/View;->setVisibility(I)V

    :cond_5
    iget-wide v3, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->B:J

    const-wide/16 v5, 0x0

    cmp-long v1, v3, v5

    if-eqz v1, :cond_6

    iget-object v1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->H:Landroid/view/View;

    invoke-virtual {v1}, Landroid/view/View;->getVisibility()I

    move-result v1

    if-eqz v1, :cond_6

    iget-object v1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->H:Landroid/view/View;

    iget-object v3, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->K:Landroid/view/animation/Animation;

    invoke-virtual {v1, v3}, Landroid/view/View;->startAnimation(Landroid/view/animation/Animation;)V

    iget-object v1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->H:Landroid/view/View;

    invoke-virtual {v1, v2}, Landroid/view/View;->setVisibility(I)V

    :cond_6
    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->j:Ljava/util/ArrayList;

    iget-object v3, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->e:Lcom/mg/ola/common/widget/OlaViewPager;

    invoke-virtual {v3}, Lcom/mg/ola/common/widget/OlaViewPager;->getCurrentItem()I

    move-result v3

    invoke-virtual {v1, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/mediastore/OlaMediaEntity;

    if-eqz v1, :cond_7

    invoke-virtual {v1}, Lchat/ola/vn/mediastore/OlaMediaEntity;->a()I

    move-result v1

    if-ne v1, v0, :cond_7

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->M:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getVisibility()I

    move-result v0

    if-eqz v0, :cond_7

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->M:Landroid/view/View;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->K:Landroid/view/animation/Animation;

    invoke-virtual {v0, v1}, Landroid/view/View;->startAnimation(Landroid/view/animation/Animation;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->M:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_7
    :goto_0
    iput-boolean p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->k:Z

    return-void
.end method

.method static synthetic d(Lchat/ola/vn/activity/OlaImageViewerActivity;)Lcom/mg/ola/common/widget/OlaViewPager;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->e:Lcom/mg/ola/common/widget/OlaViewPager;

    return-object p0
.end method

.method static synthetic e(Lchat/ola/vn/activity/OlaImageViewerActivity;)V
    .locals 0

    invoke-super {p0}, Lchat/ola/vn/c;->finish()V

    return-void
.end method

.method static synthetic f(Lchat/ola/vn/activity/OlaImageViewerActivity;)V
    .locals 0

    invoke-super {p0}, Lchat/ola/vn/c;->finish()V

    return-void
.end method

.method private g(Ljava/lang/String;)V
    .locals 2

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz v0, :cond_0

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    new-instance v1, Lchat/ola/vn/activity/OlaImageViewerActivity$1;

    invoke-direct {v1, p0}, Lchat/ola/vn/activity/OlaImageViewerActivity$1;-><init>(Lchat/ola/vn/activity/OlaImageViewerActivity;)V

    invoke-static {v1}, Lchat/ola/vn/entry/c/f;->a(Lchat/ola/vn/entry/c/e;)S

    move-result v1

    invoke-virtual {v0, p1, v1}, Lchat/ola/vn/network/OlaNetworkService;->n(Ljava/lang/String;S)V

    :cond_0
    return-void
.end method


# virtual methods
.method protected a()V
    .locals 1

    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->a(Z)V

    return-void
.end method

.method public a(Landroid/view/View;FF)V
    .locals 0

    iget-boolean p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->k:Z

    xor-int/lit8 p1, p1, 0x1

    invoke-direct {p0, p1}, Lchat/ola/vn/activity/OlaImageViewerActivity;->c(Z)V

    return-void
.end method

.method protected a(Lchat/ola/vn/mediastore/OlaMediaEntity;)V
    .locals 4

    if-nez p1, :cond_0

    return-void

    :cond_0
    :try_start_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    invoke-virtual {p1}, Lchat/ola/vn/mediastore/OlaMediaEntity;->a()I

    move-result v1

    const/4 v2, 0x1

    if-eq v1, v2, :cond_1

    invoke-virtual {p1}, Lchat/ola/vn/mediastore/OlaMediaEntity;->a()I

    move-result v1

    const/4 v3, 0x3

    if-ne v1, v3, :cond_2

    :cond_1
    const v1, 0x7f0f05f8

    invoke-virtual {p0, v1}, Lchat/ola/vn/activity/OlaImageViewerActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_2
    invoke-virtual {p1}, Lchat/ola/vn/mediastore/OlaMediaEntity;->a()I

    move-result v1

    if-ne v1, v2, :cond_3

    const v1, 0x7f0f0491

    invoke-virtual {p0, v1}, Lchat/ola/vn/activity/OlaImageViewerActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v1, 0x7f0f0493

    invoke-virtual {p0, v1}, Lchat/ola/vn/activity/OlaImageViewerActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_3
    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_4

    return-void

    :cond_4
    new-instance v1, Lchat/ola/vn/i/m;

    invoke-direct {v1, p0}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    invoke-virtual {v1, v0}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance v2, Lchat/ola/vn/activity/OlaImageViewerActivity$5;

    invoke-direct {v2, p0, v0, p1}, Lchat/ola/vn/activity/OlaImageViewerActivity$5;-><init>(Lchat/ola/vn/activity/OlaImageViewerActivity;Ljava/util/List;Lchat/ola/vn/mediastore/OlaMediaEntity;)V

    invoke-virtual {v1, v2}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {v1}, Lchat/ola/vn/i/m;->show()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public b(Landroid/view/View;FF)V
    .locals 0

    iget-boolean p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->k:Z

    xor-int/lit8 p1, p1, 0x1

    invoke-direct {p0, p1}, Lchat/ola/vn/activity/OlaImageViewerActivity;->c(Z)V

    return-void
.end method

.method public dispatchTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 8

    :try_start_0
    invoke-direct {p0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->F()Lchat/ola/vn/activity/OlaImageViewerActivity$b;

    move-result-object v0

    iget-object v0, v0, Lchat/ola/vn/activity/OlaImageViewerActivity$b;->a:Lcom/mg/ola/common/widget/image/viewer/PhotoView;

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->a()Z

    move-result v0

    const/4 v1, 0x0

    if-nez v0, :cond_0

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getPointerCount()I

    move-result v0

    const/4 v2, 0x1

    if-ne v0, v2, :cond_0

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getActionMasked()I

    move-result v0

    packed-switch v0, :pswitch_data_0

    :pswitch_0
    goto/16 :goto_0

    :pswitch_1
    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->P:Ljava/lang/Float;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->Q:Ljava/lang/Float;

    if-eqz v0, :cond_1

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v0

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result v1

    iget-object v3, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->P:Ljava/lang/Float;

    invoke-virtual {v3}, Ljava/lang/Float;->floatValue()F

    move-result v3

    sub-float/2addr v0, v3

    invoke-static {v0}, Ljava/lang/Math;->abs(F)F

    move-result v0

    iget-object v3, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->Q:Ljava/lang/Float;

    invoke-virtual {v3}, Ljava/lang/Float;->floatValue()F

    move-result v3

    sub-float/2addr v1, v3

    invoke-static {v1}, Ljava/lang/Math;->abs(F)F

    move-result v1

    const/high16 v3, 0x42480000    # 50.0f

    cmpl-float v3, v1, v3

    if-lez v3, :cond_1

    const/high16 v3, 0x40400000    # 3.0f

    mul-float v0, v0, v3

    cmpl-float v0, v1, v0

    if-lez v0, :cond_1

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->finish()V

    return v2

    :pswitch_2
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v0

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result v2

    new-instance v3, Landroid/graphics/Rect;

    iget-object v4, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->H:Landroid/view/View;

    invoke-virtual {v4}, Landroid/view/View;->getLeft()I

    move-result v4

    iget-object v5, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->H:Landroid/view/View;

    invoke-virtual {v5}, Landroid/view/View;->getTop()I

    move-result v5

    iget-object v6, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->H:Landroid/view/View;

    invoke-virtual {v6}, Landroid/view/View;->getRight()I

    move-result v6

    iget-object v7, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->H:Landroid/view/View;

    invoke-virtual {v7}, Landroid/view/View;->getBottom()I

    move-result v7

    invoke-direct {v3, v4, v5, v6, v7}, Landroid/graphics/Rect;-><init>(IIII)V

    float-to-int v4, v0

    float-to-int v5, v2

    invoke-virtual {v3, v4, v5}, Landroid/graphics/Rect;->contains(II)Z

    move-result v3

    if-nez v3, :cond_0

    invoke-static {v0}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->P:Ljava/lang/Float;

    invoke-static {v2}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->Q:Ljava/lang/Float;

    goto :goto_0

    :cond_0
    iput-object v1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->P:Ljava/lang/Float;

    iput-object v1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->Q:Ljava/lang/Float;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    :goto_0
    invoke-super {p0, p1}, Lchat/ola/vn/c;->dispatchTouchEvent(Landroid/view/MotionEvent;)Z

    move-result p1

    return p1

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_2
        :pswitch_1
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_2
        :pswitch_1
    .end packed-switch
.end method

.method protected f(Ljava/lang/String;)V
    .locals 3

    :try_start_0
    new-instance v0, Lchat/ola/vn/activity/OlaImageViewerActivity$3;

    invoke-direct {v0, p0}, Lchat/ola/vn/activity/OlaImageViewerActivity$3;-><init>(Lchat/ola/vn/activity/OlaImageViewerActivity;)V

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/String;

    const/4 v2, 0x0

    aput-object p1, v1, v2

    invoke-virtual {v0, v1}, Lchat/ola/vn/activity/OlaImageViewerActivity$3;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public finish()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->q:Landroid/graphics/Rect;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->r:Landroid/graphics/Rect;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->q:Landroid/graphics/Rect;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->r:Landroid/graphics/Rect;

    invoke-direct {p0, v0, v1}, Lchat/ola/vn/activity/OlaImageViewerActivity;->c(Landroid/graphics/Rect;Landroid/graphics/Rect;)V

    return-void

    :cond_0
    invoke-super {p0}, Lchat/ola/vn/c;->finish()V

    return-void
.end method

.method public onBackPressed()V
    .locals 0

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->finish()V

    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 6

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const/4 v0, 0x2

    const/4 v1, 0x0

    const/4 v2, 0x1

    sparse-switch p1, :sswitch_data_0

    return-void

    :sswitch_0
    iget p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->E:I

    iget-wide v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->B:J

    invoke-static {p0, p1, v0, v1}, Lchat/ola/vn/me/OlaMeLikerListActivity;->a(Landroid/content/Context;IJ)V

    return-void

    :sswitch_1
    iget-wide v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->B:J

    invoke-static {p0, v0, v1}, Lchat/ola/vn/me/OlaMeCommentActivity;->a(Landroid/content/Context;J)V

    return-void

    :sswitch_2
    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->v()Landroid/app/Dialog;

    return-void

    :sswitch_3
    iget-short p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->G:S

    if-ne p1, v2, :cond_2

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-wide v3, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->B:J

    invoke-virtual {p1, v3, v4, v1}, Lchat/ola/vn/network/OlaNetworkService;->b(JZ)Z

    move-result p1

    if-nez p1, :cond_0

    return-void

    :cond_0
    iput-short v1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->G:S

    iget p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->E:I

    sub-int/2addr p1, v2

    iput p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->E:I

    iget p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->E:I

    if-gez p1, :cond_1

    iput v1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->E:I

    :cond_1
    invoke-direct {p0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->D()V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->z:Landroid/widget/ImageView;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->J:Landroid/view/animation/Animation;

    :goto_0
    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->startAnimation(Landroid/view/animation/Animation;)V

    return-void

    :cond_2
    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-wide v3, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->B:J

    invoke-virtual {p1, v3, v4, v2}, Lchat/ola/vn/network/OlaNetworkService;->b(JZ)Z

    move-result p1

    if-nez p1, :cond_3

    return-void

    :cond_3
    iget-short p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->G:S

    if-ne p1, v0, :cond_4

    iget p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->F:I

    sub-int/2addr p1, v2

    iput p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->F:I

    iget p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->F:I

    if-gez p1, :cond_4

    iput v1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->F:I

    :cond_4
    iput-short v2, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->G:S

    iget p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->E:I

    add-int/2addr p1, v2

    iput p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->E:I

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->D()V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->z:Landroid/widget/ImageView;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->I:Landroid/view/animation/Animation;

    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->startAnimation(Landroid/view/animation/Animation;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->z:Landroid/widget/ImageView;

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->z()Landroid/widget/FrameLayout;

    move-result-object v0

    invoke-virtual {p0, p1, v0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->b(Landroid/view/View;Landroid/widget/FrameLayout;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_2

    return-void

    :sswitch_4
    const/4 p1, 0x0

    :try_start_2
    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->j:Ljava/util/ArrayList;

    if-eqz v0, :cond_5

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->j:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-le v0, v2, :cond_5

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->j:Ljava/util/ArrayList;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->e:Lcom/mg/ola/common/widget/OlaViewPager;

    invoke-virtual {v1}, Lcom/mg/ola/common/widget/OlaViewPager;->getCurrentItem()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/mediastore/OlaMediaEntity;

    invoke-virtual {v0}, Lchat/ola/vn/mediastore/OlaMediaEntity;->a()I

    move-result v1

    if-ne v1, v2, :cond_5

    invoke-virtual {v0}, Lchat/ola/vn/mediastore/OlaMediaEntity;->c()Ljava/lang/String;

    move-result-object v0
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    move-object p1, v0

    :catch_0
    :cond_5
    move-object v5, p1

    :try_start_3
    iget-wide v1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->B:J

    iget-object v3, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->O:Ljava/lang/String;

    iget-object v4, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->C:Ljava/lang/String;

    move-object v0, p0

    invoke-direct/range {v0 .. v5}, Lchat/ola/vn/activity/OlaImageViewerActivity;->a(JLjava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void

    :sswitch_5
    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz p1, :cond_9

    iget-short p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->G:S

    if-ne p1, v0, :cond_7

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-wide v3, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->B:J

    invoke-virtual {p1, v3, v4, v1}, Lchat/ola/vn/network/OlaNetworkService;->a(JZ)V

    iput-short v1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->G:S

    iget p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->F:I

    sub-int/2addr p1, v2

    iput p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->F:I

    iget p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->F:I

    if-gez p1, :cond_6

    iput v1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->F:I

    :cond_6
    invoke-direct {p0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->D()V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->A:Landroid/widget/ImageView;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->J:Landroid/view/animation/Animation;

    goto/16 :goto_0

    :cond_7
    iget-short p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->G:S

    if-ne p1, v2, :cond_8

    iget p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->E:I

    sub-int/2addr p1, v2

    iput p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->E:I

    iget p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->E:I

    if-gez p1, :cond_8

    iput v1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->E:I

    :cond_8
    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-wide v3, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->B:J

    invoke-virtual {p1, v3, v4, v2}, Lchat/ola/vn/network/OlaNetworkService;->a(JZ)V

    iput-short v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->G:S

    iget p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->F:I

    add-int/2addr p1, v2

    iput p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->F:I

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->D()V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->A:Landroid/widget/ImageView;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->I:Landroid/view/animation/Animation;

    goto/16 :goto_0

    :sswitch_6
    invoke-direct {p0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->F()Lchat/ola/vn/activity/OlaImageViewerActivity$b;

    move-result-object p1

    if-eqz p1, :cond_9

    iget-object p1, p1, Lchat/ola/vn/activity/OlaImageViewerActivity$b;->a:Lcom/mg/ola/common/widget/image/viewer/PhotoView;

    const/high16 v0, 0x42b40000    # 90.0f

    invoke-virtual {p1, v0}, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->a(F)V

    return-void

    :sswitch_7
    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->j:Ljava/util/ArrayList;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->e:Lcom/mg/ola/common/widget/OlaViewPager;

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/OlaViewPager;->getCurrentItem()I

    move-result v0

    invoke-virtual {p1, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/mediastore/OlaMediaEntity;

    invoke-virtual {p1}, Lchat/ola/vn/mediastore/OlaMediaEntity;->a()I

    move-result v0

    if-ne v0, v2, :cond_9

    invoke-virtual {p1}, Lchat/ola/vn/mediastore/OlaMediaEntity;->c()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Lchat/ola/vn/activity/OlaImageViewerActivity;->g(Ljava/lang/String;)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_1

    return-void

    :catch_1
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :catch_2
    :cond_9
    return-void

    nop

    :sswitch_data_0
    .sparse-switch
        0x7f0900d3 -> :sswitch_7
        0x7f090119 -> :sswitch_6
        0x7f0901ec -> :sswitch_5
        0x7f090280 -> :sswitch_4
        0x7f0902d5 -> :sswitch_3
        0x7f090362 -> :sswitch_2
        0x7f090524 -> :sswitch_1
        0x7f090525 -> :sswitch_0
    .end sparse-switch
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 3

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    const/4 p1, 0x0

    :try_start_0
    invoke-virtual {p0, p1, p1}, Lchat/ola/vn/activity/OlaImageViewerActivity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    const v0, 0x7f0b00c4

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->setContentView(I)V

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->j:Ljava/util/ArrayList;

    const v0, 0x7f01004e

    invoke-static {p0, v0}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->h:Landroid/view/animation/Animation;

    const v0, 0x7f010052

    invoke-static {p0, v0}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->g:Landroid/view/animation/Animation;

    const v0, 0x7f01004b

    invoke-static {p0, v0}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->K:Landroid/view/animation/Animation;

    const v0, 0x7f01004f

    invoke-static {p0, v0}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->L:Landroid/view/animation/Animation;

    const v0, 0x7f010057

    invoke-static {p0, v0}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->I:Landroid/view/animation/Animation;

    const v0, 0x7f010058

    invoke-static {p0, v0}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->J:Landroid/view/animation/Animation;

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->C()V

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->E()I

    move-result v0

    new-instance v1, Lchat/ola/vn/activity/OlaImageViewerActivity$a;

    invoke-direct {v1, p0}, Lchat/ola/vn/activity/OlaImageViewerActivity$a;-><init>(Lchat/ola/vn/activity/OlaImageViewerActivity;)V

    iput-object v1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->i:Landroid/support/v4/view/PagerAdapter;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->e:Lcom/mg/ola/common/widget/OlaViewPager;

    iget-object v2, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->i:Landroid/support/v4/view/PagerAdapter;

    invoke-virtual {v1, v2}, Lcom/mg/ola/common/widget/OlaViewPager;->setAdapter(Landroid/support/v4/view/PagerAdapter;)V

    iget-object v1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->e:Lcom/mg/ola/common/widget/OlaViewPager;

    invoke-virtual {v1, p0}, Lcom/mg/ola/common/widget/OlaViewPager;->setOnPageChangeListener(Landroid/support/v4/view/ViewPager$OnPageChangeListener;)V

    iget-object v1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->e:Lcom/mg/ola/common/widget/OlaViewPager;

    invoke-virtual {v1, v0}, Lcom/mg/ola/common/widget/OlaViewPager;->setCurrentItem(I)V

    invoke-direct {p0, p1}, Lchat/ola/vn/activity/OlaImageViewerActivity;->c(Z)V

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->D()V

    return-void
.end method

.method protected onDestroy()V
    .locals 0

    invoke-super {p0}, Lchat/ola/vn/c;->onDestroy()V

    return-void
.end method

.method public onLongClick(Landroid/view/View;)Z
    .locals 1

    iget-boolean p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->k:Z

    const/4 v0, 0x1

    xor-int/2addr p1, v0

    invoke-direct {p0, p1}, Lchat/ola/vn/activity/OlaImageViewerActivity;->c(Z)V

    return v0
.end method

.method public onPageScrollStateChanged(I)V
    .locals 0

    return-void
.end method

.method public onPageScrolled(IFI)V
    .locals 0

    return-void
.end method

.method public onPageSelected(I)V
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->p:Landroid/widget/TextView;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    add-int/lit8 v2, p1, 0x1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v2, "/"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->i:Landroid/support/v4/view/PagerAdapter;

    invoke-virtual {v2}, Landroid/support/v4/view/PagerAdapter;->getCount()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->j:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/mediastore/OlaMediaEntity;

    invoke-virtual {p1}, Lchat/ola/vn/mediastore/OlaMediaEntity;->a()I

    move-result p1

    const/4 v0, 0x1

    if-ne p1, v0, :cond_0

    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->M:Landroid/view/View;

    const/4 v0, 0x0

    :goto_0
    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->M:Landroid/view/View;

    const/4 v0, 0x4

    goto :goto_0

    return-void
.end method

.method protected v()Landroid/app/Dialog;
    .locals 6

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->j:Ljava/util/ArrayList;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->e:Lcom/mg/ola/common/widget/OlaViewPager;

    invoke-virtual {v1}, Lcom/mg/ola/common/widget/OlaViewPager;->getCurrentItem()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/mediastore/OlaMediaEntity;

    if-nez v0, :cond_0

    const/4 v0, 0x0

    return-object v0

    :cond_0
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    const/4 v2, 0x0

    invoke-virtual {v0}, Lchat/ola/vn/mediastore/OlaMediaEntity;->a()I

    move-result v3

    const/4 v4, 0x2

    const/4 v5, 0x1

    if-eq v3, v4, :cond_1

    invoke-virtual {v0}, Lchat/ola/vn/mediastore/OlaMediaEntity;->a()I

    move-result v3

    if-ne v3, v5, :cond_2

    :cond_1
    const v2, 0x7f0f0614

    invoke-virtual {p0, v2}, Lchat/ola/vn/activity/OlaImageViewerActivity;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-interface {v1, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v2, 0x7f0f05b5

    invoke-virtual {p0, v2}, Lchat/ola/vn/activity/OlaImageViewerActivity;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-interface {v1, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const/4 v2, 0x1

    :cond_2
    const v3, 0x7f0f061e

    invoke-virtual {p0, v3}, Lchat/ola/vn/activity/OlaImageViewerActivity;->getString(I)Ljava/lang/String;

    move-result-object v3

    invoke-interface {v1, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v3, 0x7f0f0620

    invoke-virtual {p0, v3}, Lchat/ola/vn/activity/OlaImageViewerActivity;->getString(I)Ljava/lang/String;

    move-result-object v3

    invoke-interface {v1, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v3, 0x7f0f061d

    invoke-virtual {p0, v3}, Lchat/ola/vn/activity/OlaImageViewerActivity;->getString(I)Ljava/lang/String;

    move-result-object v3

    invoke-interface {v1, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    if-eqz v2, :cond_3

    const v2, 0x7f0f056b

    :goto_0
    invoke-virtual {p0, v2}, Lchat/ola/vn/activity/OlaImageViewerActivity;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-interface {v1, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_1

    :cond_3
    const v2, 0x7f0f05f8

    goto :goto_0

    :goto_1
    new-instance v2, Lchat/ola/vn/i/m;

    invoke-direct {v2, p0}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    invoke-virtual {v2, v1}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance v3, Lchat/ola/vn/activity/OlaImageViewerActivity$4;

    invoke-direct {v3, p0, v1, v0}, Lchat/ola/vn/activity/OlaImageViewerActivity$4;-><init>(Lchat/ola/vn/activity/OlaImageViewerActivity;Ljava/util/List;Lchat/ola/vn/mediastore/OlaMediaEntity;)V

    invoke-virtual {v2, v3}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {v2}, Lchat/ola/vn/i/m;->show()V

    return-object v2
.end method

.method public z()Landroid/widget/FrameLayout;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaImageViewerActivity;->u:Landroid/widget/FrameLayout;

    return-object v0
.end method
