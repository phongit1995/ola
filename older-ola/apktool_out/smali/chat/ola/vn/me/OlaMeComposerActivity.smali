.class public Lchat/ola/vn/me/OlaMeComposerActivity;
.super Lchat/ola/vn/c;

# interfaces
.implements Landroid/text/TextWatcher;
.implements Landroid/view/View$OnClickListener;
.implements Landroid/view/View$OnTouchListener;
.implements Lchat/ola/vn/checkin/b;
.implements Lchat/ola/vn/contactpicker/OlaContactPickerActivity$b;
.implements Lchat/ola/vn/n/b$b;
.implements Lchat/ola/vn/network/a/a/l$a;
.implements Lchat/ola/vn/view/OlaQuickTypingSuggestedText$b;
.implements Lchat/ola/vn/view/e$a;
.implements Lchat/ola/vn/view/g$e;
.implements Lchat/ola/vn/view/h$b;
.implements Lchat/ola/vn/view/i$e;
.implements Lchat/ola/vn/view/j$a;
.implements Lcom/mg/ola/common/widget/a/a;


# static fields
.field private static E:J = 0x0L

.field private static F:Z = false

.field private static G:Z = false

.field private static H:Ljava/lang/String; = null

.field private static I:Ljava/lang/String; = null

.field private static J:Ljava/util/List; = null
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private static K:Ljava/util/List; = null
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private static L:Lchat/ola/vn/entity/OlaVenueEntity; = null

.field private static M:Lchat/ola/vn/entity/z; = null

.field public static e:Z = false

.field private static h:J


# instance fields
.field private A:Lchat/ola/vn/view/i;

.field private B:Lchat/ola/vn/view/j;

.field private C:Lchat/ola/vn/view/d;

.field private D:Ljava/io/File;

.field private N:S

.field private O:Lchat/ola/vn/entity/w;

.field private P:Lchat/ola/vn/entity/OlaCheckInActionEntity;

.field private Q:Lchat/ola/vn/entity/OlaCheckInItemEntity;

.field private R:J

.field private S:Lchat/ola/vn/view/OlaCachedImageView;

.field private T:Landroid/widget/TextView;

.field private U:Landroid/widget/TextView;

.field private V:J

.field private W:Z

.field private X:I

.field private Y:Landroid/view/View;

.field private Z:Landroid/widget/CheckBox;

.field private aa:Landroid/view/View;

.field private ab:Landroid/widget/TextView;

.field private f:I

.field private g:I

.field private i:Landroid/view/animation/Animation;

.field private j:Landroid/view/animation/Animation;

.field private k:Landroid/view/View;

.field private l:Lcom/mg/ola/common/widget/SoftKeyLinearLayout;

.field private m:Lchat/ola/vn/view/OlaTypingSuggestedText;

.field private n:Landroid/widget/TextView;

.field private o:Landroid/widget/TextView;

.field private p:Landroid/widget/TextView;

.field private q:Lit/sephiroth/android/library/widget/HListView;

.field private r:Lchat/ola/vn/b/s;

.field private s:Lchat/ola/vn/view/OlaCachedImageView;

.field private t:Landroid/view/View;

.field private u:Lchat/ola/vn/i/c;

.field private v:Landroid/widget/ImageButton;

.field private w:Landroid/widget/ImageButton;

.field private x:Landroid/widget/ImageButton;

.field private y:Landroid/widget/FrameLayout;

.field private z:Lchat/ola/vn/view/h;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 3

    invoke-direct {p0}, Lchat/ola/vn/c;-><init>()V

    const/4 v0, 0x0

    iput v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->f:I

    iput v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->g:I

    const/4 v1, 0x0

    iput-object v1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->z:Lchat/ola/vn/view/h;

    iput-object v1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->A:Lchat/ola/vn/view/i;

    iput-object v1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->B:Lchat/ola/vn/view/j;

    iput-object v1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->C:Lchat/ola/vn/view/d;

    iput-object v1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->D:Ljava/io/File;

    const/4 v2, 0x2

    iput-short v2, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->N:S

    iput-object v1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->O:Lchat/ola/vn/entity/w;

    iput-object v1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->P:Lchat/ola/vn/entity/OlaCheckInActionEntity;

    iput-object v1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->Q:Lchat/ola/vn/entity/OlaCheckInItemEntity;

    const-wide/16 v1, 0x0

    iput-wide v1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->R:J

    iput-wide v1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->V:J

    iput-boolean v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->W:Z

    return-void
.end method

.method static synthetic B()Lchat/ola/vn/entity/z;
    .locals 1

    sget-object v0, Lchat/ola/vn/me/OlaMeComposerActivity;->M:Lchat/ola/vn/entity/z;

    return-object v0
.end method

.method private C()V
    .locals 3

    const v0, 0x7f090334

    invoke-virtual {p0, v0}, Lchat/ola/vn/me/OlaMeComposerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->k:Landroid/view/View;

    const v0, 0x7f0903e1

    invoke-virtual {p0, v0}, Lchat/ola/vn/me/OlaMeComposerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->Y:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->Y:Landroid/view/View;

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f0903df

    invoke-virtual {p0, v0}, Lchat/ola/vn/me/OlaMeComposerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/CheckBox;

    iput-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->Z:Landroid/widget/CheckBox;

    const v0, 0x7f09039c

    invoke-virtual {p0, v0}, Lchat/ola/vn/me/OlaMeComposerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f090336

    invoke-virtual {p0, v0}, Lchat/ola/vn/me/OlaMeComposerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V

    const v0, 0x7f09007f

    invoke-virtual {p0, v0}, Lchat/ola/vn/me/OlaMeComposerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lit/sephiroth/android/library/widget/HListView;

    iput-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->q:Lit/sephiroth/android/library/widget/HListView;

    new-instance v0, Lchat/ola/vn/b/s;

    invoke-direct {v0, p0}, Lchat/ola/vn/b/s;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->r:Lchat/ola/vn/b/s;

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->q:Lit/sephiroth/android/library/widget/HListView;

    iget-object v1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->r:Lchat/ola/vn/b/s;

    invoke-virtual {v0, v1}, Lit/sephiroth/android/library/widget/HListView;->setAdapter(Landroid/widget/ListAdapter;)V

    :try_start_0
    sget-object v0, Lchat/ola/vn/me/OlaMeComposerActivity;->K:Ljava/util/List;

    if-eqz v0, :cond_0

    sget-object v0, Lchat/ola/vn/me/OlaMeComposerActivity;->K:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    iget-object v2, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->r:Lchat/ola/vn/b/s;

    invoke-virtual {v2, v1}, Lchat/ola/vn/b/s;->c(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    :cond_0
    :try_start_1
    sget-object v0, Lchat/ola/vn/me/OlaMeComposerActivity;->J:Ljava/util/List;

    if-eqz v0, :cond_1

    sget-object v0, Lchat/ola/vn/me/OlaMeComposerActivity;->J:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_1
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    iget-object v2, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->r:Lchat/ola/vn/b/s;

    invoke-virtual {v2, v1}, Lchat/ola/vn/b/s;->a(Ljava/lang/String;)V

    goto :goto_1

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->r:Lchat/ola/vn/b/s;

    invoke-virtual {v0}, Lchat/ola/vn/b/s;->notifyDataSetChanged()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    const v0, 0x7f0903e0

    invoke-virtual {p0, v0}, Lchat/ola/vn/me/OlaMeComposerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->n:Landroid/widget/TextView;

    const v0, 0x7f09039e

    invoke-virtual {p0, v0}, Lchat/ola/vn/me/OlaMeComposerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->o:Landroid/widget/TextView;

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->o:Landroid/widget/TextView;

    invoke-virtual {v0, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->o:Landroid/widget/TextView;

    const v1, 0x7f0f05b1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    const v0, 0x7f0903a3

    invoke-virtual {p0, v0}, Lchat/ola/vn/me/OlaMeComposerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->p:Landroid/widget/TextView;

    const v0, 0x7f090335

    invoke-virtual {p0, v0}, Lchat/ola/vn/me/OlaMeComposerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaTypingSuggestedText;

    iput-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->m:Lchat/ola/vn/view/OlaTypingSuggestedText;

    new-instance v0, Lchat/ola/vn/b/q;

    invoke-direct {v0, p0}, Lchat/ola/vn/b/q;-><init>(Landroid/content/Context;)V

    invoke-static {}, Lchat/ola/vn/g;->a()Ljava/util/List;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/b/q;->a(Ljava/util/List;)V

    iget-object v1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->m:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {v1, v0}, Lchat/ola/vn/view/OlaTypingSuggestedText;->setAdapter(Landroid/widget/BaseAdapter;)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->m:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {p0}, Lchat/ola/vn/me/OlaMeComposerActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const v2, 0x7f0700ec

    invoke-virtual {v1, v2}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v1

    mul-int/lit8 v1, v1, 0x5

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaTypingSuggestedText;->setPopupMaxHeight(I)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->m:Lchat/ola/vn/view/OlaTypingSuggestedText;

    sget-boolean v1, Lchat/ola/vn/c/x;->r:Z

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaTypingSuggestedText;->setAllowedSuggestion(Z)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->m:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {v0, p0}, Lchat/ola/vn/view/OlaTypingSuggestedText;->addTextChangedListener(Landroid/text/TextWatcher;)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->m:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {v0, p0}, Lchat/ola/vn/view/OlaTypingSuggestedText;->setOnSuggestionSelectListener(Lchat/ola/vn/view/OlaQuickTypingSuggestedText$b;)V

    const v0, 0x7f09049c

    invoke-virtual {p0, v0}, Lchat/ola/vn/me/OlaMeComposerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->s:Lchat/ola/vn/view/OlaCachedImageView;

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->s:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, p0}, Lchat/ola/vn/view/OlaCachedImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f09048c

    invoke-virtual {p0, v0}, Lchat/ola/vn/me/OlaMeComposerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lcom/mg/ola/common/widget/SoftKeyLinearLayout;

    iput-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->l:Lcom/mg/ola/common/widget/SoftKeyLinearLayout;

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->l:Lcom/mg/ola/common/widget/SoftKeyLinearLayout;

    invoke-virtual {v0, p0}, Lcom/mg/ola/common/widget/SoftKeyLinearLayout;->setOnSoftKeyboardListener(Lcom/mg/ola/common/widget/a/a;)V

    const v0, 0x7f0904ad

    invoke-virtual {p0, v0}, Lchat/ola/vn/me/OlaMeComposerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->t:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->t:Landroid/view/View;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    const v0, 0x7f0902ba

    invoke-virtual {p0, v0}, Lchat/ola/vn/me/OlaMeComposerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->ab:Landroid/widget/TextView;

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->ab:Landroid/widget/TextView;

    const v1, 0x7f0f06c4

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    const v0, 0x7f0902b7

    invoke-virtual {p0, v0}, Lchat/ola/vn/me/OlaMeComposerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->S:Lchat/ola/vn/view/OlaCachedImageView;

    const v0, 0x7f0902b9

    invoke-virtual {p0, v0}, Lchat/ola/vn/me/OlaMeComposerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->T:Landroid/widget/TextView;

    const v0, 0x7f0902b8

    invoke-virtual {p0, v0}, Lchat/ola/vn/me/OlaMeComposerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->U:Landroid/widget/TextView;

    const v0, 0x7f0902b6

    invoke-virtual {p0, v0}, Lchat/ola/vn/me/OlaMeComposerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->aa:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->aa:Landroid/view/View;

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f0902bb

    invoke-virtual {p0, v0}, Lchat/ola/vn/me/OlaMeComposerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    invoke-direct {p0}, Lchat/ola/vn/me/OlaMeComposerActivity;->F()V

    invoke-direct {p0}, Lchat/ola/vn/me/OlaMeComposerActivity;->D()Z

    move-result v0

    if-nez v0, :cond_2

    invoke-direct {p0}, Lchat/ola/vn/me/OlaMeComposerActivity;->E()V

    :cond_2
    return-void
.end method

.method private D()Z
    .locals 8

    const/4 v0, 0x0

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/me/OlaMeComposerActivity;->getIntent()Landroid/content/Intent;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v2

    const-string v3, "android.intent.action.SEND"

    invoke-static {v2, v3}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    const-wide/16 v4, 0x0

    const/4 v6, 0x1

    if-eqz v3, :cond_2

    sput-wide v4, Lchat/ola/vn/me/OlaMeComposerActivity;->E:J

    invoke-virtual {v1}, Landroid/content/Intent;->getType()Ljava/lang/String;

    move-result-object v2

    const-string v3, "text"

    invoke-virtual {v2, v3}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_0

    const-string v2, "android.intent.extra.TEXT"

    invoke-virtual {v1, v2}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_1

    iget-object v2, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->m:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-direct {p0, v1}, Lchat/ola/vn/me/OlaMeComposerActivity;->n(Ljava/lang/String;)Ljava/lang/CharSequence;

    move-result-object v1

    invoke-virtual {v2, v1}, Lchat/ola/vn/view/OlaTypingSuggestedText;->setText(Ljava/lang/CharSequence;)V

    return v6

    :cond_0
    const-string v2, "android.intent.extra.STREAM"

    invoke-virtual {v1, v2}, Landroid/content/Intent;->getParcelableExtra(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object v1

    check-cast v1, Landroid/net/Uri;

    if-eqz v1, :cond_1

    invoke-virtual {p0}, Lchat/ola/vn/me/OlaMeComposerActivity;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    invoke-static {v2, v1}, Lchat/ola/vn/util/o;->a(Landroid/content/ContentResolver;Landroid/net/Uri;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_1

    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    invoke-interface {v2, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-virtual {p0, v2}, Lchat/ola/vn/me/OlaMeComposerActivity;->f(Ljava/util/List;)V

    :cond_1
    return v6

    :cond_2
    const-string v3, "android.intent.action.SEND_MULTIPLE"

    invoke-static {v2, v3}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_7

    sput-wide v4, Lchat/ola/vn/me/OlaMeComposerActivity;->E:J

    const-string v2, "android.intent.extra.STREAM"

    invoke-virtual {v1, v2}, Landroid/content/Intent;->getParcelableArrayListExtra(Ljava/lang/String;)Ljava/util/ArrayList;

    move-result-object v2

    invoke-virtual {v1}, Landroid/content/Intent;->getType()Ljava/lang/String;

    move-result-object v3

    const-string v4, "text"

    invoke-virtual {v3, v4}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_3

    const-string v2, "android.intent.extra.TEXT"

    invoke-virtual {v1, v2}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_6

    iget-object v2, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->m:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-direct {p0, v1}, Lchat/ola/vn/me/OlaMeComposerActivity;->n(Ljava/lang/String;)Ljava/lang/CharSequence;

    move-result-object v1

    invoke-virtual {v2, v1}, Lchat/ola/vn/view/OlaTypingSuggestedText;->setText(Ljava/lang/CharSequence;)V

    return v6

    :cond_3
    if-eqz v2, :cond_6

    invoke-virtual {v2}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_6

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v3

    const/4 v4, 0x0

    :goto_0
    if-ge v4, v3, :cond_5

    invoke-virtual {v2, v4}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Landroid/net/Uri;

    invoke-virtual {p0}, Lchat/ola/vn/me/OlaMeComposerActivity;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v7

    invoke-static {v7, v5}, Lchat/ola/vn/util/o;->a(Landroid/content/ContentResolver;Landroid/net/Uri;)Ljava/lang/String;

    move-result-object v5

    invoke-static {v5}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v7

    if-nez v7, :cond_4

    invoke-interface {v1, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_4
    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    :cond_5
    invoke-virtual {p0, v1}, Lchat/ola/vn/me/OlaMeComposerActivity;->f(Ljava/util/List;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :cond_6
    return v6

    :catch_0
    :cond_7
    return v0
.end method

.method private E()V
    .locals 8

    const/4 v0, 0x0

    iput-boolean v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->W:Z

    sget-wide v1, Lchat/ola/vn/me/OlaMeComposerActivity;->E:J

    const-wide/16 v3, 0x0

    cmp-long v5, v1, v3

    if-nez v5, :cond_3

    iget-short v1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->N:S

    const/16 v2, 0xa

    if-eq v1, v2, :cond_3

    sget-object v1, Lchat/ola/vn/me/OlaMeComposerActivity;->J:Ljava/util/List;

    if-eqz v1, :cond_0

    sget-object v1, Lchat/ola/vn/me/OlaMeComposerActivity;->J:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    if-nez v1, :cond_3

    :cond_0
    sget-object v1, Lchat/ola/vn/me/OlaMeComposerActivity;->K:Ljava/util/List;

    if-eqz v1, :cond_1

    sget-object v1, Lchat/ola/vn/me/OlaMeComposerActivity;->K:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    if-nez v1, :cond_3

    :cond_1
    sget-object v1, Lchat/ola/vn/me/OlaMeComposerActivity;->I:Ljava/lang/String;

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_3

    sget-object v1, Lchat/ola/vn/me/OlaMeComposerActivity;->H:Ljava/lang/String;

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_3

    sget-object v1, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v1}, Lchat/ola/vn/r/a/e;->y()Lchat/ola/vn/me/a;

    move-result-object v1

    if-eqz v1, :cond_3

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    iget-wide v4, v1, Lchat/ola/vn/me/a;->i:J

    sub-long v6, v2, v4

    const-wide/32 v2, 0x493e0

    cmp-long v4, v6, v2

    const/4 v2, 0x0

    if-gtz v4, :cond_2

    iget-byte v3, v1, Lchat/ola/vn/me/a;->k:B

    if-nez v3, :cond_3

    sget-object v3, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v3, v2}, Lchat/ola/vn/r/a/e;->a(Lchat/ola/vn/me/a;)V

    iget-wide v3, v1, Lchat/ola/vn/me/a;->h:J

    sput-wide v3, Lchat/ola/vn/me/OlaMeComposerActivity;->E:J

    iget-short v3, v1, Lchat/ola/vn/me/a;->j:S

    iput-short v3, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->N:S

    iget-object v3, v1, Lchat/ola/vn/me/a;->b:Lchat/ola/vn/entity/w;

    iput-object v3, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->O:Lchat/ola/vn/entity/w;

    iget-object v3, v1, Lchat/ola/vn/me/a;->c:Ljava/lang/String;

    sput-object v3, Lchat/ola/vn/me/OlaMeComposerActivity;->H:Ljava/lang/String;

    iget-object v1, v1, Lchat/ola/vn/me/a;->a:Ljava/util/List;

    iget-object v3, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->r:Lchat/ola/vn/b/s;

    invoke-virtual {v3, v1}, Lchat/ola/vn/b/s;->a(Ljava/util/List;)V

    iget-object v1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->r:Lchat/ola/vn/b/s;

    invoke-virtual {v1}, Lchat/ola/vn/b/s;->notifyDataSetChanged()V

    new-instance v1, Lchat/ola/vn/me/OlaMeComposerActivity$1;

    invoke-direct {v1, p0}, Lchat/ola/vn/me/OlaMeComposerActivity$1;-><init>(Lchat/ola/vn/me/OlaMeComposerActivity;)V

    invoke-static {v1}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    sput-object v2, Lchat/ola/vn/me/OlaMeComposerActivity;->M:Lchat/ola/vn/entity/z;

    goto :goto_0

    :cond_2
    sget-object v1, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v1, v2}, Lchat/ola/vn/r/a/e;->a(Lchat/ola/vn/me/a;)V

    :cond_3
    :goto_0
    const-string v1, ""

    sget-object v2, Lchat/ola/vn/me/OlaMeComposerActivity;->H:Ljava/lang/String;

    invoke-static {v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_4

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v1, Lchat/ola/vn/me/OlaMeComposerActivity;->H:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, " "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v0

    :cond_4
    sget-object v2, Lchat/ola/vn/me/OlaMeComposerActivity;->I:Ljava/lang/String;

    invoke-static {v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_5

    sget-object v2, Lchat/ola/vn/me/OlaMeComposerActivity;->I:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v2

    sput-object v2, Lchat/ola/vn/me/OlaMeComposerActivity;->I:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v1, Lchat/ola/vn/me/OlaMeComposerActivity;->I:Ljava/lang/String;

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, " "

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    :cond_5
    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    if-lez v2, :cond_b

    invoke-static {v1}, Lchat/ola/vn/util/i;->b(Ljava/lang/CharSequence;)Ljava/util/ArrayList;

    move-result-object v2

    :try_start_0
    invoke-interface {v2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :cond_6
    :goto_1
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_8

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    invoke-static {v3}, Lchat/ola/vn/entity/i;->i(Ljava/lang/String;)C

    move-result v4

    const/4 v5, 0x1

    if-ne v4, v5, :cond_7

    iget-object v4, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->r:Lchat/ola/vn/b/s;

    invoke-virtual {v4, v3}, Lchat/ola/vn/b/s;->a(Ljava/lang/String;)V

    goto :goto_1

    :cond_7
    invoke-static {v3}, Lchat/ola/vn/entity/i;->i(Ljava/lang/String;)C

    move-result v4

    const/4 v5, 0x2

    if-ne v4, v5, :cond_6

    iget-object v4, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->r:Lchat/ola/vn/b/s;

    invoke-virtual {v4, v3}, Lchat/ola/vn/b/s;->b(Ljava/lang/String;)V

    goto :goto_1

    :cond_8
    iget-object v2, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->r:Lchat/ola/vn/b/s;

    invoke-virtual {v2}, Lchat/ola/vn/b/s;->notifyDataSetChanged()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :try_start_1
    invoke-static {v1}, Lchat/ola/vn/util/i;->e(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_9

    sget-object v3, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    new-instance v4, Lchat/ola/vn/me/OlaMeComposerActivity$12;

    invoke-direct {v4, p0}, Lchat/ola/vn/me/OlaMeComposerActivity$12;-><init>(Lchat/ola/vn/me/OlaMeComposerActivity;)V

    invoke-virtual {v3, v2, v4}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Lchat/ola/vn/p/l;)V

    goto :goto_2

    :cond_9
    invoke-static {v1}, Lchat/ola/vn/util/i;->f(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_a

    sget-object v3, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    new-instance v4, Lchat/ola/vn/me/OlaMeComposerActivity$16;

    invoke-direct {v4, p0}, Lchat/ola/vn/me/OlaMeComposerActivity$16;-><init>(Lchat/ola/vn/me/OlaMeComposerActivity;)V

    invoke-virtual {v3, v2, v4}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Lchat/ola/vn/network/a/a/aj$a;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    :cond_a
    :goto_2
    const-string v2, ""

    invoke-static {v1, v2}, Lchat/ola/vn/util/i;->d(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->m:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-direct {p0, v1}, Lchat/ola/vn/me/OlaMeComposerActivity;->n(Ljava/lang/String;)Ljava/lang/CharSequence;

    move-result-object v3

    invoke-virtual {v2, v3}, Lchat/ola/vn/view/OlaTypingSuggestedText;->setText(Ljava/lang/CharSequence;)V

    iget-object v2, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->m:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    invoke-virtual {v2, v0, v1}, Lchat/ola/vn/view/OlaTypingSuggestedText;->setSelection(II)V

    :cond_b
    return-void
.end method

.method private F()V
    .locals 6

    const v0, 0x7f09014e

    invoke-virtual {p0, v0}, Lchat/ola/vn/me/OlaMeComposerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/FrameLayout;

    iput-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->y:Landroid/widget/FrameLayout;

    const v0, 0x7f0903fb

    invoke-virtual {p0, v0}, Lchat/ola/vn/me/OlaMeComposerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    const v0, 0x7f09015c

    invoke-virtual {p0, v0}, Lchat/ola/vn/me/OlaMeComposerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageButton;

    iput-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->v:Landroid/widget/ImageButton;

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->v:Landroid/widget/ImageButton;

    invoke-virtual {v0, p0}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f090143

    invoke-virtual {p0, v0}, Lchat/ola/vn/me/OlaMeComposerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageButton;

    const v2, 0x7f080704

    invoke-virtual {v0, v2}, Landroid/widget/ImageButton;->setImageResource(I)V

    invoke-virtual {v0, p0}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f0902c8

    invoke-virtual {p0, v0}, Lchat/ola/vn/me/OlaMeComposerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageButton;

    iput-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->w:Landroid/widget/ImageButton;

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->w:Landroid/widget/ImageButton;

    invoke-virtual {v0, p0}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f090310

    invoke-virtual {p0, v0}, Lchat/ola/vn/me/OlaMeComposerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageButton;

    const v2, 0x7f0806a3

    invoke-virtual {v0, v2}, Landroid/widget/ImageButton;->setImageResource(I)V

    invoke-virtual {v0, p0}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f090600

    invoke-virtual {p0, v0}, Lchat/ola/vn/me/OlaMeComposerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageButton;

    const v2, 0x7f0807a0

    invoke-virtual {v0, v2}, Landroid/widget/ImageButton;->setImageResource(I)V

    invoke-virtual {v0, p0}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f090360

    invoke-virtual {p0, v0}, Lchat/ola/vn/me/OlaMeComposerActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageButton;

    iput-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->x:Landroid/widget/ImageButton;

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->x:Landroid/widget/ImageButton;

    const v2, 0x7f08069b

    invoke-virtual {v0, v2}, Landroid/widget/ImageButton;->setImageResource(I)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->x:Landroid/widget/ImageButton;

    invoke-virtual {v0, p0}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    sget-wide v2, Lchat/ola/vn/me/OlaMeComposerActivity;->E:J

    const-wide/16 v4, 0x0

    cmp-long v0, v2, v4

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->x:Landroid/widget/ImageButton;

    const/4 v1, 0x0

    :goto_0
    invoke-virtual {v0, v1}, Landroid/widget/ImageButton;->setVisibility(I)V

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->x:Landroid/widget/ImageButton;

    goto :goto_0

    return-void
.end method

.method private G()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->r:Lchat/ola/vn/b/s;

    invoke-virtual {v0}, Lchat/ola/vn/b/s;->d()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->q:Lit/sephiroth/android/library/widget/HListView;

    const/4 v1, 0x0

    :goto_0
    invoke-virtual {v0, v1}, Lit/sephiroth/android/library/widget/HListView;->setVisibility(I)V

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->q:Lit/sephiroth/android/library/widget/HListView;

    const/16 v1, 0x8

    goto :goto_0

    return-void
.end method

.method private H()V
    .locals 8

    sget-object v0, Lchat/ola/vn/me/OlaMeComposerActivity;->M:Lchat/ola/vn/entity/z;

    const/16 v1, 0xf0

    const/16 v2, 0x8

    const/4 v3, 0x0

    if-eqz v0, :cond_5

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->ab:Landroid/widget/TextView;

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->aa:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->t:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getVisibility()I

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->t:Landroid/view/View;

    iget-object v4, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->i:Landroid/view/animation/Animation;

    invoke-virtual {v0, v4}, Landroid/view/View;->startAnimation(Landroid/view/animation/Animation;)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->t:Landroid/view/View;

    invoke-virtual {v0, v3}, Landroid/view/View;->setVisibility(I)V

    :cond_0
    sget-object v0, Lchat/ola/vn/me/OlaMeComposerActivity;->M:Lchat/ola/vn/entity/z;

    iget-object v0, v0, Lchat/ola/vn/entity/z;->c:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->T:Landroid/widget/TextView;

    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->T:Landroid/widget/TextView;

    sget-object v4, Lchat/ola/vn/me/OlaMeComposerActivity;->M:Lchat/ola/vn/entity/z;

    iget-object v4, v4, Lchat/ola/vn/entity/z;->c:Ljava/lang/String;

    invoke-virtual {v0, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :cond_1
    sget-object v0, Lchat/ola/vn/me/OlaMeComposerActivity;->M:Lchat/ola/vn/entity/z;

    iget-object v0, v0, Lchat/ola/vn/entity/z;->e:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->U:Landroid/widget/TextView;

    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->U:Landroid/widget/TextView;

    sget-object v4, Lchat/ola/vn/me/OlaMeComposerActivity;->M:Lchat/ola/vn/entity/z;

    iget-object v4, v4, Lchat/ola/vn/entity/z;->e:Ljava/lang/String;

    invoke-virtual {v0, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :cond_2
    sget-object v0, Lchat/ola/vn/me/OlaMeComposerActivity;->M:Lchat/ola/vn/entity/z;

    iget-object v0, v0, Lchat/ola/vn/entity/z;->f:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_4

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->S:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, v3}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    sget-object v0, Lchat/ola/vn/me/OlaMeComposerActivity;->M:Lchat/ola/vn/entity/z;

    iget-object v0, v0, Lchat/ola/vn/entity/z;->f:Ljava/lang/String;

    sget-object v2, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v0, v2}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    const-string v2, "http"

    invoke-virtual {v0, v2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_3

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    sget-object v1, Lchat/ola/vn/me/OlaMeComposerActivity;->M:Lchat/ola/vn/entity/z;

    iget-object v1, v1, Lchat/ola/vn/entity/z;->f:Ljava/lang/String;

    iget-object v2, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->S:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/c/t;->b(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V

    return-void

    :cond_3
    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    sget-object v2, Lchat/ola/vn/me/OlaMeComposerActivity;->M:Lchat/ola/vn/entity/z;

    iget-object v2, v2, Lchat/ola/vn/entity/z;->f:Ljava/lang/String;

    iget-object v3, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->S:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, v2, v3, v1}, Lchat/ola/vn/c/t;->b(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;I)V

    return-void

    :cond_4
    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->S:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, v2}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    return-void

    :cond_5
    sget-object v0, Lchat/ola/vn/me/OlaMeComposerActivity;->L:Lchat/ola/vn/entity/OlaVenueEntity;

    if-eqz v0, :cond_e

    sget-wide v4, Lchat/ola/vn/me/OlaMeComposerActivity;->E:J

    const-wide/16 v6, 0x0

    cmp-long v0, v4, v6

    if-nez v0, :cond_e

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->ab:Landroid/widget/TextView;

    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->aa:Landroid/view/View;

    invoke-virtual {v0, v3}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->t:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getVisibility()I

    move-result v0

    if-eqz v0, :cond_6

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->t:Landroid/view/View;

    iget-object v4, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->i:Landroid/view/animation/Animation;

    invoke-virtual {v0, v4}, Landroid/view/View;->startAnimation(Landroid/view/animation/Animation;)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->t:Landroid/view/View;

    invoke-virtual {v0, v3}, Landroid/view/View;->setVisibility(I)V

    :cond_6
    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->T:Landroid/widget/TextView;

    sget-object v4, Lchat/ola/vn/me/OlaMeComposerActivity;->L:Lchat/ola/vn/entity/OlaVenueEntity;

    invoke-virtual {v4}, Lchat/ola/vn/entity/OlaVenueEntity;->c()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v0, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->U:Landroid/widget/TextView;

    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->P:Lchat/ola/vn/entity/OlaCheckInActionEntity;

    if-eqz v0, :cond_8

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->P:Lchat/ola/vn/entity/OlaCheckInActionEntity;

    invoke-virtual {v0}, Lchat/ola/vn/entity/OlaCheckInActionEntity;->b()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_8

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->P:Lchat/ola/vn/entity/OlaCheckInActionEntity;

    invoke-virtual {v0}, Lchat/ola/vn/entity/OlaCheckInActionEntity;->b()Ljava/lang/String;

    move-result-object v0

    iget-object v4, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->Q:Lchat/ola/vn/entity/OlaCheckInItemEntity;

    if-eqz v4, :cond_7

    iget-object v4, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->Q:Lchat/ola/vn/entity/OlaCheckInItemEntity;

    invoke-virtual {v4}, Lchat/ola/vn/entity/OlaCheckInItemEntity;->b()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_7

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v0, " "

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->Q:Lchat/ola/vn/entity/OlaCheckInItemEntity;

    invoke-virtual {v0}, Lchat/ola/vn/entity/OlaCheckInItemEntity;->b()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    :cond_7
    iget-object v4, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->U:Landroid/widget/TextView;

    invoke-virtual {v4, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto/16 :goto_1

    :cond_8
    sget-object v0, Lchat/ola/vn/me/OlaMeComposerActivity;->L:Lchat/ola/vn/entity/OlaVenueEntity;

    invoke-virtual {v0}, Lchat/ola/vn/entity/OlaVenueEntity;->i()I

    move-result v0

    const/16 v4, 0x64

    if-le v0, v4, :cond_9

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->U:Landroid/widget/TextView;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const v5, 0x7f0f0471

    invoke-virtual {p0, v5}, Lchat/ola/vn/me/OlaMeComposerActivity;->getString(I)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v5, ": "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v5, Lchat/ola/vn/me/OlaMeComposerActivity;->L:Lchat/ola/vn/entity/OlaVenueEntity;

    invoke-virtual {v5}, Lchat/ola/vn/entity/OlaVenueEntity;->i()I

    move-result v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    :goto_0
    invoke-virtual {v0, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_1

    :cond_9
    sget-object v0, Lchat/ola/vn/me/OlaMeComposerActivity;->L:Lchat/ola/vn/entity/OlaVenueEntity;

    invoke-virtual {v0}, Lchat/ola/vn/entity/OlaVenueEntity;->d()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_a

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->U:Landroid/widget/TextView;

    sget-object v4, Lchat/ola/vn/me/OlaMeComposerActivity;->L:Lchat/ola/vn/entity/OlaVenueEntity;

    invoke-virtual {v4}, Lchat/ola/vn/entity/OlaVenueEntity;->d()Ljava/lang/String;

    move-result-object v4

    goto :goto_0

    :cond_a
    sget-object v0, Lchat/ola/vn/me/OlaMeComposerActivity;->L:Lchat/ola/vn/entity/OlaVenueEntity;

    invoke-virtual {v0}, Lchat/ola/vn/entity/OlaVenueEntity;->e()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_b

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->U:Landroid/widget/TextView;

    sget-object v4, Lchat/ola/vn/me/OlaMeComposerActivity;->L:Lchat/ola/vn/entity/OlaVenueEntity;

    invoke-virtual {v4}, Lchat/ola/vn/entity/OlaVenueEntity;->e()Ljava/lang/String;

    move-result-object v4

    goto :goto_0

    :cond_b
    sget-object v0, Lchat/ola/vn/me/OlaMeComposerActivity;->L:Lchat/ola/vn/entity/OlaVenueEntity;

    invoke-virtual {v0}, Lchat/ola/vn/entity/OlaVenueEntity;->h()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_c

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->U:Landroid/widget/TextView;

    sget-object v4, Lchat/ola/vn/me/OlaMeComposerActivity;->L:Lchat/ola/vn/entity/OlaVenueEntity;

    invoke-virtual {v4}, Lchat/ola/vn/entity/OlaVenueEntity;->h()Ljava/lang/String;

    move-result-object v4

    goto :goto_0

    :cond_c
    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->U:Landroid/widget/TextView;

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setVisibility(I)V

    :goto_1
    sget-object v0, Lchat/ola/vn/me/OlaMeComposerActivity;->L:Lchat/ola/vn/entity/OlaVenueEntity;

    invoke-virtual {v0}, Lchat/ola/vn/entity/OlaVenueEntity;->f()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_4

    iget-object v4, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->S:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v4, v3}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    sget-object v3, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v0, v3}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v3

    const-string v4, "http"

    invoke-virtual {v3, v4}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v3

    const/4 v4, 0x1

    if-eqz v3, :cond_d

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->S:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v1, v0, v2, v4}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Z)V

    return-void

    :cond_d
    invoke-static {v0}, Lchat/ola/vn/entity/i;->i(Ljava/lang/String;)C

    move-result v3

    if-ne v3, v4, :cond_4

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v2

    iget-object v3, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->S:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v2, v0, v3, v1}, Lchat/ola/vn/c/t;->b(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;I)V

    return-void

    :cond_e
    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->t:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getVisibility()I

    move-result v0

    if-nez v0, :cond_f

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->t:Landroid/view/View;

    iget-object v1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->j:Landroid/view/animation/Animation;

    invoke-virtual {v0, v1}, Landroid/view/View;->startAnimation(Landroid/view/animation/Animation;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->t:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    :cond_f
    return-void
.end method

.method private N()V
    .locals 8

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->O:Lchat/ola/vn/entity/w;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->s:Lchat/ola/vn/view/OlaCachedImageView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v2

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->O:Lchat/ola/vn/entity/w;

    invoke-virtual {v0}, Lchat/ola/vn/entity/w;->a()Ljava/lang/String;

    move-result-object v3

    iget-object v4, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->s:Lchat/ola/vn/view/OlaCachedImageView;

    sget-object v5, Landroid/widget/ImageView$ScaleType;->CENTER_INSIDE:Landroid/widget/ImageView$ScaleType;

    const/4 v6, 0x0

    const/16 v7, 0xf0

    invoke-virtual/range {v2 .. v7}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Landroid/widget/ImageView$ScaleType;Landroid/view/View;I)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->s:Lchat/ola/vn/view/OlaCachedImageView;

    sget-object v1, Landroid/widget/ImageView$ScaleType;->CENTER_INSIDE:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->s:Lchat/ola/vn/view/OlaCachedImageView;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    return-void
.end method

.method private O()V
    .locals 3

    iget-short v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->N:S

    and-int/lit16 v0, v0, 0x3fff

    int-to-short v0, v0

    iget-short v1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->N:S

    const/16 v2, 0x4000

    and-int/2addr v1, v2

    if-ne v1, v2, :cond_0

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->n:Landroid/widget/TextView;

    const v1, 0x7f0f05bf

    :goto_0
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    return-void

    :cond_0
    const v1, 0x7f0f0520

    packed-switch v0, :pswitch_data_0

    packed-switch v0, :pswitch_data_1

    return-void

    :pswitch_0
    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->n:Landroid/widget/TextView;

    const v1, 0x7f0f04bc

    goto :goto_0

    :pswitch_1
    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->n:Landroid/widget/TextView;

    goto :goto_0

    :pswitch_2
    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->n:Landroid/widget/TextView;

    const v1, 0x7f0f05bc

    goto :goto_0

    :pswitch_3
    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->n:Landroid/widget/TextView;

    const v1, 0x7f0f0502

    goto :goto_0

    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_3
        :pswitch_2
        :pswitch_1
    .end packed-switch

    :pswitch_data_1
    .packed-switch 0xa
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method

.method private P()V
    .locals 6

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    const v1, 0x7f0f05bb

    invoke-virtual {p0, v1}, Lchat/ola/vn/me/OlaMeComposerActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v1, 0x7f0f0501

    invoke-virtual {p0, v1}, Lchat/ola/vn/me/OlaMeComposerActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v1, 0x7f0f05bf

    invoke-virtual {p0, v1}, Lchat/ola/vn/me/OlaMeComposerActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v1, 0x7f0f051f

    invoke-virtual {p0, v1}, Lchat/ola/vn/me/OlaMeComposerActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    sget-wide v1, Lchat/ola/vn/me/OlaMeComposerActivity;->E:J

    const-wide/16 v3, 0x0

    cmp-long v5, v1, v3

    if-nez v5, :cond_0

    const v1, 0x7f0f04bb

    invoke-virtual {p0, v1}, Lchat/ola/vn/me/OlaMeComposerActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v1, 0x7f0f043f

    invoke-virtual {p0, v1}, Lchat/ola/vn/me/OlaMeComposerActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_0
    new-instance v1, Lchat/ola/vn/i/m;

    invoke-direct {v1, p0}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    invoke-virtual {v1, v0}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance v2, Lchat/ola/vn/me/OlaMeComposerActivity$21;

    invoke-direct {v2, p0, v0}, Lchat/ola/vn/me/OlaMeComposerActivity$21;-><init>(Lchat/ola/vn/me/OlaMeComposerActivity;Ljava/util/List;)V

    invoke-virtual {v1, v2}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {v1}, Lchat/ola/vn/i/m;->show()V

    return-void
.end method

.method private Q()V
    .locals 4

    :try_start_0
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.media.action.IMAGE_CAPTURE"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    new-instance v1, Ljava/io/File;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-static {v2, v3}, Lchat/ola/vn/d;->a(J)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    iput-object v1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->D:Ljava/io/File;

    iget-object v1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->D:Ljava/io/File;

    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->D:Ljava/io/File;

    invoke-virtual {v1}, Ljava/io/File;->delete()Z

    :cond_0
    const-string v1, "output"

    iget-object v2, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->D:Ljava/io/File;

    invoke-static {v2}, Landroid/net/Uri;->fromFile(Ljava/io/File;)Landroid/net/Uri;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Parcelable;)Landroid/content/Intent;

    const/4 v1, 0x2

    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/me/OlaMeComposerActivity;->startActivityForResult(Landroid/content/Intent;I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private R()V
    .locals 3

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x17

    if-lt v0, v1, :cond_0

    const-string v0, "android.permission.READ_EXTERNAL_STORAGE"

    invoke-virtual {p0, v0}, Lchat/ola/vn/me/OlaMeComposerActivity;->checkSelfPermission(Ljava/lang/String;)I

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "android.permission.READ_EXTERNAL_STORAGE"

    aput-object v2, v0, v1

    const/16 v1, 0x67

    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/me/OlaMeComposerActivity;->requestPermissions([Ljava/lang/String;I)V

    return-void

    :cond_0
    invoke-static {p0, p0}, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->a(Landroid/content/Context;Lchat/ola/vn/view/g$e;)V

    return-void
.end method

.method private S()V
    .locals 0

    invoke-static {p0, p0}, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->a(Landroid/content/Context;Lchat/ola/vn/view/g$e;)V

    return-void
.end method

.method private T()Lchat/ola/vn/me/a;
    .locals 3

    invoke-direct {p0}, Lchat/ola/vn/me/OlaMeComposerActivity;->W()Lchat/ola/vn/me/a;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    iput-wide v1, v0, Lchat/ola/vn/me/a;->i:J

    sget-object v1, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v1, v0}, Lchat/ola/vn/r/a/e;->a(Lchat/ola/vn/me/a;)V

    :cond_0
    return-object v0
.end method

.method private U()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->s:Lchat/ola/vn/view/OlaCachedImageView;

    iget-object v1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->j:Landroid/view/animation/Animation;

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->startAnimation(Landroid/view/animation/Animation;)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->s:Lchat/ola/vn/view/OlaCachedImageView;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->O:Lchat/ola/vn/entity/w;

    return-void
.end method

.method private V()V
    .locals 2

    :try_start_0
    invoke-direct {p0}, Lchat/ola/vn/me/OlaMeComposerActivity;->T()Lchat/ola/vn/me/a;

    move-result-object v0

    const/4 v1, 0x1

    if-eqz v0, :cond_0

    iput-byte v1, v0, Lchat/ola/vn/me/a;->k:B

    invoke-virtual {v0}, Lchat/ola/vn/me/a;->b()V

    :cond_0
    iput-boolean v1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->W:Z

    invoke-virtual {p0}, Lchat/ola/vn/me/OlaMeComposerActivity;->finish()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private W()Lchat/ola/vn/me/a;
    .locals 8

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->r:Lchat/ola/vn/b/s;

    invoke-virtual {v0}, Lchat/ola/vn/b/s;->a()Ljava/util/List;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->m:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {v1}, Lchat/ola/vn/view/OlaTypingSuggestedText;->getText()Landroid/text/Editable;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Lchat/ola/vn/me/a;

    invoke-direct {v2}, Lchat/ola/vn/me/a;-><init>()V

    const/4 v3, 0x0

    iput-byte v3, v2, Lchat/ola/vn/me/a;->k:B

    iget-object v3, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->O:Lchat/ola/vn/entity/w;

    iput-object v3, v2, Lchat/ola/vn/me/a;->b:Lchat/ola/vn/entity/w;

    if-eqz v0, :cond_0

    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3, v0}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v3, v2, Lchat/ola/vn/me/a;->a:Ljava/util/List;

    :cond_0
    sget-object v3, Lchat/ola/vn/me/OlaMeComposerActivity;->L:Lchat/ola/vn/entity/OlaVenueEntity;

    if-eqz v3, :cond_1

    sget-object v3, Lchat/ola/vn/me/OlaMeComposerActivity;->L:Lchat/ola/vn/entity/OlaVenueEntity;

    invoke-virtual {v3}, Lchat/ola/vn/entity/OlaVenueEntity;->b()Ljava/lang/String;

    move-result-object v3

    iput-object v3, v2, Lchat/ola/vn/me/a;->d:Ljava/lang/String;

    sget-object v3, Lchat/ola/vn/me/OlaMeComposerActivity;->L:Lchat/ola/vn/entity/OlaVenueEntity;

    invoke-virtual {v3}, Lchat/ola/vn/entity/OlaVenueEntity;->j()Ljava/lang/String;

    move-result-object v3

    iput-object v3, v2, Lchat/ola/vn/me/a;->e:Ljava/lang/String;

    :cond_1
    iget-object v3, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->P:Lchat/ola/vn/entity/OlaCheckInActionEntity;

    if-eqz v3, :cond_2

    iget-object v3, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->P:Lchat/ola/vn/entity/OlaCheckInActionEntity;

    invoke-virtual {v3}, Lchat/ola/vn/entity/OlaCheckInActionEntity;->a()Ljava/lang/String;

    move-result-object v3

    iput-object v3, v2, Lchat/ola/vn/me/a;->f:Ljava/lang/String;

    :cond_2
    iget-object v3, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->Q:Lchat/ola/vn/entity/OlaCheckInItemEntity;

    if-eqz v3, :cond_3

    iget-object v3, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->Q:Lchat/ola/vn/entity/OlaCheckInItemEntity;

    invoke-virtual {v3}, Lchat/ola/vn/entity/OlaCheckInItemEntity;->a()Ljava/lang/String;

    move-result-object v3

    iput-object v3, v2, Lchat/ola/vn/me/a;->g:Ljava/lang/String;

    :cond_3
    iput-object v1, v2, Lchat/ola/vn/me/a;->c:Ljava/lang/String;

    sget-wide v3, Lchat/ola/vn/me/OlaMeComposerActivity;->E:J

    iput-wide v3, v2, Lchat/ola/vn/me/a;->h:J

    iget-short v3, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->N:S

    iput-short v3, v2, Lchat/ola/vn/me/a;->j:S

    sget-boolean v3, Lchat/ola/vn/me/OlaMeComposerActivity;->F:Z

    iput-boolean v3, v2, Lchat/ola/vn/me/a;->l:Z

    sget-boolean v3, Lchat/ola/vn/me/OlaMeComposerActivity;->G:Z

    iput-boolean v3, v2, Lchat/ola/vn/me/a;->n:Z

    :try_start_0
    iget-object v3, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->Z:Landroid/widget/CheckBox;

    invoke-virtual {v3}, Landroid/widget/CheckBox;->isChecked()Z

    move-result v3

    iput-boolean v3, v2, Lchat/ola/vn/me/a;->m:Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    sget-wide v3, Lchat/ola/vn/me/OlaMeComposerActivity;->E:J

    const-wide/16 v5, 0x0

    cmp-long v7, v3, v5

    if-eqz v7, :cond_5

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_5

    iget-object v1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->O:Lchat/ola/vn/entity/w;

    if-nez v1, :cond_5

    if-eqz v0, :cond_4

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-nez v0, :cond_5

    :cond_4
    const/4 v0, 0x0

    return-object v0

    :cond_5
    return-object v2
.end method

.method private X()V
    .locals 7

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/n/c;->e()Landroid/location/Location;

    move-result-object v0

    if-eqz v0, :cond_1

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    iget-wide v3, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->V:J

    sub-long v5, v1, v3

    const-wide/32 v1, 0xdbba0

    cmp-long v3, v5, v1

    if-lez v3, :cond_0

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Landroid/location/Location;->getAccuracy()F

    move-result v0

    const/high16 v1, 0x42480000    # 50.0f

    cmpg-float v0, v0, v1

    if-gtz v0, :cond_1

    :cond_0
    invoke-static {p0, p0}, Lchat/ola/vn/checkin/OlaCheckInActivity;->a(Landroid/content/Context;Lchat/ola/vn/checkin/b;)V

    return-void

    :cond_1
    invoke-static {p0}, Lchat/ola/vn/n/b;->b(Landroid/content/Context;)Z

    move-result v0

    if-nez v0, :cond_2

    const/16 v0, 0x65

    invoke-static {p0, v0}, Lchat/ola/vn/n/b;->a(Landroid/app/Activity;I)V

    return-void

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->u:Lchat/ola/vn/i/c;

    if-nez v0, :cond_3

    new-instance v0, Lchat/ola/vn/i/c;

    invoke-direct {v0, p0}, Lchat/ola/vn/i/c;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->u:Lchat/ola/vn/i/c;

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->u:Lchat/ola/vn/i/c;

    const v1, 0x7f0f0275

    invoke-virtual {v0, v1}, Lchat/ola/vn/i/c;->a(I)V

    :cond_3
    const-wide/16 v0, 0x1388

    new-instance v2, Lchat/ola/vn/me/OlaMeComposerActivity$2;

    invoke-direct {v2, p0}, Lchat/ola/vn/me/OlaMeComposerActivity$2;-><init>(Lchat/ola/vn/me/OlaMeComposerActivity;)V

    invoke-static {p0, v0, v1, v2}, Lchat/ola/vn/n/b;->b(Landroid/content/Context;JLchat/ola/vn/n/b$b;)V

    return-void
.end method

.method private Y()V
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->v:Landroid/widget/ImageButton;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/ImageButton;->setSelected(Z)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->w:Landroid/widget/ImageButton;

    invoke-virtual {v0, v1}, Landroid/widget/ImageButton;->setSelected(Z)V

    iget v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->g:I

    const/4 v2, 0x1

    packed-switch v0, :pswitch_data_0

    return-void

    :pswitch_0
    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->w:Landroid/widget/ImageButton;

    goto :goto_0

    :pswitch_1
    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->v:Landroid/widget/ImageButton;

    :goto_0
    invoke-virtual {v0, v2}, Landroid/widget/ImageButton;->setSelected(Z)V

    return-void

    :pswitch_2
    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->v:Landroid/widget/ImageButton;

    invoke-virtual {v0, v1}, Landroid/widget/ImageButton;->setSelected(Z)V

    :pswitch_3
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_2
        :pswitch_1
        :pswitch_0
        :pswitch_3
        :pswitch_3
    .end packed-switch
.end method

.method private Z()V
    .locals 2

    iget v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->f:I

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->k:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getHeight()I

    move-result v0

    sget v1, Lchat/ola/vn/activity/OlaChatViewActivity;->g:I

    sub-int/2addr v0, v1

    iput v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->f:I

    :cond_0
    new-instance v0, Lchat/ola/vn/me/OlaMeComposerActivity$4;

    invoke-direct {v0, p0}, Lchat/ola/vn/me/OlaMeComposerActivity$4;-><init>(Lchat/ola/vn/me/OlaMeComposerActivity;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/me/OlaMeComposerActivity;J)J
    .locals 0

    iput-wide p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->V:J

    return-wide p1
.end method

.method static synthetic a(Lchat/ola/vn/me/OlaMeComposerActivity;)Lchat/ola/vn/b/s;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->r:Lchat/ola/vn/b/s;

    return-object p0
.end method

.method static synthetic a(Lchat/ola/vn/entity/z;)Lchat/ola/vn/entity/z;
    .locals 0

    sput-object p0, Lchat/ola/vn/me/OlaMeComposerActivity;->M:Lchat/ola/vn/entity/z;

    return-object p0
.end method

.method static synthetic a(Lchat/ola/vn/me/OlaMeComposerActivity;S)S
    .locals 0

    iput-short p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->N:S

    return p1
.end method

.method public static a(Landroid/content/Context;)V
    .locals 9

    const/4 v1, 0x0

    const/4 v2, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    const-wide/16 v6, 0x0

    const/4 v8, 0x0

    move-object v0, p0

    invoke-static/range {v0 .. v8}, Lchat/ola/vn/me/OlaMeComposerActivity;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/util/List;Ljava/util/List;Lchat/ola/vn/entity/OlaVenueEntity;JZ)V

    return-void
.end method

.method public static a(Landroid/content/Context;J)V
    .locals 6

    const/4 v1, 0x0

    const/4 v2, 0x0

    const/4 v3, 0x0

    move-object v0, p0

    move-wide v4, p1

    invoke-static/range {v0 .. v5}, Lchat/ola/vn/me/OlaMeComposerActivity;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;J)V

    return-void
.end method

.method public static a(Landroid/content/Context;Lchat/ola/vn/entity/OlaVenueEntity;)V
    .locals 9

    const/4 v1, 0x0

    const/4 v2, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    const-wide/16 v6, 0x0

    const/4 v8, 0x0

    move-object v0, p0

    move-object v5, p1

    invoke-static/range {v0 .. v8}, Lchat/ola/vn/me/OlaMeComposerActivity;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/util/List;Ljava/util/List;Lchat/ola/vn/entity/OlaVenueEntity;JZ)V

    return-void
.end method

.method public static a(Landroid/content/Context;Ljava/lang/String;)V
    .locals 9

    const/4 v1, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    const-wide/16 v6, 0x0

    const/4 v8, 0x1

    move-object v0, p0

    move-object v2, p1

    invoke-static/range {v0 .. v8}, Lchat/ola/vn/me/OlaMeComposerActivity;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/util/List;Ljava/util/List;Lchat/ola/vn/entity/OlaVenueEntity;JZ)V

    return-void
.end method

.method public static a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V
    .locals 9

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    const-wide/16 v6, 0x0

    const/4 v8, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    invoke-static/range {v0 .. v8}, Lchat/ola/vn/me/OlaMeComposerActivity;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/util/List;Ljava/util/List;Lchat/ola/vn/entity/OlaVenueEntity;JZ)V

    return-void
.end method

.method public static a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;J)V
    .locals 6

    const/4 v3, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-wide v4, p3

    invoke-static/range {v0 .. v5}, Lchat/ola/vn/me/OlaMeComposerActivity;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;J)V

    return-void
.end method

.method public static a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 10

    invoke-static {p3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    invoke-interface {v0, p3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    move-object v4, v0

    const/4 v5, 0x0

    const/4 v6, 0x0

    const-wide/16 v7, 0x0

    const/4 v9, 0x0

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    invoke-static/range {v1 .. v9}, Lchat/ola/vn/me/OlaMeComposerActivity;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/util/List;Ljava/util/List;Lchat/ola/vn/entity/OlaVenueEntity;JZ)V

    return-void
.end method

.method public static a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;J)V
    .locals 10

    invoke-static {p3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    invoke-interface {v0, p3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    move-object v4, v0

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v9, 0x0

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-wide v7, p4

    invoke-static/range {v1 .. v9}, Lchat/ola/vn/me/OlaMeComposerActivity;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/util/List;Ljava/util/List;Lchat/ola/vn/entity/OlaVenueEntity;JZ)V

    return-void
.end method

.method public static a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/util/List;)V
    .locals 9
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    const/4 v4, 0x0

    const/4 v5, 0x0

    const-wide/16 v6, 0x0

    const/4 v8, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    invoke-static/range {v0 .. v8}, Lchat/ola/vn/me/OlaMeComposerActivity;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/util/List;Ljava/util/List;Lchat/ola/vn/entity/OlaVenueEntity;JZ)V

    return-void
.end method

.method public static a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/util/List;J)V
    .locals 9
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;J)V"
        }
    .end annotation

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v8, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    move-wide v6, p4

    invoke-static/range {v0 .. v8}, Lchat/ola/vn/me/OlaMeComposerActivity;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/util/List;Ljava/util/List;Lchat/ola/vn/entity/OlaVenueEntity;JZ)V

    return-void
.end method

.method private static a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/util/List;Ljava/util/List;Lchat/ola/vn/entity/OlaVenueEntity;JZ)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;",
            "Lchat/ola/vn/entity/OlaVenueEntity;",
            "JZ)V"
        }
    .end annotation

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    move-object p1, v1

    :cond_0
    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    move-object p2, v1

    :cond_1
    const/4 v0, 0x0

    sput-boolean v0, Lchat/ola/vn/me/OlaMeComposerActivity;->G:Z

    sput-boolean p8, Lchat/ola/vn/me/OlaMeComposerActivity;->F:Z

    sput-wide p6, Lchat/ola/vn/me/OlaMeComposerActivity;->E:J

    sput-object p1, Lchat/ola/vn/me/OlaMeComposerActivity;->H:Ljava/lang/String;

    sput-object p2, Lchat/ola/vn/me/OlaMeComposerActivity;->I:Ljava/lang/String;

    sput-object p3, Lchat/ola/vn/me/OlaMeComposerActivity;->J:Ljava/util/List;

    sput-object p4, Lchat/ola/vn/me/OlaMeComposerActivity;->K:Ljava/util/List;

    sput-object p5, Lchat/ola/vn/me/OlaMeComposerActivity;->L:Lchat/ola/vn/entity/OlaVenueEntity;

    new-instance p1, Landroid/content/Intent;

    const-class p2, Lchat/ola/vn/me/OlaMeComposerActivity;

    invoke-direct {p1, p0, p2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const/high16 p2, 0x20000

    invoke-virtual {p1, p2}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    invoke-virtual {p0, p1}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    :try_start_0
    check-cast p0, Landroid/app/Activity;

    const p1, 0x7f010036

    const p2, 0x7f01003d

    invoke-virtual {p0, p1, p2}, Landroid/app/Activity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public static a(Landroid/content/Context;Ljava/lang/String;Ljava/util/List;)V
    .locals 9
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    const/4 v1, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    const-wide/16 v6, 0x0

    const/4 v8, 0x1

    move-object v0, p0

    move-object v2, p1

    move-object v3, p2

    invoke-static/range {v0 .. v8}, Lchat/ola/vn/me/OlaMeComposerActivity;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/util/List;Ljava/util/List;Lchat/ola/vn/entity/OlaVenueEntity;JZ)V

    return-void
.end method

.method public static a(Landroid/content/Context;Ljava/util/List;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    const/4 v0, 0x0

    invoke-static {p0, v0, p1}, Lchat/ola/vn/me/OlaMeComposerActivity;->c(Landroid/content/Context;Ljava/lang/String;Ljava/util/List;)V

    return-void
.end method

.method private aa()V
    .locals 1

    new-instance v0, Lchat/ola/vn/me/OlaMeComposerActivity$5;

    invoke-direct {v0, p0}, Lchat/ola/vn/me/OlaMeComposerActivity$5;-><init>(Lchat/ola/vn/me/OlaMeComposerActivity;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method private ab()V
    .locals 2
    .annotation build Landroid/annotation/TargetApi;
        value = 0xd
    .end annotation

    :try_start_0
    const-string v0, "window"

    invoke-virtual {p0, v0}, Lchat/ola/vn/me/OlaMeComposerActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/WindowManager;

    invoke-interface {v0}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object v0

    invoke-static {}, Lcom/mg/ola/common/d/g;->e()Z

    move-result v1

    if-eqz v1, :cond_0

    new-instance v1, Landroid/graphics/Point;

    invoke-direct {v1}, Landroid/graphics/Point;-><init>()V

    invoke-virtual {v0, v1}, Landroid/view/Display;->getSize(Landroid/graphics/Point;)V

    iget v0, v1, Landroid/graphics/Point;->x:I

    sput v0, Lchat/ola/vn/e;->c:I

    iget v0, v1, Landroid/graphics/Point;->y:I

    :goto_0
    sput v0, Lchat/ola/vn/e;->d:I

    return-void

    :cond_0
    invoke-virtual {v0}, Landroid/view/Display;->getWidth()I

    move-result v1

    sput v1, Lchat/ola/vn/e;->c:I

    invoke-virtual {v0}, Landroid/view/Display;->getHeight()I

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    return-void
.end method

.method private ac()Z
    .locals 2

    const/4 v0, 0x0

    :try_start_0
    iget v1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->g:I

    packed-switch v1, :pswitch_data_0

    return v0

    :pswitch_0
    iput v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->g:I

    invoke-direct {p0, v0}, Lchat/ola/vn/me/OlaMeComposerActivity;->d(Z)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    const/4 v0, 0x1

    :catch_0
    return v0

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_0
        :pswitch_0
    .end packed-switch
.end method

.method static synthetic b(Lchat/ola/vn/me/OlaMeComposerActivity;)Lit/sephiroth/android/library/widget/HListView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->q:Lit/sephiroth/android/library/widget/HListView;

    return-object p0
.end method

.method public static b(Landroid/content/Context;)V
    .locals 10

    const/16 v0, 0xa

    sput-short v0, Lchat/ola/vn/c/x;->j:S

    const/4 v2, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    const-wide/16 v7, 0x0

    const/4 v9, 0x0

    move-object v1, p0

    invoke-static/range {v1 .. v9}, Lchat/ola/vn/me/OlaMeComposerActivity;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/util/List;Ljava/util/List;Lchat/ola/vn/entity/OlaVenueEntity;JZ)V

    return-void
.end method

.method public static b(Landroid/content/Context;J)V
    .locals 6

    const/4 v1, 0x0

    const/4 v2, 0x0

    const/4 v3, 0x0

    move-object v0, p0

    move-wide v4, p1

    invoke-static/range {v0 .. v5}, Lchat/ola/vn/me/OlaMeComposerActivity;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;J)V

    const/4 p0, 0x1

    sput-boolean p0, Lchat/ola/vn/me/OlaMeComposerActivity;->G:Z

    return-void
.end method

.method public static b(Landroid/content/Context;Ljava/lang/String;)V
    .locals 9

    const/4 v1, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    const-wide/16 v6, 0x0

    const/4 v8, 0x0

    move-object v0, p0

    move-object v2, p1

    invoke-static/range {v0 .. v8}, Lchat/ola/vn/me/OlaMeComposerActivity;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/util/List;Ljava/util/List;Lchat/ola/vn/entity/OlaVenueEntity;JZ)V

    return-void
.end method

.method public static b(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    const/4 v0, 0x0

    invoke-static {p0, p1, v0, p2}, Lchat/ola/vn/me/OlaMeComposerActivity;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public static b(Landroid/content/Context;Ljava/lang/String;Ljava/util/List;)V
    .locals 9
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    const/4 v1, 0x0

    const/4 v3, 0x0

    const/4 v5, 0x0

    const-wide/16 v6, 0x0

    const/4 v8, 0x1

    move-object v0, p0

    move-object v2, p1

    move-object v4, p2

    invoke-static/range {v0 .. v8}, Lchat/ola/vn/me/OlaMeComposerActivity;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/util/List;Ljava/util/List;Lchat/ola/vn/entity/OlaVenueEntity;JZ)V

    return-void
.end method

.method public static c(Landroid/content/Context;Ljava/lang/String;)V
    .locals 1

    const/4 v0, 0x0

    invoke-static {p0, v0, p1}, Lchat/ola/vn/me/OlaMeComposerActivity;->b(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public static c(Landroid/content/Context;Ljava/lang/String;Ljava/util/List;)V
    .locals 9
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    const/4 v1, 0x0

    const/4 v3, 0x0

    const/4 v5, 0x0

    const-wide/16 v6, 0x0

    const/4 v8, 0x0

    move-object v0, p0

    move-object v2, p1

    move-object v4, p2

    invoke-static/range {v0 .. v8}, Lchat/ola/vn/me/OlaMeComposerActivity;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/util/List;Ljava/util/List;Lchat/ola/vn/entity/OlaVenueEntity;JZ)V

    return-void
.end method

.method static synthetic c(Lchat/ola/vn/me/OlaMeComposerActivity;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/me/OlaMeComposerActivity;->H()V

    return-void
.end method

.method private c(Z)V
    .locals 1
    .annotation build Landroid/annotation/TargetApi;
        value = 0xc
    .end annotation

    :try_start_0
    new-instance v0, Lchat/ola/vn/me/OlaMeComposerActivity$22;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/me/OlaMeComposerActivity$22;-><init>(Lchat/ola/vn/me/OlaMeComposerActivity;Z)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public static d(Landroid/content/Context;Ljava/lang/String;)V
    .locals 1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    invoke-static {p0, v0}, Lchat/ola/vn/me/OlaMeComposerActivity;->a(Landroid/content/Context;Ljava/util/List;)V

    return-void
.end method

.method static synthetic d(Lchat/ola/vn/me/OlaMeComposerActivity;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/me/OlaMeComposerActivity;->R()V

    return-void
.end method

.method private d(Z)V
    .locals 3

    :try_start_0
    invoke-direct {p0}, Lchat/ola/vn/me/OlaMeComposerActivity;->Y()V

    iget v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->g:I

    const/4 v1, 0x0

    const/4 v2, 0x1

    packed-switch v0, :pswitch_data_0

    goto/16 :goto_1

    :pswitch_0
    invoke-direct {p0, v2}, Lchat/ola/vn/me/OlaMeComposerActivity;->e(Z)V

    invoke-direct {p0}, Lchat/ola/vn/me/OlaMeComposerActivity;->Z()V

    iget-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->B:Lchat/ola/vn/view/j;

    if-nez p1, :cond_0

    new-instance p1, Lchat/ola/vn/view/j;

    invoke-direct {p1, p0}, Lchat/ola/vn/view/j;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->B:Lchat/ola/vn/view/j;

    iget-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->B:Lchat/ola/vn/view/j;

    invoke-virtual {p1, p0}, Lchat/ola/vn/view/j;->setOnVoiceRecordListener(Lchat/ola/vn/view/j$a;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_2

    :cond_0
    :try_start_1
    iget-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->C:Lchat/ola/vn/view/d;

    if-eqz p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->C:Lchat/ola/vn/view/d;

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->B:Lchat/ola/vn/view/j;

    if-eq p1, v0, :cond_7

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->y:Landroid/widget/FrameLayout;

    invoke-virtual {p1}, Landroid/widget/FrameLayout;->removeAllViews()V

    iget-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->y:Landroid/widget/FrameLayout;

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->B:Lchat/ola/vn/view/j;

    invoke-virtual {p1, v0}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;)V

    iget-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->B:Lchat/ola/vn/view/j;

    :goto_0
    iput-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->C:Lchat/ola/vn/view/d;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto/16 :goto_1

    :pswitch_1
    :try_start_2
    invoke-direct {p0, v2}, Lchat/ola/vn/me/OlaMeComposerActivity;->e(Z)V

    invoke-direct {p0}, Lchat/ola/vn/me/OlaMeComposerActivity;->Z()V

    iget-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->A:Lchat/ola/vn/view/i;

    if-nez p1, :cond_2

    new-instance p1, Lchat/ola/vn/view/i;

    invoke-direct {p1, p0}, Lchat/ola/vn/view/i;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->A:Lchat/ola/vn/view/i;

    iget-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->A:Lchat/ola/vn/view/i;

    invoke-virtual {p1, p0}, Lchat/ola/vn/view/i;->setOnStickerClickedListener(Lchat/ola/vn/view/i$e;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    :cond_2
    :try_start_3
    iget-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->C:Lchat/ola/vn/view/d;

    if-eqz p1, :cond_3

    iget-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->C:Lchat/ola/vn/view/d;

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->A:Lchat/ola/vn/view/i;

    if-eq p1, v0, :cond_7

    :cond_3
    iget-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->y:Landroid/widget/FrameLayout;

    invoke-virtual {p1}, Landroid/widget/FrameLayout;->removeAllViews()V

    iget-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->y:Landroid/widget/FrameLayout;

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->A:Lchat/ola/vn/view/i;

    invoke-virtual {p1, v0}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;)V

    iget-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->A:Lchat/ola/vn/view/i;
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_0

    goto :goto_0

    :pswitch_2
    :try_start_4
    invoke-direct {p0, v2}, Lchat/ola/vn/me/OlaMeComposerActivity;->e(Z)V

    invoke-direct {p0}, Lchat/ola/vn/me/OlaMeComposerActivity;->Z()V

    iget-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->z:Lchat/ola/vn/view/h;

    if-nez p1, :cond_4

    new-instance p1, Lchat/ola/vn/view/h;

    invoke-direct {p1, p0}, Lchat/ola/vn/view/h;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->z:Lchat/ola/vn/view/h;

    iget-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->z:Lchat/ola/vn/view/h;

    invoke-virtual {p1, p0}, Lchat/ola/vn/view/h;->setOlaSmileyListener(Lchat/ola/vn/view/h$b;)V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_2

    :cond_4
    :try_start_5
    iget-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->C:Lchat/ola/vn/view/d;

    if-eqz p1, :cond_5

    iget-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->C:Lchat/ola/vn/view/d;

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->z:Lchat/ola/vn/view/h;

    if-eq p1, v0, :cond_8

    :cond_5
    iget-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->y:Landroid/widget/FrameLayout;

    invoke-virtual {p1}, Landroid/widget/FrameLayout;->removeAllViews()V

    iget-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->y:Landroid/widget/FrameLayout;

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->z:Lchat/ola/vn/view/h;

    invoke-virtual {p1, v0}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;)V

    iget-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->z:Lchat/ola/vn/view/h;

    iput-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->C:Lchat/ola/vn/view/d;
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_1

    goto :goto_2

    :pswitch_3
    :try_start_6
    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->y:Landroid/widget/FrameLayout;

    invoke-virtual {v0}, Landroid/widget/FrameLayout;->removeAllViews()V

    invoke-direct {p0, v1}, Lchat/ola/vn/me/OlaMeComposerActivity;->e(Z)V

    if-eqz p1, :cond_6

    invoke-direct {p0}, Lchat/ola/vn/me/OlaMeComposerActivity;->Z()V

    goto :goto_2

    :cond_6
    invoke-direct {p0}, Lchat/ola/vn/me/OlaMeComposerActivity;->aa()V

    goto :goto_2

    :catch_0
    :cond_7
    :goto_1
    :pswitch_4
    const/4 v2, 0x0

    :catch_1
    :cond_8
    :goto_2
    if-eqz v2, :cond_9

    new-instance p1, Lchat/ola/vn/me/OlaMeComposerActivity$3;

    invoke-direct {p1, p0}, Lchat/ola/vn/me/OlaMeComposerActivity$3;-><init>(Lchat/ola/vn/me/OlaMeComposerActivity;)V

    invoke-static {p1}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_2

    :catch_2
    :cond_9
    return-void

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
        :pswitch_4
    .end packed-switch
.end method

.method static synthetic e(Lchat/ola/vn/me/OlaMeComposerActivity;)S
    .locals 0

    iget-short p0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->N:S

    return p0
.end method

.method private e(Z)V
    .locals 2

    if-eqz p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->y:Landroid/widget/FrameLayout;

    invoke-virtual {p1}, Landroid/widget/FrameLayout;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object p1

    iget v0, p1, Landroid/view/ViewGroup$LayoutParams;->height:I

    sget v1, Lchat/ola/vn/activity/OlaChatViewActivity;->g:I

    if-eq v0, v1, :cond_0

    sget v0, Lchat/ola/vn/activity/OlaChatViewActivity;->g:I

    iput v0, p1, Landroid/view/ViewGroup$LayoutParams;->height:I

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->y:Landroid/widget/FrameLayout;

    invoke-virtual {v0, p1}, Landroid/widget/FrameLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->y:Landroid/widget/FrameLayout;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/widget/FrameLayout;->setVisibility(I)V

    return-void

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->y:Landroid/widget/FrameLayout;

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/widget/FrameLayout;->setVisibility(I)V

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->y:Landroid/widget/FrameLayout;

    invoke-virtual {p1}, Landroid/widget/FrameLayout;->removeAllViews()V

    iget-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->C:Lchat/ola/vn/view/d;

    if-eqz p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->C:Lchat/ola/vn/view/d;

    invoke-virtual {p1}, Lchat/ola/vn/view/d;->a()V

    :cond_2
    const/4 p1, 0x0

    iput-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->C:Lchat/ola/vn/view/d;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic f(Lchat/ola/vn/me/OlaMeComposerActivity;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/me/OlaMeComposerActivity;->O()V

    return-void
.end method

.method static synthetic g(Lchat/ola/vn/me/OlaMeComposerActivity;)Lchat/ola/vn/view/OlaTypingSuggestedText;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->m:Lchat/ola/vn/view/OlaTypingSuggestedText;

    return-object p0
.end method

.method static synthetic h(Lchat/ola/vn/me/OlaMeComposerActivity;)Lchat/ola/vn/i/c;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->u:Lchat/ola/vn/i/c;

    return-object p0
.end method

.method static synthetic i(Lchat/ola/vn/me/OlaMeComposerActivity;)Landroid/view/View;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->k:Landroid/view/View;

    return-object p0
.end method

.method static synthetic j(Lchat/ola/vn/me/OlaMeComposerActivity;)I
    .locals 0

    iget p0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->f:I

    return p0
.end method

.method private m(Ljava/lang/String;)V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->m:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {v0}, Lchat/ola/vn/view/OlaTypingSuggestedText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->m:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {v1}, Lchat/ola/vn/view/OlaTypingSuggestedText;->getSelectionStart()I

    move-result v1

    if-ltz v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->m:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {v1}, Lchat/ola/vn/view/OlaTypingSuggestedText;->getSelectionStart()I

    move-result v1

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v1, p1}, Ljava/lang/StringBuilder;->insert(ILjava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->m:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {p0, v2}, Lchat/ola/vn/me/OlaMeComposerActivity;->n(Ljava/lang/String;)Ljava/lang/CharSequence;

    move-result-object v2

    invoke-virtual {v0, v2}, Lchat/ola/vn/view/OlaTypingSuggestedText;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->m:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v2

    add-int/2addr v1, v2

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaTypingSuggestedText;->setSelection(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->m:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {v0, p1}, Lchat/ola/vn/view/OlaTypingSuggestedText;->append(Ljava/lang/CharSequence;)V

    return-void
.end method

.method private n(Ljava/lang/String;)Ljava/lang/CharSequence;
    .locals 1

    const/4 v0, 0x0

    invoke-static {p1, v0}, Lchat/ola/vn/util/i;->a(Ljava/lang/String;Lcom/mg/ola/common/widget/OlaTextView$b;)Ljava/lang/CharSequence;

    move-result-object p1

    return-object p1
.end method


# virtual methods
.method public I()Z
    .locals 1

    invoke-direct {p0}, Lchat/ola/vn/me/OlaMeComposerActivity;->Q()V

    const/4 v0, 0x0

    iput v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->g:I

    invoke-direct {p0, v0}, Lchat/ola/vn/me/OlaMeComposerActivity;->d(Z)V

    const/4 v0, 0x1

    return v0
.end method

.method public J()Z
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->y:Landroid/widget/FrameLayout;

    invoke-virtual {v0}, Landroid/widget/FrameLayout;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    const/4 v1, -0x1

    iput v1, v0, Landroid/view/ViewGroup$LayoutParams;->height:I

    iget-object v1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->y:Landroid/widget/FrameLayout;

    invoke-virtual {v1, v0}, Landroid/widget/FrameLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    const/4 v0, 0x1

    return v0

    :catch_0
    const/4 v0, 0x0

    return v0
.end method

.method public K()Z
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->y:Landroid/widget/FrameLayout;

    invoke-virtual {v0}, Landroid/widget/FrameLayout;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    iget v1, v0, Landroid/view/ViewGroup$LayoutParams;->height:I

    sget v2, Lchat/ola/vn/activity/OlaChatViewActivity;->g:I

    if-eq v1, v2, :cond_0

    sget v1, Lchat/ola/vn/activity/OlaChatViewActivity;->g:I

    iput v1, v0, Landroid/view/ViewGroup$LayoutParams;->height:I

    iget-object v1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->y:Landroid/widget/FrameLayout;

    invoke-virtual {v1, v0}, Landroid/widget/FrameLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :cond_0
    const/4 v0, 0x1

    return v0

    :catch_0
    const/4 v0, 0x0

    return v0
.end method

.method public L()V
    .locals 4

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->m:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {v0}, Lchat/ola/vn/view/OlaTypingSuggestedText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->m:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {v1}, Lchat/ola/vn/view/OlaTypingSuggestedText;->getSelectionStart()I

    move-result v1

    if-ltz v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->m:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {v1}, Lchat/ola/vn/view/OlaTypingSuggestedText;->getSelectionStart()I

    move-result v1

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    if-lez v1, :cond_1

    add-int/lit8 v1, v1, -0x1

    :cond_1
    add-int/lit8 v0, v1, 0x1

    const-string v3, ""

    invoke-virtual {v2, v1, v0, v3}, Ljava/lang/StringBuilder;->replace(IILjava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->m:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Lchat/ola/vn/view/OlaTypingSuggestedText;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->m:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaTypingSuggestedText;->setSelection(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public M()V
    .locals 0

    return-void
.end method

.method protected a()V
    .locals 7

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/me/OlaMeComposerActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v0

    iget v0, v0, Landroid/content/res/Configuration;->orientation:I

    iput v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->X:I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    sget-wide v0, Lchat/ola/vn/me/OlaMeComposerActivity;->E:J

    const-wide/16 v2, 0x0

    cmp-long v4, v0, v2

    const/4 v0, 0x0

    const/16 v1, 0x8

    if-nez v4, :cond_2

    sget-boolean v2, Lchat/ola/vn/me/OlaMeComposerActivity;->F:Z

    if-eqz v2, :cond_0

    iget-object v2, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->Y:Landroid/view/View;

    invoke-virtual {v2, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->Z:Landroid/widget/CheckBox;

    invoke-virtual {v1, v0}, Landroid/widget/CheckBox;->setVisibility(I)V

    iget-object v1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->p:Landroid/widget/TextView;

    const v2, 0x7f0f062a

    goto :goto_0

    :cond_0
    iget-short v2, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->N:S

    const/16 v3, 0xa

    if-ne v2, v3, :cond_1

    iget-object v2, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->Y:Landroid/view/View;

    invoke-virtual {v2, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v2, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->Z:Landroid/widget/CheckBox;

    invoke-virtual {v2, v1}, Landroid/widget/CheckBox;->setVisibility(I)V

    iget-object v1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->p:Landroid/widget/TextView;

    const v2, 0x7f0f06bf

    goto :goto_0

    :cond_1
    iget-object v2, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->Y:Landroid/view/View;

    invoke-virtual {v2, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object v2, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->Z:Landroid/widget/CheckBox;

    invoke-virtual {v2, v1}, Landroid/widget/CheckBox;->setVisibility(I)V

    iget-object v1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->p:Landroid/widget/TextView;

    const v2, 0x7f0f05b2

    goto :goto_0

    :cond_2
    iget-object v2, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->Y:Landroid/view/View;

    invoke-virtual {v2, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object v2, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->Z:Landroid/widget/CheckBox;

    invoke-virtual {v2, v1}, Landroid/widget/CheckBox;->setVisibility(I)V

    iget-object v1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->p:Landroid/widget/TextView;

    const v2, 0x7f0f0489

    :goto_0
    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(I)V

    invoke-direct {p0}, Lchat/ola/vn/me/OlaMeComposerActivity;->O()V

    invoke-direct {p0}, Lchat/ola/vn/me/OlaMeComposerActivity;->G()V

    invoke-direct {p0}, Lchat/ola/vn/me/OlaMeComposerActivity;->N()V

    sget-object v1, Lchat/ola/vn/me/OlaMeComposerActivity;->L:Lchat/ola/vn/entity/OlaVenueEntity;

    if-nez v1, :cond_3

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v1

    invoke-virtual {v1}, Lchat/ola/vn/n/c;->f()Lchat/ola/vn/entity/OlaVenueEntity;

    move-result-object v1

    sput-object v1, Lchat/ola/vn/me/OlaMeComposerActivity;->L:Lchat/ola/vn/entity/OlaVenueEntity;

    :cond_3
    invoke-direct {p0}, Lchat/ola/vn/me/OlaMeComposerActivity;->H()V

    sget-object v1, Lchat/ola/vn/me/OlaMeComposerActivity;->L:Lchat/ola/vn/entity/OlaVenueEntity;

    if-nez v1, :cond_6

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    iget-wide v3, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->R:J

    sub-long v5, v1, v3

    const-wide/32 v1, 0x927c0

    cmp-long v3, v5, v1

    if-ltz v3, :cond_6

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v1

    invoke-virtual {v1}, Lchat/ola/vn/n/c;->e()Landroid/location/Location;

    move-result-object v1

    if-eqz v1, :cond_4

    invoke-virtual {v1}, Landroid/location/Location;->getAccuracy()F

    move-result v1

    const/high16 v2, 0x42480000    # 50.0f

    cmpg-float v1, v1, v2

    if-gtz v1, :cond_4

    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v1, p0}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/network/a/a/l$a;)V

    :cond_4
    invoke-static {p0}, Lchat/ola/vn/n/b;->b(Landroid/content/Context;)Z

    move-result v1

    if-nez v1, :cond_5

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    sget-wide v3, Lchat/ola/vn/me/OlaMeComposerActivity;->h:J

    sub-long v5, v1, v3

    const-wide/32 v1, 0xdbba0

    cmp-long v3, v5, v1

    if-ltz v3, :cond_6

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    sput-wide v1, Lchat/ola/vn/me/OlaMeComposerActivity;->h:J

    const/16 v1, 0x65

    invoke-static {p0, v1}, Lchat/ola/vn/n/b;->a(Landroid/app/Activity;I)V

    goto :goto_1

    :cond_5
    const-wide/16 v1, 0x3a98

    invoke-static {p0, v1, v2, p0}, Lchat/ola/vn/n/b;->b(Landroid/content/Context;JLchat/ola/vn/n/b$b;)V

    :cond_6
    :goto_1
    sget-boolean v1, Lchat/ola/vn/me/OlaMeComposerActivity;->e:Z

    if-eqz v1, :cond_7

    sput-boolean v0, Lchat/ola/vn/me/OlaMeComposerActivity;->e:Z

    new-instance v0, Lchat/ola/vn/me/OlaMeComposerActivity$17;

    invoke-direct {v0, p0}, Lchat/ola/vn/me/OlaMeComposerActivity$17;-><init>(Lchat/ola/vn/me/OlaMeComposerActivity;)V

    const-wide/16 v1, 0x3e8

    invoke-static {v0, v1, v2}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;J)V

    :cond_7
    return-void
.end method

.method public a(DDF)V
    .locals 0

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide p1

    iput-wide p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->R:J

    const/high16 p1, 0x42480000    # 50.0f

    cmpg-float p1, p5, p1

    if-gtz p1, :cond_0

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {p1, p0}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/network/a/a/l$a;)V

    :cond_0
    return-void
.end method

.method public a(ILjava/lang/String;)V
    .locals 0

    return-void
.end method

.method public a(Lchat/ola/vn/entity/w;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->O:Lchat/ola/vn/entity/w;

    invoke-direct {p0}, Lchat/ola/vn/me/OlaMeComposerActivity;->N()V

    return-void
.end method

.method public a(Ljava/lang/String;Lchat/ola/vn/entity/OlaVenueEntity;Lchat/ola/vn/entity/OlaCheckInActionEntity;Lchat/ola/vn/entity/OlaCheckInItemEntity;)V
    .locals 2

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->R:J

    iput-object p3, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->P:Lchat/ola/vn/entity/OlaCheckInActionEntity;

    iput-object p4, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->Q:Lchat/ola/vn/entity/OlaCheckInItemEntity;

    sput-object p2, Lchat/ola/vn/me/OlaMeComposerActivity;->L:Lchat/ola/vn/entity/OlaVenueEntity;

    sget-object p2, Lchat/ola/vn/me/OlaMeComposerActivity;->L:Lchat/ola/vn/entity/OlaVenueEntity;

    invoke-virtual {p2, p1}, Lchat/ola/vn/entity/OlaVenueEntity;->i(Ljava/lang/String;)V

    invoke-direct {p0}, Lchat/ola/vn/me/OlaMeComposerActivity;->H()V

    return-void
.end method

.method public a(Ljava/util/List;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/OlaVenueEntity;",
            ">;)V"
        }
    .end annotation

    const/4 v0, 0x0

    :try_start_0
    invoke-interface {p1, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/OlaVenueEntity;

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v0

    invoke-virtual {v0, p1}, Lchat/ola/vn/n/c;->b(Lchat/ola/vn/entity/OlaVenueEntity;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    sput-object v1, Lchat/ola/vn/me/OlaMeComposerActivity;->L:Lchat/ola/vn/entity/OlaVenueEntity;

    invoke-direct {p0}, Lchat/ola/vn/me/OlaMeComposerActivity;->H()V

    return-void

    :cond_0
    sget-object v0, Lchat/ola/vn/me/OlaMeComposerActivity;->L:Lchat/ola/vn/entity/OlaVenueEntity;

    if-nez v0, :cond_2

    sput-object p1, Lchat/ola/vn/me/OlaMeComposerActivity;->L:Lchat/ola/vn/entity/OlaVenueEntity;

    sget-object v0, Lchat/ola/vn/me/OlaMeComposerActivity;->L:Lchat/ola/vn/entity/OlaVenueEntity;

    invoke-virtual {v0}, Lchat/ola/vn/entity/OlaVenueEntity;->f()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    sget-object v0, Lchat/ola/vn/me/OlaMeComposerActivity;->L:Lchat/ola/vn/entity/OlaVenueEntity;

    invoke-virtual {v0}, Lchat/ola/vn/entity/OlaVenueEntity;->c()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    :cond_1
    sput-object v1, Lchat/ola/vn/me/OlaMeComposerActivity;->L:Lchat/ola/vn/entity/OlaVenueEntity;

    :cond_2
    if-eqz p1, :cond_3

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v0

    invoke-virtual {v0, p1}, Lchat/ola/vn/n/c;->a(Lchat/ola/vn/entity/OlaVenueEntity;)V

    :cond_3
    invoke-direct {p0}, Lchat/ola/vn/me/OlaMeComposerActivity;->H()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(ZI)V
    .locals 3

    const/4 v0, 0x0

    if-eqz p1, :cond_1

    iput v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->g:I

    invoke-direct {p0}, Lchat/ola/vn/me/OlaMeComposerActivity;->ab()V

    sget v1, Lchat/ola/vn/e;->d:I

    sget v2, Lchat/ola/vn/e;->e:I

    sub-int/2addr v1, v2

    sub-int/2addr v1, p2

    sget v2, Lchat/ola/vn/activity/OlaChatViewActivity;->g:I

    if-eq v2, v1, :cond_0

    sput v1, Lchat/ola/vn/activity/OlaChatViewActivity;->g:I

    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object v1

    sget v2, Lchat/ola/vn/activity/OlaChatViewActivity;->g:I

    invoke-virtual {v1, v2}, Lchat/ola/vn/e;->c(I)V

    :cond_0
    iput p2, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->f:I

    goto :goto_0

    :cond_1
    sget p2, Lchat/ola/vn/activity/OlaChatViewActivity;->g:I

    if-nez p2, :cond_2

    invoke-virtual {p0}, Lchat/ola/vn/me/OlaMeComposerActivity;->getResources()Landroid/content/res/Resources;

    move-result-object p2

    const v1, 0x7f07012a

    invoke-virtual {p2, v1}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result p2

    sput p2, Lchat/ola/vn/activity/OlaChatViewActivity;->g:I

    :cond_2
    :goto_0
    invoke-direct {p0, p1}, Lchat/ola/vn/me/OlaMeComposerActivity;->d(Z)V

    iget p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->g:I

    if-nez p1, :cond_3

    invoke-direct {p0, v0}, Lchat/ola/vn/me/OlaMeComposerActivity;->e(Z)V

    :cond_3
    return-void
.end method

.method public a_(Ljava/lang/String;)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->r:Lchat/ola/vn/b/s;

    invoke-virtual {v0, p1}, Lchat/ola/vn/b/s;->c(Ljava/lang/String;)V

    invoke-direct {p0}, Lchat/ola/vn/me/OlaMeComposerActivity;->G()V

    iget-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->r:Lchat/ola/vn/b/s;

    invoke-virtual {p1}, Lchat/ola/vn/b/s;->notifyDataSetChanged()V

    new-instance p1, Lchat/ola/vn/me/OlaMeComposerActivity$15;

    invoke-direct {p1, p0}, Lchat/ola/vn/me/OlaMeComposerActivity$15;-><init>(Lchat/ola/vn/me/OlaMeComposerActivity;)V

    invoke-static {p1}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public afterTextChanged(Landroid/text/Editable;)V
    .locals 0

    return-void
.end method

.method public b_(Ljava/lang/String;)V
    .locals 2

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->m:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {p1}, Lchat/ola/vn/view/OlaTypingSuggestedText;->getText()Landroid/text/Editable;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->m:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {v0}, Lchat/ola/vn/view/OlaTypingSuggestedText;->getSelectionStart()I

    move-result v0

    if-ltz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->m:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {v0}, Lchat/ola/vn/view/OlaTypingSuggestedText;->getSelectionStart()I

    move-result v0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1, p1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->m:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lchat/ola/vn/me/OlaMeComposerActivity;->n(Ljava/lang/String;)Ljava/lang/CharSequence;

    move-result-object v1

    invoke-virtual {p1, v1}, Lchat/ola/vn/view/OlaTypingSuggestedText;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->m:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {p1, v0}, Lchat/ola/vn/view/OlaTypingSuggestedText;->setSelection(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public beforeTextChanged(Ljava/lang/CharSequence;III)V
    .locals 0

    return-void
.end method

.method public d(Ljava/util/List;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    :try_start_0
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_0

    invoke-direct {p0}, Lchat/ola/vn/me/OlaMeComposerActivity;->ac()Z

    :cond_0
    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    iget-object v1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->r:Lchat/ola/vn/b/s;

    invoke-virtual {v1, v0}, Lchat/ola/vn/b/s;->a(Ljava/lang/String;)V

    goto :goto_0

    :cond_1
    invoke-direct {p0}, Lchat/ola/vn/me/OlaMeComposerActivity;->G()V

    iget-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->r:Lchat/ola/vn/b/s;

    invoke-virtual {p1}, Lchat/ola/vn/b/s;->notifyDataSetChanged()V

    new-instance p1, Lchat/ola/vn/me/OlaMeComposerActivity$10;

    invoke-direct {p1, p0}, Lchat/ola/vn/me/OlaMeComposerActivity$10;-><init>(Lchat/ola/vn/me/OlaMeComposerActivity;)V

    invoke-static {p1}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public e(Ljava/util/List;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    :try_start_0
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_0

    invoke-direct {p0}, Lchat/ola/vn/me/OlaMeComposerActivity;->ac()Z

    :cond_0
    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    iget-object v1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->r:Lchat/ola/vn/b/s;

    invoke-virtual {v1, v0}, Lchat/ola/vn/b/s;->b(Ljava/lang/String;)V

    goto :goto_0

    :cond_1
    invoke-direct {p0}, Lchat/ola/vn/me/OlaMeComposerActivity;->G()V

    iget-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->r:Lchat/ola/vn/b/s;

    invoke-virtual {p1}, Lchat/ola/vn/b/s;->notifyDataSetChanged()V

    new-instance p1, Lchat/ola/vn/me/OlaMeComposerActivity$11;

    invoke-direct {p1, p0}, Lchat/ola/vn/me/OlaMeComposerActivity$11;-><init>(Lchat/ola/vn/me/OlaMeComposerActivity;)V

    invoke-static {p1}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public f(Ljava/util/List;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    :try_start_0
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_0

    invoke-direct {p0}, Lchat/ola/vn/me/OlaMeComposerActivity;->ac()Z

    :cond_0
    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    iget-object v1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->r:Lchat/ola/vn/b/s;

    invoke-virtual {v1, v0}, Lchat/ola/vn/b/s;->c(Ljava/lang/String;)V

    goto :goto_0

    :cond_1
    invoke-direct {p0}, Lchat/ola/vn/me/OlaMeComposerActivity;->G()V

    iget-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->r:Lchat/ola/vn/b/s;

    invoke-virtual {p1}, Lchat/ola/vn/b/s;->notifyDataSetChanged()V

    new-instance p1, Lchat/ola/vn/me/OlaMeComposerActivity$13;

    invoke-direct {p1, p0}, Lchat/ola/vn/me/OlaMeComposerActivity$13;-><init>(Lchat/ola/vn/me/OlaMeComposerActivity;)V

    invoke-static {p1}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public finish()V
    .locals 2

    invoke-super {p0}, Lchat/ola/vn/c;->finish()V

    const v0, 0x7f01003c

    const v1, 0x7f010037

    :try_start_0
    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/me/OlaMeComposerActivity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public g(Ljava/lang/String;)V
    .locals 1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, " "

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Lchat/ola/vn/me/OlaMeComposerActivity;->m(Ljava/lang/String;)V

    return-void
.end method

.method public g(Ljava/util/List;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    :try_start_0
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_0

    invoke-direct {p0}, Lchat/ola/vn/me/OlaMeComposerActivity;->ac()Z

    :cond_0
    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    iget-object v1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->r:Lchat/ola/vn/b/s;

    invoke-virtual {v1, v0}, Lchat/ola/vn/b/s;->d(Ljava/lang/String;)V

    goto :goto_0

    :cond_1
    invoke-direct {p0}, Lchat/ola/vn/me/OlaMeComposerActivity;->G()V

    iget-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->r:Lchat/ola/vn/b/s;

    invoke-virtual {p1}, Lchat/ola/vn/b/s;->notifyDataSetChanged()V

    new-instance p1, Lchat/ola/vn/me/OlaMeComposerActivity$14;

    invoke-direct {p1, p0}, Lchat/ola/vn/me/OlaMeComposerActivity$14;-><init>(Lchat/ola/vn/me/OlaMeComposerActivity;)V

    invoke-static {p1}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public h(Ljava/lang/String;)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->r:Lchat/ola/vn/b/s;

    invoke-virtual {v0, p1}, Lchat/ola/vn/b/s;->c(Ljava/lang/String;)V

    invoke-direct {p0}, Lchat/ola/vn/me/OlaMeComposerActivity;->G()V

    iget-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->r:Lchat/ola/vn/b/s;

    invoke-virtual {p1}, Lchat/ola/vn/b/s;->notifyDataSetChanged()V

    new-instance p1, Lchat/ola/vn/me/OlaMeComposerActivity$6;

    invoke-direct {p1, p0}, Lchat/ola/vn/me/OlaMeComposerActivity$6;-><init>(Lchat/ola/vn/me/OlaMeComposerActivity;)V

    invoke-static {p1}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public h(Ljava/lang/String;S)V
    .locals 0

    invoke-virtual {p0, p1}, Lchat/ola/vn/me/OlaMeComposerActivity;->a_(Ljava/lang/String;)V

    return-void
.end method

.method public h(Ljava/util/List;)V
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;)V"
        }
    .end annotation

    :try_start_0
    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/message/f;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, " @"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lchat/ola/vn/me/OlaMeComposerActivity;->m(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    :cond_0
    return-void
.end method

.method public i(Ljava/lang/String;)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->r:Lchat/ola/vn/b/s;

    invoke-virtual {v0, p1}, Lchat/ola/vn/b/s;->d(Ljava/lang/String;)V

    invoke-direct {p0}, Lchat/ola/vn/me/OlaMeComposerActivity;->G()V

    iget-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->r:Lchat/ola/vn/b/s;

    invoke-virtual {p1}, Lchat/ola/vn/b/s;->notifyDataSetChanged()V

    new-instance p1, Lchat/ola/vn/me/OlaMeComposerActivity$7;

    invoke-direct {p1, p0}, Lchat/ola/vn/me/OlaMeComposerActivity$7;-><init>(Lchat/ola/vn/me/OlaMeComposerActivity;)V

    invoke-static {p1}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public j(Ljava/lang/String;)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->r:Lchat/ola/vn/b/s;

    invoke-virtual {v0, p1}, Lchat/ola/vn/b/s;->a(Ljava/lang/String;)V

    invoke-direct {p0}, Lchat/ola/vn/me/OlaMeComposerActivity;->G()V

    iget-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->r:Lchat/ola/vn/b/s;

    invoke-virtual {p1}, Lchat/ola/vn/b/s;->notifyDataSetChanged()V

    new-instance p1, Lchat/ola/vn/me/OlaMeComposerActivity$8;

    invoke-direct {p1, p0}, Lchat/ola/vn/me/OlaMeComposerActivity$8;-><init>(Lchat/ola/vn/me/OlaMeComposerActivity;)V

    invoke-static {p1}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public j_()V
    .locals 0

    return-void
.end method

.method public k(Ljava/lang/String;)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->r:Lchat/ola/vn/b/s;

    invoke-virtual {v0, p1}, Lchat/ola/vn/b/s;->b(Ljava/lang/String;)V

    invoke-direct {p0}, Lchat/ola/vn/me/OlaMeComposerActivity;->G()V

    iget-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->r:Lchat/ola/vn/b/s;

    invoke-virtual {p1}, Lchat/ola/vn/b/s;->notifyDataSetChanged()V

    new-instance p1, Lchat/ola/vn/me/OlaMeComposerActivity$9;

    invoke-direct {p1, p0}, Lchat/ola/vn/me/OlaMeComposerActivity$9;-><init>(Lchat/ola/vn/me/OlaMeComposerActivity;)V

    invoke-static {p1}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public k_()V
    .locals 0

    return-void
.end method

.method public l(Ljava/lang/String;)V
    .locals 0

    return-void
.end method

.method public l_()V
    .locals 0

    return-void
.end method

.method public m_()V
    .locals 0

    return-void
.end method

.method protected onActivityResult(IILandroid/content/Intent;)V
    .locals 2

    const/4 v0, 0x2

    const/4 v1, -0x1

    if-ne p1, v0, :cond_0

    if-ne p2, v1, :cond_2

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->D:Ljava/io/File;

    if-eqz p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->D:Ljava/io/File;

    invoke-virtual {p1}, Ljava/io/File;->exists()Z

    move-result p1

    if-eqz p1, :cond_2

    new-instance p1, Ljava/io/File;

    iget-object p2, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->D:Ljava/io/File;

    invoke-virtual {p2}, Ljava/io/File;->length()J

    move-result-wide p2

    invoke-static {p2, p3}, Lchat/ola/vn/d;->a(J)Ljava/lang/String;

    move-result-object p2

    invoke-direct {p1, p2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    iget-object p2, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->D:Ljava/io/File;

    const/4 p3, 0x1

    invoke-static {p2, p1, p3}, Lcom/mg/ola/common/d/c;->a(Ljava/io/File;Ljava/io/File;Z)V

    iget-object p2, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->D:Ljava/io/File;

    invoke-virtual {p2}, Ljava/io/File;->delete()Z

    invoke-virtual {p1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Lchat/ola/vn/me/OlaMeComposerActivity;->a_(Ljava/lang/String;)V

    goto :goto_1

    :cond_0
    const/4 v0, 0x3

    if-ne p1, v0, :cond_2

    if-ne p2, v1, :cond_2

    const-string p1, "all_path"

    invoke-virtual {p3, p1}, Landroid/content/Intent;->getStringArrayExtra(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object p1

    if-eqz p1, :cond_2

    array-length p2, p1

    if-lez p2, :cond_2

    new-instance p2, Ljava/util/ArrayList;

    array-length p3, p1

    invoke-direct {p2, p3}, Ljava/util/ArrayList;-><init>(I)V

    const/4 p3, 0x0

    :goto_0
    array-length v0, p1

    if-ge p3, v0, :cond_1

    aget-object v0, p1, p3

    invoke-interface {p2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 p3, p3, 0x1

    goto :goto_0

    :cond_1
    invoke-virtual {p0, p2}, Lchat/ola/vn/me/OlaMeComposerActivity;->f(Ljava/util/List;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_2
    :goto_1
    const/4 p1, 0x0

    iput-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->D:Ljava/io/File;

    return-void
.end method

.method public onBackPressed()V
    .locals 1

    invoke-direct {p0}, Lchat/ola/vn/me/OlaMeComposerActivity;->ac()Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    invoke-super {p0}, Lchat/ola/vn/c;->onBackPressed()V

    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 1

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const/4 v0, 0x0

    sparse-switch p1, :sswitch_data_0

    return-void

    :sswitch_0
    invoke-static {p0, p0}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->b(Landroid/content/Context;Lchat/ola/vn/contactpicker/OlaContactPickerActivity$b;)V

    return-void

    :sswitch_1
    invoke-direct {p0}, Lchat/ola/vn/me/OlaMeComposerActivity;->U()V

    return-void

    :sswitch_2
    invoke-direct {p0}, Lchat/ola/vn/me/OlaMeComposerActivity;->P()V

    return-void

    :sswitch_3
    invoke-direct {p0}, Lchat/ola/vn/me/OlaMeComposerActivity;->V()V

    return-void

    :sswitch_4
    invoke-virtual {p0}, Lchat/ola/vn/me/OlaMeComposerActivity;->onBackPressed()V

    return-void

    :sswitch_5
    invoke-direct {p0}, Lchat/ola/vn/me/OlaMeComposerActivity;->X()V

    return-void

    :sswitch_6
    invoke-direct {p0}, Lchat/ola/vn/me/OlaMeComposerActivity;->S()V

    return-void

    :sswitch_7
    invoke-direct {p0, v0}, Lchat/ola/vn/me/OlaMeComposerActivity;->c(Z)V

    const/4 p1, 0x2

    iput p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->g:I

    iget-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->l:Lcom/mg/ola/common/widget/SoftKeyLinearLayout;

    invoke-virtual {p1}, Lcom/mg/ola/common/widget/SoftKeyLinearLayout;->a()Z

    move-result p1

    if-nez p1, :cond_3

    :goto_0
    invoke-direct {p0, v0}, Lchat/ola/vn/me/OlaMeComposerActivity;->d(Z)V

    return-void

    :sswitch_8
    sget-object p1, Lchat/ola/vn/me/OlaMeComposerActivity;->M:Lchat/ola/vn/entity/z;

    if-eqz p1, :cond_2

    sget-object p1, Lchat/ola/vn/me/OlaMeComposerActivity;->M:Lchat/ola/vn/entity/z;

    iget-object p1, p1, Lchat/ola/vn/entity/z;->a:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_2

    sget-object p1, Lchat/ola/vn/me/OlaMeComposerActivity;->M:Lchat/ola/vn/entity/z;

    iget-object p1, p1, Lchat/ola/vn/entity/z;->a:Ljava/lang/String;

    sget-object v0, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {p1, v0}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object p1

    const-string v0, "http"

    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_1

    sget-object p1, Lchat/ola/vn/me/OlaMeComposerActivity;->M:Lchat/ola/vn/entity/z;

    iget-object p1, p1, Lchat/ola/vn/entity/z;->b:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_0

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object p1

    sget-object v0, Lchat/ola/vn/me/OlaMeComposerActivity;->M:Lchat/ola/vn/entity/z;

    iget-object v0, v0, Lchat/ola/vn/entity/z;->b:Ljava/lang/String;

    :goto_1
    invoke-static {p1, v0}, Lchat/ola/vn/util/b;->o(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :cond_0
    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object p1

    sget-object v0, Lchat/ola/vn/me/OlaMeComposerActivity;->M:Lchat/ola/vn/entity/z;

    iget-object v0, v0, Lchat/ola/vn/entity/z;->a:Ljava/lang/String;

    goto :goto_1

    :cond_1
    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object p1

    sget-object v0, Lchat/ola/vn/me/OlaMeComposerActivity;->M:Lchat/ola/vn/entity/z;

    iget-object v0, v0, Lchat/ola/vn/entity/z;->a:Ljava/lang/String;

    invoke-static {p1, v0}, Lchat/ola/vn/m/j;->a(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :cond_2
    sget-object p1, Lchat/ola/vn/me/OlaMeComposerActivity;->L:Lchat/ola/vn/entity/OlaVenueEntity;

    if-eqz p1, :cond_3

    sget-object p1, Lchat/ola/vn/me/OlaMeComposerActivity;->L:Lchat/ola/vn/entity/OlaVenueEntity;

    invoke-virtual {p1}, Lchat/ola/vn/entity/OlaVenueEntity;->b()Ljava/lang/String;

    move-result-object p1

    invoke-static {p0, p1}, Lchat/ola/vn/checkin/OlaVenueDetailActivity;->a(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :sswitch_9
    const/4 p1, 0x0

    sput-object p1, Lchat/ola/vn/me/OlaMeComposerActivity;->L:Lchat/ola/vn/entity/OlaVenueEntity;

    invoke-direct {p0}, Lchat/ola/vn/me/OlaMeComposerActivity;->H()V

    return-void

    :sswitch_a
    invoke-direct {p0, v0}, Lchat/ola/vn/me/OlaMeComposerActivity;->c(Z)V

    const/4 p1, 0x1

    iput p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->g:I

    iget-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->l:Lcom/mg/ola/common/widget/SoftKeyLinearLayout;

    invoke-virtual {p1}, Lcom/mg/ola/common/widget/SoftKeyLinearLayout;->a()Z

    move-result p1

    if-nez p1, :cond_3

    goto :goto_0

    :sswitch_b
    invoke-direct {p0}, Lchat/ola/vn/me/OlaMeComposerActivity;->R()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_3
    return-void

    :sswitch_data_0
    .sparse-switch
        0x7f090143 -> :sswitch_b
        0x7f09015c -> :sswitch_a
        0x7f0902b6 -> :sswitch_9
        0x7f0902bb -> :sswitch_8
        0x7f0902c8 -> :sswitch_7
        0x7f090310 -> :sswitch_6
        0x7f090360 -> :sswitch_5
        0x7f09039c -> :sswitch_4
        0x7f09039e -> :sswitch_3
        0x7f0903e1 -> :sswitch_2
        0x7f09049c -> :sswitch_1
        0x7f090600 -> :sswitch_0
    .end sparse-switch
.end method

.method public onConfigurationChanged(Landroid/content/res/Configuration;)V
    .locals 2

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onConfigurationChanged(Landroid/content/res/Configuration;)V

    iget v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->X:I

    iget v1, p1, Landroid/content/res/Configuration;->orientation:I

    if-eq v0, v1, :cond_0

    iget p1, p1, Landroid/content/res/Configuration;->orientation:I

    iput p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->X:I

    :cond_0
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 2

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    const p1, 0x7f0b015b

    invoke-virtual {p0, p1}, Lchat/ola/vn/me/OlaMeComposerActivity;->setContentView(I)V

    const p1, 0x7f010021

    invoke-static {p0, p1}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->i:Landroid/view/animation/Animation;

    iget-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->i:Landroid/view/animation/Animation;

    const-wide/16 v0, 0x12c

    invoke-virtual {p1, v0, v1}, Landroid/view/animation/Animation;->setDuration(J)V

    const p1, 0x7f010024

    invoke-static {p0, p1}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->j:Landroid/view/animation/Animation;

    iget-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->j:Landroid/view/animation/Animation;

    invoke-virtual {p1, v0, v1}, Landroid/view/animation/Animation;->setDuration(J)V

    sget-short p1, Lchat/ola/vn/c/x;->j:S

    iput-short p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->N:S

    invoke-direct {p0}, Lchat/ola/vn/me/OlaMeComposerActivity;->C()V

    return-void
.end method

.method protected onPause()V
    .locals 1

    invoke-super {p0}, Lchat/ola/vn/c;->onPause()V

    :try_start_0
    iget-boolean v0, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->W:Z

    if-nez v0, :cond_0

    invoke-direct {p0}, Lchat/ola/vn/me/OlaMeComposerActivity;->T()Lchat/ola/vn/me/a;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    :try_start_1
    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/e;->f()S

    move-result v0

    sput-short v0, Lchat/ola/vn/c/x;->j:S
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    return-void
.end method

.method public onRequestPermissionsResult(I[Ljava/lang/String;[I)V
    .locals 1

    const/4 p2, 0x0

    const/16 v0, 0x67

    if-ne p1, v0, :cond_0

    aget p1, p3, p2

    if-nez p1, :cond_1

    invoke-static {p0, p0}, Lchat/ola/vn/cloud/OlaLocalPhotoChooserActivity;->a(Landroid/content/Context;Lchat/ola/vn/view/g$e;)V

    return-void

    :cond_0
    const/16 v0, 0x65

    if-ne p1, v0, :cond_1

    aget p1, p3, p2

    if-nez p1, :cond_1

    const-wide/16 p1, 0x3a98

    invoke-static {p0, p1, p2, p0}, Lchat/ola/vn/n/b;->b(Landroid/content/Context;JLchat/ola/vn/n/b$b;)V

    :cond_1
    return-void
.end method

.method public onTextChanged(Ljava/lang/CharSequence;III)V
    .locals 6

    const/4 p2, 0x5

    if-le p4, p2, :cond_b

    :try_start_0
    invoke-interface {p1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/i;->b(Ljava/lang/CharSequence;)Ljava/util/ArrayList;

    move-result-object p2

    if-eqz p2, :cond_9

    invoke-interface {p2}, Ljava/util/List;->size()I

    move-result p3

    if-lez p3, :cond_9

    const-string p3, ""

    invoke-static {p1, p3}, Lchat/ola/vn/util/i;->d(Ljava/lang/CharSequence;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p3

    invoke-virtual {p3}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p3

    invoke-interface {p2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p2

    const/4 v0, 0x0

    const/4 v1, 0x0

    :goto_0
    invoke-interface {p2}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_4

    invoke-interface {p2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    invoke-static {v2}, Lchat/ola/vn/entity/i;->i(Ljava/lang/String;)C

    move-result v3

    const/4 v4, 0x1

    if-ne v3, v4, :cond_1

    invoke-static {v2}, Lchat/ola/vn/entity/w;->b(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_0

    iget-object v1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->r:Lchat/ola/vn/b/s;

    invoke-virtual {v1, v2}, Lchat/ola/vn/b/s;->a(Ljava/lang/String;)V

    :goto_1
    const/4 v1, 0x1

    goto :goto_0

    :cond_0
    new-instance v3, Lchat/ola/vn/entity/w;

    invoke-direct {v3}, Lchat/ola/vn/entity/w;-><init>()V

    iput-object v3, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->O:Lchat/ola/vn/entity/w;

    iget-object v3, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->O:Lchat/ola/vn/entity/w;

    invoke-virtual {v3, v2}, Lchat/ola/vn/entity/w;->a(Ljava/lang/String;)V

    goto :goto_0

    :cond_1
    invoke-static {v2}, Lchat/ola/vn/entity/i;->i(Ljava/lang/String;)C

    move-result v3

    const/4 v5, 0x2

    if-ne v3, v5, :cond_2

    iget-object v1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->r:Lchat/ola/vn/b/s;

    invoke-virtual {v1, v2}, Lchat/ola/vn/b/s;->b(Ljava/lang/String;)V

    goto :goto_1

    :cond_2
    invoke-static {p3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_3

    new-instance p3, Ljava/lang/StringBuilder;

    invoke-direct {p3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "##"

    invoke-virtual {p3, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, "#"

    invoke-virtual {p3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p3

    goto :goto_0

    :cond_3
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p3, " ##"

    invoke-virtual {v3, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p3, "#"

    invoke-virtual {v3, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p3

    goto :goto_0

    :cond_4
    invoke-static {p3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p2

    if-nez p2, :cond_5

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p3, " "

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p3

    :cond_5
    invoke-direct {p0}, Lchat/ola/vn/me/OlaMeComposerActivity;->G()V

    if-eqz v1, :cond_6

    iget-object p2, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->r:Lchat/ola/vn/b/s;

    invoke-virtual {p2}, Lchat/ola/vn/b/s;->notifyDataSetChanged()V

    invoke-direct {p0}, Lchat/ola/vn/me/OlaMeComposerActivity;->ac()Z

    :cond_6
    invoke-direct {p0}, Lchat/ola/vn/me/OlaMeComposerActivity;->N()V

    new-instance p2, Lchat/ola/vn/me/OlaMeComposerActivity$18;

    invoke-direct {p2, p0}, Lchat/ola/vn/me/OlaMeComposerActivity$18;-><init>(Lchat/ola/vn/me/OlaMeComposerActivity;)V

    invoke-static {p2}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    iget-object p2, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->m:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {p2, p0}, Lchat/ola/vn/view/OlaTypingSuggestedText;->removeTextChangedListener(Landroid/text/TextWatcher;)V

    iget-object p2, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->m:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {p2}, Lchat/ola/vn/view/OlaTypingSuggestedText;->getSelectionStart()I

    move-result p2

    if-ltz p2, :cond_7

    iget-object p2, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->m:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {p2}, Lchat/ola/vn/view/OlaTypingSuggestedText;->getSelectionStart()I

    move-result v0

    :cond_7
    iget-object p2, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->m:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-direct {p0, p3}, Lchat/ola/vn/me/OlaMeComposerActivity;->n(Ljava/lang/String;)Ljava/lang/CharSequence;

    move-result-object v1

    invoke-virtual {p2, v1}, Lchat/ola/vn/view/OlaTypingSuggestedText;->setText(Ljava/lang/CharSequence;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    add-int/2addr v0, p4

    :try_start_1
    invoke-virtual {p3}, Ljava/lang/String;->length()I

    move-result p2

    if-le v0, p2, :cond_8

    invoke-virtual {p3}, Ljava/lang/String;->length()I

    move-result v0

    :cond_8
    iget-object p2, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->m:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {p2, v0}, Lchat/ola/vn/view/OlaTypingSuggestedText;->setSelection(I)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :try_start_2
    iget-object p2, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->m:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {p2, p0}, Lchat/ola/vn/view/OlaTypingSuggestedText;->addTextChangedListener(Landroid/text/TextWatcher;)V

    :cond_9
    invoke-static {p1}, Lchat/ola/vn/util/i;->e(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p3

    if-nez p3, :cond_a

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    new-instance p3, Lchat/ola/vn/me/OlaMeComposerActivity$19;

    invoke-direct {p3, p0}, Lchat/ola/vn/me/OlaMeComposerActivity$19;-><init>(Lchat/ola/vn/me/OlaMeComposerActivity;)V

    invoke-virtual {p1, p2, p3}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Lchat/ola/vn/p/l;)V

    return-void

    :cond_a
    invoke-static {p1}, Lchat/ola/vn/util/i;->f(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p2

    if-nez p2, :cond_b

    sget-object p2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    new-instance p3, Lchat/ola/vn/me/OlaMeComposerActivity$20;

    invoke-direct {p3, p0}, Lchat/ola/vn/me/OlaMeComposerActivity$20;-><init>(Lchat/ola/vn/me/OlaMeComposerActivity;)V

    invoke-virtual {p2, p1, p3}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Lchat/ola/vn/network/a/a/aj$a;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    :cond_b
    return-void
.end method

.method public onTouch(Landroid/view/View;Landroid/view/MotionEvent;)Z
    .locals 2
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "ClickableViewAccessibility"
        }
    .end annotation

    invoke-virtual {p2}, Landroid/view/MotionEvent;->getAction()I

    move-result v0

    const/4 v1, 0x0

    if-nez v0, :cond_4

    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const v0, 0x7f090336

    if-eq p1, v0, :cond_2

    const v0, 0x7f0903a1

    if-eq p1, v0, :cond_0

    return v1

    :cond_0
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getAction()I

    move-result p1

    if-nez p1, :cond_4

    iget p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->g:I

    if-nez p1, :cond_1

    :goto_0
    invoke-direct {p0, v1}, Lchat/ola/vn/me/OlaMeComposerActivity;->c(Z)V

    return v1

    :cond_1
    iput v1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->g:I

    invoke-direct {p0, v1}, Lchat/ola/vn/me/OlaMeComposerActivity;->d(Z)V

    return v1

    :cond_2
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getAction()I

    move-result p1

    if-nez p1, :cond_4

    iget-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->l:Lcom/mg/ola/common/widget/SoftKeyLinearLayout;

    invoke-virtual {p1}, Lcom/mg/ola/common/widget/SoftKeyLinearLayout;->a()Z

    move-result p1

    if-eqz p1, :cond_3

    iget p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity;->g:I

    if-nez p1, :cond_1

    goto :goto_0

    :cond_3
    const/4 p1, 0x1

    invoke-direct {p0, p1}, Lchat/ola/vn/me/OlaMeComposerActivity;->c(Z)V

    :cond_4
    return v1
.end method
