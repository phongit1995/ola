.class public Lchat/ola/vn/activity/OlaChatViewActivity;
.super Lchat/ola/vn/c;

# interfaces
.implements Landroid/text/TextWatcher;
.implements Landroid/view/View$OnClickListener;
.implements Landroid/view/View$OnLongClickListener;
.implements Landroid/view/View$OnTouchListener;
.implements Landroid/widget/AbsListView$OnScrollListener;
.implements Landroid/widget/AdapterView$OnItemClickListener;
.implements Lchat/ola/vn/activity/OlaCropImageActivity$a;
.implements Lchat/ola/vn/contactpicker/OlaContactPickerActivity$b;
.implements Lchat/ola/vn/f/a;
.implements Lchat/ola/vn/p/f;
.implements Lchat/ola/vn/view/e$a;
.implements Lchat/ola/vn/view/f$a;
.implements Lchat/ola/vn/view/g$e;
.implements Lchat/ola/vn/view/h$b;
.implements Lchat/ola/vn/view/i$e;
.implements Lchat/ola/vn/view/j$a;
.implements Lcom/mg/ola/common/widget/a/a;


# static fields
.field private static Z:Lchat/ola/vn/entity/n;

.field public static e:Ljava/lang/String;

.field public static f:S

.field public static g:I


# instance fields
.field private A:Landroid/widget/TextView;

.field private B:Landroid/view/animation/Animation;

.field private C:Lchat/ola/vn/message/f;

.field private D:Landroid/view/View;

.field private E:Ljava/lang/String;

.field private F:Landroid/os/Handler;

.field private G:Ljava/lang/Runnable;

.field private H:J

.field private I:Landroid/widget/ListView;

.field private J:Landroid/widget/ListView;

.field private K:Lchat/ola/vn/b/r;

.field private L:Lchat/ola/vn/b/z;

.field private M:Lcom/mg/ola/common/widget/SoftKeyLinearLayout;

.field private N:Landroid/support/v4/widget/DrawerLayout;

.field private O:Lchat/ola/vn/b/n;

.field private P:Landroid/widget/TextView;

.field private Q:Landroid/widget/ImageButton;

.field private R:Landroid/widget/TextView;

.field private S:Landroid/view/animation/Animation;

.field private T:Landroid/view/animation/Animation;

.field private U:Landroid/view/View;

.field private V:Landroid/widget/ImageView;

.field private W:Landroid/widget/ImageView;

.field private X:Lchat/ola/vn/util/d/a;

.field private Y:Landroid/view/View;

.field private aA:Z

.field private aa:Z

.field private ab:Z

.field private ac:Landroid/widget/TextView;

.field private ad:Landroid/view/View;

.field private ae:I

.field private af:Landroid/view/View;

.field private ag:Lchat/ola/vn/view/h;

.field private ah:Lchat/ola/vn/view/i;

.field private ai:Lchat/ola/vn/view/g;

.field private aj:Lchat/ola/vn/view/j;

.field private ak:Lchat/ola/vn/view/f;

.field private al:Lchat/ola/vn/view/d;

.field private am:I

.field private an:I

.field private ao:I

.field private ap:Landroid/widget/ImageButton;

.field private aq:Landroid/widget/ImageButton;

.field private ar:Landroid/widget/ImageButton;

.field private as:Landroid/widget/ImageButton;

.field private at:Landroid/widget/ImageButton;

.field private au:Landroid/widget/ImageButton;

.field private av:Landroid/widget/FrameLayout;

.field private aw:I

.field private ax:Ljava/io/File;

.field private ay:Lchat/ola/vn/i/c;

.field private az:I

.field protected h:Landroid/graphics/drawable/Drawable;

.field protected i:Z

.field j:I

.field k:I

.field l:I

.field private o:Lchat/ola/vn/b/o;

.field private p:Landroid/widget/ListView;

.field private q:Landroid/widget/EditText;

.field private r:Landroid/widget/TextView;

.field private s:Landroid/widget/ImageView;

.field private t:Landroid/widget/FrameLayout;

.field private u:Landroid/widget/Button;

.field private v:Landroid/widget/ImageButton;

.field private w:Landroid/widget/TextView;

.field private x:Landroid/widget/TextView;

.field private y:Landroid/widget/TextView;

.field private z:Lchat/ola/vn/i/c;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 3

    invoke-direct {p0}, Lchat/ola/vn/c;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->E:Ljava/lang/String;

    const-wide/16 v1, 0x0

    iput-wide v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->H:J

    const/4 v1, 0x0

    iput-boolean v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->aa:Z

    iput-boolean v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ab:Z

    iput v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ae:I

    iput-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ag:Lchat/ola/vn/view/h;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ah:Lchat/ola/vn/view/i;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ai:Lchat/ola/vn/view/g;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->aj:Lchat/ola/vn/view/j;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ak:Lchat/ola/vn/view/f;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->al:Lchat/ola/vn/view/d;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->h:Landroid/graphics/drawable/Drawable;

    iput-boolean v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->i:Z

    iput v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->j:I

    iput v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->k:I

    iput v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->l:I

    iput v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->aw:I

    iput-boolean v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->aA:Z

    return-void
.end method

.method private R()V
    .locals 2

    const v0, 0x7f09014f

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->af:Landroid/view/View;

    const v0, 0x7f09014e

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/FrameLayout;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->av:Landroid/widget/FrameLayout;

    const v0, 0x7f0903fb

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageButton;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ap:Landroid/widget/ImageButton;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ap:Landroid/widget/ImageButton;

    invoke-virtual {v0, p0}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ap:Landroid/widget/ImageButton;

    invoke-virtual {v0, p0}, Landroid/widget/ImageButton;->setOnLongClickListener(Landroid/view/View$OnLongClickListener;)V

    sget-boolean v0, Lchat/ola/vn/c/x;->y:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ap:Landroid/widget/ImageButton;

    const/4 v1, 0x0

    :goto_0
    invoke-virtual {v0, v1}, Landroid/widget/ImageButton;->setVisibility(I)V

    goto :goto_1

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ap:Landroid/widget/ImageButton;

    const/16 v1, 0x8

    goto :goto_0

    :goto_1
    const v0, 0x7f09015c

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageButton;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->aq:Landroid/widget/ImageButton;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->aq:Landroid/widget/ImageButton;

    invoke-virtual {v0, p0}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f090143

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnLongClickListener(Landroid/view/View$OnLongClickListener;)V

    const v0, 0x7f0902c8

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageButton;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ar:Landroid/widget/ImageButton;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ar:Landroid/widget/ImageButton;

    invoke-virtual {v0, p0}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f090310

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageButton;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->as:Landroid/widget/ImageButton;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->as:Landroid/widget/ImageButton;

    invoke-virtual {v0, p0}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f090600

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageButton;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->at:Landroid/widget/ImageButton;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->at:Landroid/widget/ImageButton;

    invoke-virtual {v0, p0}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f090360

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageButton;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->au:Landroid/widget/ImageButton;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->au:Landroid/widget/ImageButton;

    invoke-virtual {v0, p0}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    return-void
.end method

.method private S()V
    .locals 1

    iget-boolean v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->aa:Z

    if-eqz v0, :cond_1

    invoke-static {}, Lchat/ola/vn/c/x;->e()Z

    move-result v0

    if-eqz v0, :cond_0

    sget-object v0, Lchat/ola/vn/util/c/a;->t:Landroid/net/Uri;

    invoke-static {p0, v0}, Lchat/ola/vn/util/n;->a(Landroid/content/Context;Landroid/net/Uri;)Z

    :cond_0
    iget-boolean v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->aa:Z

    xor-int/lit8 v0, v0, 0x1

    iput-boolean v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->aa:Z

    :cond_1
    return-void
.end method

.method private T()V
    .locals 6
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "ResourceAsColor"
        }
    .end annotation

    const v0, 0x7f09015d

    :try_start_0
    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/FrameLayout;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->t:Landroid/widget/FrameLayout;

    const v0, 0x7f090152

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/support/v4/widget/DrawerLayout;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->N:Landroid/support/v4/widget/DrawerLayout;

    const v0, 0x7f0902d1

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    const v1, 0x7f0902cf

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/ListView;

    iput-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->I:Landroid/widget/ListView;

    const v1, 0x7f0902ce

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->R:Landroid/widget/TextView;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->I:Landroid/widget/ListView;

    invoke-virtual {v0, p0}, Landroid/widget/ListView;->setOnItemClickListener(Landroid/widget/AdapterView$OnItemClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->R:Landroid/widget/TextView;

    const v1, 0x7f0f00e2

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    const v0, 0x7f090423

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    const v1, 0x7f090421

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/ListView;

    iput-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->J:Landroid/widget/ListView;

    const v1, 0x7f090420

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->P:Landroid/widget/TextView;

    const v1, 0x7f09041f

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageButton;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->Q:Landroid/widget/ImageButton;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->Q:Landroid/widget/ImageButton;

    invoke-virtual {v0, p0}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->J:Landroid/widget/ListView;

    invoke-virtual {v0, p0}, Landroid/widget/ListView;->setOnItemClickListener(Landroid/widget/AdapterView$OnItemClickListener;)V

    new-instance v0, Lchat/ola/vn/b/n;

    invoke-direct {v0, p0}, Lchat/ola/vn/b/n;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->O:Lchat/ola/vn/b/n;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->J:Landroid/widget/ListView;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->O:Lchat/ola/vn/b/n;

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setAdapter(Landroid/widget/ListAdapter;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->P:Landroid/widget/TextView;

    const v1, 0x7f0f046a

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    const v0, 0x7f09048c

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lcom/mg/ola/common/widget/SoftKeyLinearLayout;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->M:Lcom/mg/ola/common/widget/SoftKeyLinearLayout;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->M:Lcom/mg/ola/common/widget/SoftKeyLinearLayout;

    invoke-virtual {v0, p0}, Lcom/mg/ola/common/widget/SoftKeyLinearLayout;->setOnSoftKeyboardListener(Lcom/mg/ola/common/widget/a/a;)V

    const v0, 0x7f0903a4

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f0905ef

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->W:Landroid/widget/ImageView;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->W:Landroid/widget/ImageView;

    invoke-virtual {v0, p0}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f0903a3

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->x:Landroid/widget/TextView;

    const v0, 0x7f0903a2

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->y:Landroid/widget/TextView;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->y:Landroid/widget/TextView;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    const v0, 0x7f0903a1

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->D:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->D:Landroid/view/View;

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->D:Landroid/view/View;

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V

    const v0, 0x7f09039b

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->w:Landroid/widget/TextView;

    const v0, 0x7f090564

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->A:Landroid/widget/TextView;

    const v0, 0x7f090313

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ListView;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->p:Landroid/widget/ListView;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->p:Landroid/widget/ListView;

    invoke-virtual {v0, p0}, Landroid/widget/ListView;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->p:Landroid/widget/ListView;

    new-instance v2, Landroid/graphics/drawable/ColorDrawable;

    const/4 v3, 0x0

    invoke-direct {v2, v3}, Landroid/graphics/drawable/ColorDrawable;-><init>(I)V

    invoke-virtual {v0, v2}, Landroid/widget/ListView;->setSelector(Landroid/graphics/drawable/Drawable;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->p:Landroid/widget/ListView;

    invoke-virtual {v0, p0}, Landroid/widget/ListView;->setOnScrollListener(Landroid/widget/AbsListView$OnScrollListener;)V

    invoke-static {p0}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v0

    const v2, 0x7f0b00d1

    const/4 v4, 0x0

    invoke-virtual {v0, v2, v4}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->Y:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->Y:Landroid/view/View;

    invoke-virtual {v0, v3}, Landroid/view/View;->setBackgroundColor(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->Y:Landroid/view/View;

    new-instance v2, Landroid/widget/AbsListView$LayoutParams;

    const/4 v3, -0x1

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v4

    const v5, 0x7f07013d

    invoke-virtual {v4, v5}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v4

    const/4 v5, 0x2

    sub-int/2addr v4, v5

    invoke-direct {v2, v3, v4}, Landroid/widget/AbsListView$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v2}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    new-instance v0, Landroid/view/View;

    invoke-direct {v0, p0}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    new-instance v2, Landroid/widget/AbsListView$LayoutParams;

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v3

    const v4, 0x7f0700ec

    invoke-virtual {v3, v4}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v3

    invoke-direct {v2, v5, v3}, Landroid/widget/AbsListView$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v2}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    iget-object v2, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->p:Landroid/widget/ListView;

    invoke-virtual {v2, v0}, Landroid/widget/ListView;->addFooterView(Landroid/view/View;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->p:Landroid/widget/ListView;

    invoke-virtual {v0, v5}, Landroid/widget/ListView;->setTranscriptMode(I)V

    const v0, 0x7f09039d

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->V:Landroid/widget/ImageView;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->V:Landroid/widget/ImageView;

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->V:Landroid/widget/ImageView;

    invoke-virtual {v0, p0}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f09059d

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->U:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->U:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    const v0, 0x7f09059e

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->r:Landroid/widget/TextView;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->r:Landroid/widget/TextView;

    const/4 v1, 0x4

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    const v0, 0x7f090276

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->s:Landroid/widget/ImageView;

    const v0, 0x7f090466

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->u:Landroid/widget/Button;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->u:Landroid/widget/Button;

    const v1, 0x7f0f0612

    invoke-virtual {p0, v1}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    sget-object v2, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v1, v2}, Ljava/lang/String;->toUpperCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->u:Landroid/widget/Button;

    invoke-virtual {v0, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f0902d3

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageButton;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->v:Landroid/widget/ImageButton;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->v:Landroid/widget/ImageButton;

    invoke-virtual {v0, p0}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->v:Landroid/widget/ImageButton;

    invoke-virtual {v0, p0}, Landroid/widget/ImageButton;->setOnLongClickListener(Landroid/view/View$OnLongClickListener;)V

    const v0, 0x7f090157

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->q:Landroid/widget/EditText;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->q:Landroid/widget/EditText;

    invoke-virtual {v0, p0}, Landroid/widget/EditText;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->q:Landroid/widget/EditText;

    new-instance v1, Lchat/ola/vn/activity/OlaChatViewActivity$39;

    invoke-direct {v1, p0}, Lchat/ola/vn/activity/OlaChatViewActivity$39;-><init>(Lchat/ola/vn/activity/OlaChatViewActivity;)V

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setOnEditorActionListener(Landroid/widget/TextView$OnEditorActionListener;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->q:Landroid/widget/EditText;

    new-instance v1, Lchat/ola/vn/activity/OlaChatViewActivity$40;

    invoke-direct {v1, p0}, Lchat/ola/vn/activity/OlaChatViewActivity$40;-><init>(Lchat/ola/vn/activity/OlaChatViewActivity;)V

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setOnKeyListener(Landroid/view/View$OnKeyListener;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->A:Landroid/widget/TextView;

    invoke-virtual {v0, p0}, Landroid/widget/TextView;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V

    const v0, 0x7f09039a

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->p:Landroid/widget/ListView;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->Y:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->addHeaderView(Landroid/view/View;)V

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->am()V

    const v0, 0x7f090560

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ac:Landroid/widget/TextView;

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->R()V

    const v0, 0x7f090447

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ad:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ad:Landroid/view/View;

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method private U()V
    .locals 3

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/4 v1, 0x0

    const/16 v2, 0x17

    if-lt v0, v2, :cond_0

    const-string v0, "android.permission.READ_EXTERNAL_STORAGE"

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->checkSelfPermission(Ljava/lang/String;)I

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    new-array v0, v0, [Ljava/lang/String;

    const-string v2, "android.permission.READ_EXTERNAL_STORAGE"

    aput-object v2, v0, v1

    const/16 v1, 0x67

    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/activity/OlaChatViewActivity;->requestPermissions([Ljava/lang/String;I)V

    return-void

    :cond_0
    invoke-direct {p0, v1}, Lchat/ola/vn/activity/OlaChatViewActivity;->f(Z)V

    const/4 v0, 0x3

    iput v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ae:I

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->M:Lcom/mg/ola/common/widget/SoftKeyLinearLayout;

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/SoftKeyLinearLayout;->a()Z

    move-result v0

    if-nez v0, :cond_1

    invoke-direct {p0, v1}, Lchat/ola/vn/activity/OlaChatViewActivity;->j(Z)V

    :cond_1
    return-void
.end method

.method private V()V
    .locals 7

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    iget-object v0, v0, Lchat/ola/vn/message/f;->J:Ljava/lang/Long;

    const/4 v1, 0x1

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    const/4 v2, 0x0

    iput-object v2, v0, Lchat/ola/vn/message/f;->J:Ljava/lang/Long;

    invoke-direct {p0, v1}, Lchat/ola/vn/activity/OlaChatViewActivity;->d(Z)V

    return-void

    :cond_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iget-object v2, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    iget-object v2, v2, Lchat/ola/vn/message/f;->J:Ljava/lang/Long;

    if-eqz v2, :cond_1

    iget-object v2, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    iget-object v2, v2, Lchat/ola/vn/message/f;->J:Ljava/lang/Long;

    invoke-virtual {v2}, Ljava/lang/Long;->longValue()J

    move-result-wide v2

    const-wide v4, 0x7fffffffffffffffL

    cmp-long v6, v2, v4

    if-nez v6, :cond_1

    const v1, 0x7f0f065d

    invoke-virtual {p0, v1}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    :goto_0
    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_1

    :cond_1
    const v2, 0x7f0f04fe

    new-array v3, v1, [Ljava/lang/Object;

    const-string v4, "15"

    const/4 v5, 0x0

    aput-object v4, v3, v5

    invoke-virtual {p0, v2, v3}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v2, 0x7f0f04fb

    new-array v3, v1, [Ljava/lang/Object;

    const-string v4, "1"

    aput-object v4, v3, v5

    invoke-virtual {p0, v2, v3}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-array v2, v1, [Ljava/lang/Object;

    const-string v3, "8"

    aput-object v3, v2, v5

    const v3, 0x7f0f04fc

    invoke-virtual {p0, v3, v2}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-array v1, v1, [Ljava/lang/Object;

    const-string v2, "24"

    aput-object v2, v1, v5

    invoke-virtual {p0, v3, v1}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v1, 0x7f0f056f

    invoke-virtual {p0, v1}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    goto :goto_0

    :goto_1
    new-instance v1, Lchat/ola/vn/i/m;

    invoke-direct {v1, p0}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    const v2, 0x7f0f056e

    invoke-virtual {v1, v2}, Lchat/ola/vn/i/m;->setTitle(I)V

    invoke-virtual {v1, v0}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance v0, Lchat/ola/vn/activity/OlaChatViewActivity$4;

    invoke-direct {v0, p0}, Lchat/ola/vn/activity/OlaChatViewActivity$4;-><init>(Lchat/ola/vn/activity/OlaChatViewActivity;)V

    invoke-virtual {v1, v0}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {v1}, Lchat/ola/vn/i/m;->show()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private W()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->N:Landroid/support/v4/widget/DrawerLayout;

    const/4 v1, 0x3

    invoke-virtual {v0, v1}, Landroid/support/v4/widget/DrawerLayout;->closeDrawer(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->N:Landroid/support/v4/widget/DrawerLayout;

    const/4 v1, 0x5

    invoke-virtual {v0, v1}, Landroid/support/v4/widget/DrawerLayout;->closeDrawer(I)V

    return-void
.end method

.method private X()V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->o:Lchat/ola/vn/b/o;

    invoke-virtual {v0}, Lchat/ola/vn/b/o;->notifyDataSetChanged()V

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->ae()V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->q:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-direct {p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->b(Ljava/lang/CharSequence;)V

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->ac()V

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->Z()V

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->aa()V

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->ab()V

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->am()V

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->Y()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private Y()V
    .locals 4

    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->k()S

    move-result v1

    const/4 v2, 0x4

    const/16 v3, 0x8

    if-eq v1, v2, :cond_0

    packed-switch v1, :pswitch_data_0

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->af:Landroid/view/View;

    invoke-virtual {v1, v0}, Landroid/view/View;->setVisibility(I)V

    :goto_0
    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->au:Landroid/widget/ImageButton;

    invoke-virtual {v1, v0}, Landroid/widget/ImageButton;->setVisibility(I)V

    return-void

    :pswitch_0
    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->af:Landroid/view/View;

    invoke-virtual {v1, v0}, Landroid/view/View;->setVisibility(I)V

    goto :goto_0

    :pswitch_1
    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->af:Landroid/view/View;

    invoke-virtual {v1, v3}, Landroid/view/View;->setVisibility(I)V

    return-void

    :cond_0
    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->af:Landroid/view/View;

    invoke-virtual {v1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->au:Landroid/widget/ImageButton;

    invoke-virtual {v1, v3}, Landroid/widget/ImageButton;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->af:Landroid/view/View;

    invoke-virtual {v1, v0}, Landroid/view/View;->setVisibility(I)V

    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private Z()V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->k()S

    move-result v0

    packed-switch v0, :pswitch_data_0

    :pswitch_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->o:Lchat/ola/vn/b/o;

    invoke-virtual {v0}, Lchat/ola/vn/b/o;->notifyDataSetChanged()V

    return-void

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_0
        :pswitch_0
    .end packed-switch
.end method

.method static synthetic a(Lchat/ola/vn/activity/OlaChatViewActivity;)Lchat/ola/vn/message/f;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    return-object p0
.end method

.method public static a(Landroid/content/Context;Lchat/ola/vn/network/OlaNetworkService;Lchat/ola/vn/message/f;)V
    .locals 4

    if-nez p2, :cond_0

    return-void

    :cond_0
    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {p2}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p2}, Lchat/ola/vn/message/f;->k()S

    move-result v2

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/message/g;->d(Ljava/lang/String;S)Lchat/ola/vn/message/f;

    move-result-object v0

    const/4 v1, 0x4

    const/4 v2, 0x1

    if-nez v0, :cond_2

    const/4 v0, 0x0

    if-eqz p1, :cond_1

    invoke-virtual {p2}, Lchat/ola/vn/message/f;->k()S

    move-result v3

    if-eq v3, v1, :cond_1

    invoke-virtual {p2}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Lchat/ola/vn/network/OlaNetworkService;->c(Ljava/lang/String;)V

    const/4 v0, 0x1

    :cond_1
    sget-object p1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {p2}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p2}, Lchat/ola/vn/message/f;->k()S

    move-result v3

    invoke-virtual {p1, v1, v3, v2}, Lchat/ola/vn/message/g;->b(Ljava/lang/String;SZ)Lchat/ola/vn/message/f;

    move-result-object p1

    invoke-virtual {p1, v0}, Lchat/ola/vn/message/f;->b(Z)V

    goto :goto_0

    :cond_2
    invoke-virtual {v0}, Lchat/ola/vn/message/f;->S()Z

    move-result v3

    if-nez v3, :cond_4

    if-eqz p1, :cond_4

    invoke-virtual {p2}, Lchat/ola/vn/message/f;->k()S

    move-result v3

    if-eq v3, v1, :cond_3

    invoke-virtual {p2}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v1}, Lchat/ola/vn/network/OlaNetworkService;->c(Ljava/lang/String;)V

    :cond_3
    invoke-virtual {v0, v2}, Lchat/ola/vn/message/f;->b(Z)V

    :cond_4
    move-object p1, v0

    :goto_0
    invoke-virtual {p1, p2}, Lchat/ola/vn/message/f;->b(Lchat/ola/vn/message/f;)V

    new-instance p2, Landroid/content/Intent;

    const-class v0, Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-direct {p2, p0, v0}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lchat/ola/vn/activity/OlaChatViewActivity;->e:Ljava/lang/String;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->k()S

    move-result p1

    sput-short p1, Lchat/ola/vn/activity/OlaChatViewActivity;->f:S

    :try_start_0
    invoke-virtual {p0, p2}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    const/high16 p1, 0x10000000

    invoke-virtual {p2, p1}, Landroid/content/Intent;->setFlags(I)Landroid/content/Intent;

    invoke-virtual {p0, p2}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    :goto_1
    :try_start_1
    check-cast p0, Landroid/app/Activity;

    const p1, 0x7f010038

    const p2, 0x7f010039

    invoke-virtual {p0, p1, p2}, Landroid/app/Activity;->overridePendingTransition(II)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    return-void
.end method

.method public static a(Landroid/content/Context;Lchat/ola/vn/network/OlaNetworkService;Lchat/ola/vn/message/f;Lchat/ola/vn/entity/n;)V
    .locals 0

    if-nez p2, :cond_0

    return-void

    :cond_0
    sput-object p3, Lchat/ola/vn/activity/OlaChatViewActivity;->Z:Lchat/ola/vn/entity/n;

    new-instance p1, Landroid/content/Intent;

    const-class p3, Lchat/ola/vn/activity/OlaChatViewActivity;

    invoke-direct {p1, p0, p3}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p2}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object p3

    sput-object p3, Lchat/ola/vn/activity/OlaChatViewActivity;->e:Ljava/lang/String;

    invoke-virtual {p2}, Lchat/ola/vn/message/f;->k()S

    move-result p2

    sput-short p2, Lchat/ola/vn/activity/OlaChatViewActivity;->f:S

    :try_start_0
    invoke-virtual {p0, p1}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    const/high16 p2, 0x10000000

    invoke-virtual {p1, p2}, Landroid/content/Intent;->setFlags(I)Landroid/content/Intent;

    invoke-virtual {p0, p1}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    :goto_0
    :try_start_1
    check-cast p0, Landroid/app/Activity;

    const p1, 0x7f010038

    const p2, 0x7f010039

    invoke-virtual {p0, p1, p2}, Landroid/app/Activity;->overridePendingTransition(II)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    return-void
.end method

.method public static a(Landroid/content/Context;Lchat/ola/vn/network/OlaNetworkService;Ljava/lang/String;S)V
    .locals 2

    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    const/4 v1, 0x1

    invoke-virtual {v0, p2, p3, v1}, Lchat/ola/vn/message/g;->b(Ljava/lang/String;SZ)Lchat/ola/vn/message/f;

    move-result-object p2

    invoke-static {p0, p1, p2}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Landroid/content/Context;Lchat/ola/vn/network/OlaNetworkService;Lchat/ola/vn/message/f;)V

    return-void
.end method

.method public static a(Landroid/content/Context;Ljava/lang/String;)V
    .locals 2

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    const/4 v1, 0x0

    invoke-static {p0, v0, p1, v1}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Landroid/content/Context;Lchat/ola/vn/network/OlaNetworkService;Ljava/lang/String;S)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/activity/OlaChatViewActivity;Lchat/ola/vn/message/d;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/activity/OlaChatViewActivity;->c(Lchat/ola/vn/message/d;)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/activity/OlaChatViewActivity;Lchat/ola/vn/message/f;Ljava/lang/String;ILjava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1, p2, p3, p4}, Lchat/ola/vn/activity/OlaChatViewActivity;->b(Lchat/ola/vn/message/f;Ljava/lang/String;ILjava/lang/String;)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/activity/OlaChatViewActivity;Ljava/lang/Runnable;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/activity/OlaChatViewActivity;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/activity/OlaChatViewActivity;->m(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/activity/OlaChatViewActivity;Ljava/lang/String;IZ)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Ljava/lang/String;IZ)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/activity/OlaChatViewActivity;Z)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/activity/OlaChatViewActivity;->e(Z)V

    return-void
.end method

.method private a(Lchat/ola/vn/message/f;)V
    .locals 6

    if-nez p1, :cond_0

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->finish()V

    return-void

    :catch_0
    move-exception p1

    goto/16 :goto_2

    :cond_0
    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->k()S

    move-result v2

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/message/g;->d(Ljava/lang/String;S)Lchat/ola/vn/message/f;

    move-result-object v0

    if-nez v0, :cond_1

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v0, p1}, Lchat/ola/vn/message/g;->c(Lchat/ola/vn/message/f;)Lchat/ola/vn/message/f;

    move-result-object p1

    :cond_1
    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->ad()V

    iget-object v0, p1, Lchat/ola/vn/message/f;->F:Ljava/lang/Boolean;

    if-nez v0, :cond_2

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->k()S

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    if-nez v0, :cond_2

    :try_start_1
    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Lchat/ola/vn/activity/OlaChatViewActivity$34;

    invoke-direct {v2, p0}, Lchat/ola/vn/activity/OlaChatViewActivity$34;-><init>(Lchat/ola/vn/activity/OlaChatViewActivity;)V

    invoke-static {v2}, Lchat/ola/vn/entry/c/f;->a(Lchat/ola/vn/entry/c/e;)S

    move-result v2

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/network/OlaNetworkService;->p(Ljava/lang/String;S)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    :cond_2
    :try_start_2
    iput-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->o:Lchat/ola/vn/b/o;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {p1, v0}, Lchat/ola/vn/b/o;->a(Lchat/ola/vn/message/f;)V

    sget-object p1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {p1}, Lchat/ola/vn/message/g;->t()V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Lchat/ola/vn/message/f;->a(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->A()V

    invoke-direct {p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->e(Z)V

    invoke-static {}, Lchat/ola/vn/h;->g()Z

    move-result p1

    const/4 v1, 0x2

    const/4 v2, 0x1

    if-eqz p1, :cond_7

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    iget-byte p1, p1, Lchat/ola/vn/message/f;->V:B

    if-nez p1, :cond_7

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_7

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->k()S

    move-result p1

    const/4 v3, 0x0

    if-ne p1, v1, :cond_4

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->X()Z

    move-result p1
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    if-nez p1, :cond_4

    :try_start_3
    invoke-direct {p0, v2}, Lchat/ola/vn/activity/OlaChatViewActivity;->e(Z)V

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v4, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v4}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v4

    new-instance v5, Lchat/ola/vn/activity/OlaChatViewActivity$36;

    invoke-direct {v5, p0}, Lchat/ola/vn/activity/OlaChatViewActivity$36;-><init>(Lchat/ola/vn/activity/OlaChatViewActivity;)V

    invoke-static {v5}, Lchat/ola/vn/entry/c/f;->a(Lchat/ola/vn/entry/c/e;)S

    move-result v5

    invoke-virtual {p1, v4, v3, v5}, Lchat/ola/vn/network/OlaNetworkService;->h(Ljava/lang/String;Ljava/lang/String;S)Z

    move-result p1

    if-eqz p1, :cond_3

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    iput-byte v2, p1, Lchat/ola/vn/message/f;->V:B

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    iput-object v3, p1, Lchat/ola/vn/message/f;->O:Ljava/lang/String;

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    iput-boolean v2, p1, Lchat/ola/vn/message/f;->Q:Z

    goto :goto_0

    :cond_3
    invoke-direct {p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->e(Z)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_2

    goto :goto_0

    :catch_2
    :try_start_4
    invoke-direct {p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->e(Z)V

    goto :goto_0

    :cond_4
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->k()S

    move-result p1
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_0

    if-nez p1, :cond_6

    :try_start_5
    invoke-direct {p0, v2}, Lchat/ola/vn/activity/OlaChatViewActivity;->e(Z)V

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v4, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v4}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v4

    new-instance v5, Lchat/ola/vn/activity/OlaChatViewActivity$37;

    invoke-direct {v5, p0}, Lchat/ola/vn/activity/OlaChatViewActivity$37;-><init>(Lchat/ola/vn/activity/OlaChatViewActivity;)V

    invoke-static {v5}, Lchat/ola/vn/entry/c/f;->a(Lchat/ola/vn/entry/c/e;)S

    move-result v5

    invoke-virtual {p1, v4, v3, v5}, Lchat/ola/vn/network/OlaNetworkService;->i(Ljava/lang/String;Ljava/lang/String;S)Z

    move-result p1

    if-eqz p1, :cond_5

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    iput-byte v2, p1, Lchat/ola/vn/message/f;->V:B

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    iput-object v3, p1, Lchat/ola/vn/message/f;->O:Ljava/lang/String;

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    iput-boolean v2, p1, Lchat/ola/vn/message/f;->Q:Z

    goto :goto_0

    :cond_5
    invoke-direct {p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->e(Z)V
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_2

    goto :goto_0

    :cond_6
    :try_start_6
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    iput-byte v1, p1, Lchat/ola/vn/message/f;->V:B

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    iput-object v3, p1, Lchat/ola/vn/message/f;->O:Ljava/lang/String;

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    iput-boolean v0, p1, Lchat/ola/vn/message/f;->Q:Z

    :cond_7
    :goto_0
    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->X()V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->Q:Landroid/widget/ImageButton;

    const/16 v3, 0x8

    invoke-virtual {p1, v3}, Landroid/widget/ImageButton;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->k()S

    move-result p1

    const v3, 0x7f0f00e2

    if-eqz p1, :cond_a

    if-eq p1, v1, :cond_9

    const/4 v1, 0x4

    if-eq p1, v1, :cond_8

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->R:Landroid/widget/TextView;

    invoke-virtual {p1, v3}, Landroid/widget/TextView;->setText(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->I:Landroid/widget/ListView;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->K:Lchat/ola/vn/b/r;

    invoke-virtual {p1, v0}, Landroid/widget/ListView;->setAdapter(Landroid/widget/ListAdapter;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->K:Lchat/ola/vn/b/r;

    invoke-virtual {p1}, Lchat/ola/vn/b/r;->notifyDataSetChanged()V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->q:Landroid/widget/EditText;

    const v0, 0x7f0f06bb

    invoke-virtual {p1, v0}, Landroid/widget/EditText;->setHint(I)V

    return-void

    :cond_8
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->P:Landroid/widget/TextView;

    const v1, 0x7f0f0442

    invoke-virtual {p1, v1}, Landroid/widget/TextView;->setText(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->q:Landroid/widget/EditText;

    const v1, 0x7f0f06bd

    new-array v2, v2, [Ljava/lang/Object;

    iget-object v3, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v3}, Lchat/ola/vn/message/f;->b()Ljava/lang/String;

    move-result-object v3

    aput-object v3, v2, v0

    invoke-virtual {p0, v1, v2}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    :goto_1
    invoke-virtual {p1, v0}, Landroid/widget/EditText;->setHint(Ljava/lang/CharSequence;)V

    return-void

    :cond_9
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->R:Landroid/widget/TextView;

    invoke-virtual {p1, v3}, Landroid/widget/TextView;->setText(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->P:Landroid/widget/TextView;

    const v1, 0x7f0f0565

    invoke-virtual {p1, v1}, Landroid/widget/TextView;->setText(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->Q:Landroid/widget/ImageButton;

    invoke-virtual {p1, v0}, Landroid/widget/ImageButton;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->I:Landroid/widget/ListView;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->K:Lchat/ola/vn/b/r;

    invoke-virtual {p1, v1}, Landroid/widget/ListView;->setAdapter(Landroid/widget/ListAdapter;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->K:Lchat/ola/vn/b/r;

    invoke-virtual {p1}, Lchat/ola/vn/b/r;->notifyDataSetChanged()V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->q:Landroid/widget/EditText;

    const v1, 0x7f0f06bc

    new-array v2, v2, [Ljava/lang/Object;

    iget-object v3, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v3}, Lchat/ola/vn/message/f;->L()Ljava/lang/CharSequence;

    move-result-object v3

    aput-object v3, v2, v0

    invoke-virtual {p0, v1, v2}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_1

    :cond_a
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->R:Landroid/widget/TextView;

    invoke-virtual {p1, v3}, Landroid/widget/TextView;->setText(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->I:Landroid/widget/ListView;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->K:Lchat/ola/vn/b/r;

    invoke-virtual {p1, v1}, Landroid/widget/ListView;->setAdapter(Landroid/widget/ListAdapter;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->K:Lchat/ola/vn/b/r;

    invoke-virtual {p1}, Lchat/ola/vn/b/r;->notifyDataSetChanged()V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->Q:Landroid/widget/ImageButton;

    invoke-virtual {p1, v0}, Landroid/widget/ImageButton;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->q:Landroid/widget/EditText;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const v1, 0x7f0f06be

    invoke-virtual {p0, v1}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, " "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_0

    goto :goto_1

    :goto_2
    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method private a(Lchat/ola/vn/message/f;Ljava/lang/String;ILjava/lang/String;)V
    .locals 7

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->k()S

    move-result v0

    const/4 v1, 0x2

    if-ne v0, v1, :cond_1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->X()Z

    move-result v0

    if-eqz v0, :cond_1

    new-instance v0, Lchat/ola/vn/activity/OlaChatViewActivity$10;

    move-object v1, v0

    move-object v2, p0

    move-object v3, p1

    move-object v4, p2

    move v5, p3

    move-object v6, p4

    invoke-direct/range {v1 .. v6}, Lchat/ola/vn/activity/OlaChatViewActivity$10;-><init>(Lchat/ola/vn/activity/OlaChatViewActivity;Lchat/ola/vn/message/f;Ljava/lang/String;ILjava/lang/String;)V

    invoke-direct {p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Ljava/lang/Runnable;)V

    return-void

    :cond_1
    invoke-direct {p0, p1, p2, p3, p4}, Lchat/ola/vn/activity/OlaChatViewActivity;->b(Lchat/ola/vn/message/f;Ljava/lang/String;ILjava/lang/String;)V

    return-void
.end method

.method private a(Ljava/lang/CharSequence;)V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->q:Landroid/widget/EditText;

    invoke-virtual {v0, p0}, Landroid/widget/EditText;->removeTextChangedListener(Landroid/text/TextWatcher;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->q:Landroid/widget/EditText;

    invoke-virtual {v0, p1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->q:Landroid/widget/EditText;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->q:Landroid/widget/EditText;

    invoke-virtual {v1}, Landroid/widget/EditText;->length()I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setSelection(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->q:Landroid/widget/EditText;

    invoke-virtual {v0, p0}, Landroid/widget/EditText;->addTextChangedListener(Landroid/text/TextWatcher;)V

    invoke-direct {p0, p1}, Lchat/ola/vn/activity/OlaChatViewActivity;->b(Ljava/lang/CharSequence;)V

    return-void
.end method

.method private a(Ljava/lang/Runnable;)V
    .locals 7

    const v0, 0x7f0f05ad

    :try_start_0
    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object v0

    const v1, 0x7f0f0209

    invoke-virtual {p0, v1}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {p0, v0, v1}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/app/ProgressDialog;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->F()Ljava/util/List;

    move-result-object v1

    const/4 v2, 0x0

    const v3, 0x7f0f0466

    invoke-static {v3}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v4

    if-eqz v1, :cond_0

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v5

    if-lez v5, :cond_0

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {v3}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v3, " "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v3

    const/4 v4, 0x1

    add-int/2addr v3, v4

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v3, " "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v3, 0x7f0f0566

    invoke-static {v3}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v3

    sget-object v5, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v3, v5}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v3

    new-array v3, v3, [Ljava/lang/String;

    const/4 v5, 0x0

    invoke-interface {v1, v5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lchat/ola/vn/message/f;

    invoke-virtual {v6}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v6

    aput-object v6, v3, v5

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v5

    :goto_0
    if-ge v4, v5, :cond_1

    invoke-interface {v1, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lchat/ola/vn/message/f;

    invoke-virtual {v6}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v6

    aput-object v6, v3, v4

    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    :cond_0
    move-object v3, v2

    move-object v2, v4

    :cond_1
    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v4, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v4}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v4

    new-instance v5, Lchat/ola/vn/activity/OlaChatViewActivity$33;

    invoke-direct {v5, p0, v0, p1}, Lchat/ola/vn/activity/OlaChatViewActivity$33;-><init>(Lchat/ola/vn/activity/OlaChatViewActivity;Landroid/app/ProgressDialog;Ljava/lang/Runnable;)V

    invoke-static {v5}, Lchat/ola/vn/entry/c/f;->a(Lchat/ola/vn/entry/c/e;)S

    move-result p1

    invoke-virtual {v1, v4, v2, v3, p1}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;S)V

    invoke-virtual {v0}, Landroid/app/ProgressDialog;->show()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private a(Ljava/lang/String;IZ)V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->k()S

    move-result v0

    const/4 v1, 0x2

    if-ne v0, v1, :cond_1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->X()Z

    move-result v0

    if-eqz v0, :cond_1

    new-instance v0, Lchat/ola/vn/activity/OlaChatViewActivity$8;

    invoke-direct {v0, p0, p1, p2, p3}, Lchat/ola/vn/activity/OlaChatViewActivity$8;-><init>(Lchat/ola/vn/activity/OlaChatViewActivity;Ljava/lang/String;IZ)V

    invoke-direct {p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Ljava/lang/Runnable;)V

    return-void

    :cond_1
    invoke-direct {p0, p1, p2, p3}, Lchat/ola/vn/activity/OlaChatViewActivity;->b(Ljava/lang/String;IZ)V

    return-void
.end method

.method private aa()V
    .locals 0

    return-void
.end method

.method private ab()V
    .locals 1

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    if-eqz v0, :cond_0

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v0}, Lchat/ola/vn/message/g;->q()I

    move-result v0

    :goto_0
    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->c(I)V

    return-void

    :cond_0
    const/4 v0, 0x0

    goto :goto_0

    return-void
.end method

.method private ac()V
    .locals 12

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->W:Landroid/widget/ImageView;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->k()S

    move-result v0

    const/4 v2, 0x4

    const/4 v3, 0x5

    const/4 v4, 0x1

    const/4 v5, 0x0

    if-eq v0, v2, :cond_d

    packed-switch v0, :pswitch_data_0

    invoke-direct {p0, v5}, Lchat/ola/vn/activity/OlaChatViewActivity;->d(Z)V

    :goto_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->D:Landroid/view/View;

    invoke-virtual {v0, v5}, Landroid/view/View;->setVisibility(I)V

    return-void

    :pswitch_0
    invoke-direct {p0, v4}, Lchat/ola/vn/activity/OlaChatViewActivity;->d(Z)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->L()Ljava/lang/CharSequence;

    move-result-object v0

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->x:Landroid/widget/TextView;

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->F()Ljava/util/List;

    move-result-object v0

    if-eqz v0, :cond_2

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v1

    if-nez v1, :cond_0

    goto :goto_1

    :cond_0
    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->y:Landroid/widget/TextView;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v4

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v4, " "

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v4, 0x7f0f0566

    invoke-static {v4}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v4

    sget-object v6, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v4, v6}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->y:Landroid/widget/TextView;

    invoke-virtual {v1}, Landroid/widget/TextView;->getVisibility()I

    move-result v1

    if-eqz v1, :cond_1

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->y:Landroid/widget/TextView;

    invoke-virtual {v1, v5}, Landroid/widget/TextView;->setVisibility(I)V

    :cond_1
    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->O:Lchat/ola/vn/b/n;

    invoke-virtual {v1, v0}, Lchat/ola/vn/b/n;->a(Ljava/util/List;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->O:Lchat/ola/vn/b/n;

    invoke-virtual {v0}, Lchat/ola/vn/b/n;->notifyDataSetChanged()V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->N:Landroid/support/v4/widget/DrawerLayout;

    invoke-virtual {v0, v5, v3}, Landroid/support/v4/widget/DrawerLayout;->setDrawerLockMode(II)V

    goto :goto_0

    :cond_2
    :goto_1
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->y:Landroid/widget/TextView;

    const v1, 0x7f0f0466

    invoke-static {v1}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->y:Landroid/widget/TextView;

    invoke-virtual {v0}, Landroid/widget/TextView;->getVisibility()I

    move-result v0

    if-eqz v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->y:Landroid/widget/TextView;

    invoke-virtual {v0, v5}, Landroid/widget/TextView;->setVisibility(I)V

    :cond_3
    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1, v5}, Lchat/ola/vn/network/OlaNetworkService;->g(Ljava/lang/String;S)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->N:Landroid/support/v4/widget/DrawerLayout;

    invoke-virtual {v0, v4, v3}, Landroid/support/v4/widget/DrawerLayout;->setDrawerLockMode(II)V

    goto/16 :goto_0

    :pswitch_1
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->p()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_4

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->y:Landroid/widget/TextView;

    const v2, 0x7f0f051e

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setText(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->y:Landroid/widget/TextView;

    invoke-virtual {v0, v5}, Landroid/widget/TextView;->setVisibility(I)V

    goto :goto_2

    :cond_4
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->y:Landroid/widget/TextView;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->y:Landroid/widget/TextView;

    const-string v2, ""

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :goto_2
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->L()Ljava/lang/CharSequence;

    move-result-object v0

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    iget-object v2, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->x:Landroid/widget/TextView;

    sget v6, Lchat/ola/vn/f;->C:I

    invoke-virtual {v2, v6}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v2, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->x:Landroid/widget/TextView;

    invoke-virtual {v2, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->i()S

    move-result v0

    if-lez v0, :cond_5

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->W:Landroid/widget/ImageView;

    invoke-virtual {v0, v5}, Landroid/widget/ImageView;->setVisibility(I)V

    invoke-static {}, Lchat/ola/vn/j;->a()Lchat/ola/vn/j;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->i()S

    move-result v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/j;->a(I)Landroid/graphics/Bitmap;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->W:Landroid/widget/ImageView;

    invoke-virtual {v1, v0}, Landroid/widget/ImageView;->setImageBitmap(Landroid/graphics/Bitmap;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    const/4 v1, 0x6

    if-ge v0, v1, :cond_6

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->x:Landroid/widget/TextView;

    sget v1, Lchat/ola/vn/f;->L:I

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    goto :goto_3

    :cond_5
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->W:Landroid/widget/ImageView;

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_6
    :goto_3
    :try_start_1
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->k()S

    move-result v0

    if-nez v0, :cond_a

    invoke-direct {p0, v4}, Lchat/ola/vn/activity/OlaChatViewActivity;->d(Z)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    iget-object v0, v0, Lchat/ola/vn/message/f;->K:Ljava/lang/Long;

    if-eqz v0, :cond_9

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iget-object v2, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    iget-wide v6, v2, Lchat/ola/vn/message/f;->L:J

    const/4 v2, 0x0

    sub-long v8, v0, v6

    const-wide/32 v0, 0x493e0

    cmp-long v2, v8, v0

    if-ltz v2, :cond_7

    goto/16 :goto_6

    :cond_7
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    iget-object v0, v0, Lchat/ola/vn/message/f;->K:Ljava/lang/Long;

    if-eqz v0, :cond_b

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    iget-object v0, v0, Lchat/ola/vn/message/f;->K:Ljava/lang/Long;

    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide v0

    const-wide/16 v6, 0x0

    cmp-long v2, v0, v6

    if-ltz v2, :cond_b

    const-string v0, ""

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->h()S

    move-result v1

    packed-switch v1, :pswitch_data_1

    goto :goto_5

    :pswitch_2
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, " "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v1, 0x7f0f0590

    invoke-virtual {p0, v1}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    :goto_4
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_5

    :pswitch_3
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, " "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v1, 0x7f0f058a

    invoke-virtual {p0, v1}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    goto :goto_4

    :pswitch_4
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, " "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v1, 0x7f0f058b

    invoke-virtual {p0, v1}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    goto :goto_4

    :pswitch_5
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, " "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v1, 0x7f0f058f

    invoke-virtual {p0, v1}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    goto :goto_4

    :pswitch_6
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, " "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v1, 0x7f0f058d

    invoke-virtual {p0, v1}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    goto :goto_4

    :goto_5
    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->y:Landroid/widget/TextView;

    invoke-virtual {v1}, Landroid/widget/TextView;->getVisibility()I

    move-result v1

    if-eqz v1, :cond_8

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->y:Landroid/widget/TextView;

    invoke-virtual {v1, v5}, Landroid/widget/TextView;->setVisibility(I)V

    :cond_8
    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->y:Landroid/widget/TextView;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const v4, 0x7f0f0409

    invoke-virtual {p0, v4}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v4, " "

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v6

    iget-object v4, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    iget-object v4, v4, Lchat/ola/vn/message/f;->K:Ljava/lang/Long;

    invoke-virtual {v4}, Ljava/lang/Long;->longValue()J

    move-result-wide v8

    const/4 v4, 0x0

    sub-long v10, v6, v8

    invoke-static {}, Lchat/ola/vn/b;->d()Lchat/ola/vn/b;

    move-result-object v4

    invoke-virtual {v4}, Lchat/ola/vn/b;->c()[Ljava/lang/String;

    move-result-object v4

    invoke-static {}, Lchat/ola/vn/b;->d()Lchat/ola/vn/b;

    move-result-object v6

    invoke-virtual {v6}, Lchat/ola/vn/b;->a()[Ljava/lang/String;

    move-result-object v6

    invoke-static {}, Lchat/ola/vn/b;->d()Lchat/ola/vn/b;

    move-result-object v7

    invoke-virtual {v7}, Lchat/ola/vn/b;->b()[Ljava/lang/String;

    move-result-object v7

    invoke-static {v10, v11, v4, v6, v7}, Lcom/mg/ola/common/d/i;->a(J[Ljava/lang/String;[Ljava/lang/String;[Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_7

    :cond_9
    :goto_6
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    iput-wide v1, v0, Lchat/ola/vn/message/f;->L:J

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v2, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v2}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v2

    new-instance v4, Lchat/ola/vn/activity/OlaChatViewActivity$6;

    invoke-direct {v4, p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity$6;-><init>(Lchat/ola/vn/activity/OlaChatViewActivity;Lchat/ola/vn/message/f;)V

    invoke-virtual {v1, v2, v4}, Lchat/ola/vn/network/OlaNetworkService;->b(Ljava/lang/String;Lchat/ola/vn/p/d;)V

    goto :goto_7

    :cond_a
    invoke-direct {p0, v5}, Lchat/ola/vn/activity/OlaChatViewActivity;->d(Z)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->y:Landroid/widget/TextView;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->d()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->y:Landroid/widget/TextView;

    invoke-virtual {v0}, Landroid/widget/TextView;->getVisibility()I

    move-result v0

    if-eqz v0, :cond_b

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->y:Landroid/widget/TextView;

    invoke-virtual {v0, v5}, Landroid/widget/TextView;->setVisibility(I)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    :cond_b
    :goto_7
    :try_start_2
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    iget-object v0, v0, Lchat/ola/vn/message/f;->T:Lchat/ola/vn/message/d;

    if-nez v0, :cond_c

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v2}, Lchat/ola/vn/message/f;->k()S

    move-result v2

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/network/OlaNetworkService;->x(Ljava/lang/String;S)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    :catch_2
    :cond_c
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->D:Landroid/view/View;

    invoke-virtual {v0, v5}, Landroid/view/View;->setVisibility(I)V

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->O:Lchat/ola/vn/b/n;

    invoke-virtual {v1, v0}, Lchat/ola/vn/b/n;->a(Ljava/util/List;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->O:Lchat/ola/vn/b/n;

    invoke-virtual {v0}, Lchat/ola/vn/b/n;->notifyDataSetChanged()V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->N:Landroid/support/v4/widget/DrawerLayout;

    invoke-virtual {v0, v5, v3}, Landroid/support/v4/widget/DrawerLayout;->setDrawerLockMode(II)V

    return-void

    :cond_d
    invoke-direct {p0, v5}, Lchat/ola/vn/activity/OlaChatViewActivity;->d(Z)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->D:Landroid/view/View;

    invoke-virtual {v0, v5}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->b()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->x:Landroid/widget/TextView;

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    sget-object v0, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/f;->a()Z

    move-result v0

    const/4 v1, 0x3

    if-eqz v0, :cond_e

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->R:Landroid/widget/TextView;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const v6, 0x7f0f046c

    invoke-virtual {p0, v6}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v2, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v6, " "

    invoke-virtual {v2, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v6, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    invoke-virtual {v6}, Lchat/ola/vn/r/a/f;->j()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v2, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->N:Landroid/support/v4/widget/DrawerLayout;

    invoke-virtual {v0, v5, v1}, Landroid/support/v4/widget/DrawerLayout;->setDrawerLockMode(II)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->I:Landroid/widget/ListView;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->L:Lchat/ola/vn/b/z;

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setAdapter(Landroid/widget/ListAdapter;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->L:Lchat/ola/vn/b/z;

    invoke-virtual {v0}, Lchat/ola/vn/b/z;->notifyDataSetChanged()V

    goto :goto_8

    :cond_e
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->N:Landroid/support/v4/widget/DrawerLayout;

    invoke-virtual {v0, v4, v1}, Landroid/support/v4/widget/DrawerLayout;->setDrawerLockMode(II)V

    :goto_8
    sget-object v0, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/f;->i()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v1

    if-eqz v0, :cond_11

    if-nez v1, :cond_f

    goto :goto_a

    :cond_f
    iget-object v2, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->y:Landroid/widget/TextView;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const/16 v6, 0xc8

    if-lt v1, v6, :cond_10

    const-string v1, "200+"

    goto :goto_9

    :cond_10
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, ""

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    :goto_9
    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, " "

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v1, 0x7f0f0442

    invoke-static {v1}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v1

    sget-object v6, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v1, v6}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v2, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->N:Landroid/support/v4/widget/DrawerLayout;

    invoke-virtual {v1, v5, v3}, Landroid/support/v4/widget/DrawerLayout;->setDrawerLockMode(II)V

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->O:Lchat/ola/vn/b/n;

    invoke-virtual {v1, v0}, Lchat/ola/vn/b/n;->a(Ljava/util/List;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->O:Lchat/ola/vn/b/n;

    invoke-virtual {v0}, Lchat/ola/vn/b/n;->notifyDataSetChanged()V

    goto :goto_b

    :cond_11
    :goto_a
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->N:Landroid/support/v4/widget/DrawerLayout;

    invoke-virtual {v0, v4, v3}, Landroid/support/v4/widget/DrawerLayout;->setDrawerLockMode(II)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->y:Landroid/widget/TextView;

    const v1, 0x7f0f046b

    invoke-static {v1}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :goto_b
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->y:Landroid/widget/TextView;

    invoke-virtual {v0}, Landroid/widget/TextView;->getVisibility()I

    move-result v0

    if-eqz v0, :cond_12

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->y:Landroid/widget/TextView;

    invoke-virtual {v0, v5}, Landroid/widget/TextView;->setVisibility(I)V

    :cond_12
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_1
        :pswitch_0
    .end packed-switch

    :pswitch_data_1
    .packed-switch 0x0
        :pswitch_6
        :pswitch_5
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
    .end packed-switch
.end method

.method private ad()V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->r:Landroid/widget/TextView;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->s:Landroid/widget/ImageView;

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->s:Landroid/widget/ImageView;

    invoke-virtual {v0}, Landroid/widget/ImageView;->getDrawable()Landroid/graphics/drawable/Drawable;

    move-result-object v0

    check-cast v0, Landroid/graphics/drawable/AnimationDrawable;

    invoke-virtual {v0}, Landroid/graphics/drawable/AnimationDrawable;->stop()V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->A:Landroid/widget/TextView;

    invoke-virtual {v0}, Landroid/widget/TextView;->getVisibility()I

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->U:Landroid/view/View;

    :goto_0
    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->U:Landroid/view/View;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    const/4 v1, 0x0

    goto :goto_0

    :catch_0
    return-void
.end method

.method private ae()V
    .locals 3
    .annotation build Landroid/annotation/TargetApi;
        value = 0x10
    .end annotation

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->k()S

    move-result v0

    const/4 v1, 0x4

    if-ne v0, v1, :cond_1

    sget-object v0, Lchat/ola/vn/activity/OlaBottomTabActivity;->e:Landroid/graphics/drawable/Drawable;

    if-eqz v0, :cond_0

    sget-object v0, Lchat/ola/vn/activity/OlaBottomTabActivity;->e:Landroid/graphics/drawable/Drawable;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->h:Landroid/graphics/drawable/Drawable;

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->getWindow()Landroid/view/Window;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->h:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v0, v1}, Landroid/view/Window;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->t:Landroid/widget/FrameLayout;

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->g()I

    move-result v1

    :goto_0
    invoke-virtual {v0, v1}, Landroid/widget/FrameLayout;->setBackgroundColor(I)V

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->t:Landroid/widget/FrameLayout;

    :goto_1
    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->f()I

    move-result v1

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->h:Landroid/graphics/drawable/Drawable;

    if-nez v0, :cond_3

    iget-boolean v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->i:Z

    if-nez v0, :cond_3

    const/4 v0, 0x0

    iput-boolean v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ab:Z

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->t:Landroid/widget/FrameLayout;

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->f()I

    move-result v2

    invoke-virtual {v1, v2}, Landroid/widget/FrameLayout;->setBackgroundColor(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    new-instance v1, Lchat/ola/vn/activity/OlaChatViewActivity$7;

    invoke-direct {v1, p0}, Lchat/ola/vn/activity/OlaChatViewActivity$7;-><init>(Lchat/ola/vn/activity/OlaChatViewActivity;)V

    invoke-static {}, Lcom/mg/ola/common/d/g;->c()Z

    move-result v2

    if-eqz v2, :cond_2

    sget-object v2, Lchat/ola/vn/h;->R:Ljava/util/concurrent/ExecutorService;

    new-array v0, v0, [Ljava/lang/Void;

    invoke-virtual {v1, v2, v0}, Landroid/os/AsyncTask;->executeOnExecutor(Ljava/util/concurrent/Executor;[Ljava/lang/Object;)Landroid/os/AsyncTask;

    goto :goto_2

    :cond_2
    new-array v0, v0, [Ljava/lang/Void;

    invoke-virtual {v1, v0}, Landroid/os/AsyncTask;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_2

    :catch_0
    move-exception v0

    :try_start_2
    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_3
    :goto_2
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->h:Landroid/graphics/drawable/Drawable;

    if-nez v0, :cond_4

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->t:Landroid/widget/FrameLayout;

    goto :goto_1

    :cond_4
    invoke-static {}, Lcom/mg/ola/common/d/g;->g()Z

    move-result v0

    if-eqz v0, :cond_5

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->t:Landroid/widget/FrameLayout;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->h:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v0, v1}, Landroid/widget/FrameLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    return-void

    :cond_5
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->t:Landroid/widget/FrameLayout;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->h:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v0, v1}, Landroid/widget/FrameLayout;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    return-void
.end method

.method private af()Z
    .locals 5

    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    iget v1, v1, Lchat/ola/vn/message/f;->D:I

    if-ltz v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->p:Landroid/widget/ListView;

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Landroid/widget/ListView;->setTranscriptMode(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->p:Landroid/widget/ListView;

    iget-object v3, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    iget v3, v3, Lchat/ola/vn/message/f;->D:I

    iget-object v4, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    iget v4, v4, Lchat/ola/vn/message/f;->E:I

    invoke-virtual {v1, v3, v4}, Landroid/widget/ListView;->setSelectionFromTop(II)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    return v2

    :catch_0
    :try_start_2
    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->p:Landroid/widget/ListView;

    iget-object v3, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    iget v3, v3, Lchat/ola/vn/message/f;->D:I

    invoke-virtual {v1, v3}, Landroid/widget/ListView;->setSelection(I)V

    return v2

    :cond_0
    invoke-direct {p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->h(Z)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    return v0
.end method

.method private ag()Lchat/ola/vn/message/d;
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    if-nez v0, :cond_0

    const/4 v0, 0x0

    return-object v0

    :cond_0
    new-instance v0, Lchat/ola/vn/message/d;

    invoke-direct {v0}, Lchat/ola/vn/message/d;-><init>()V

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/message/d;->d(Ljava/lang/String;)V

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/message/d;->e(Ljava/lang/String;)V

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->k()S

    move-result v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/message/d;->c(S)V

    sget-short v1, Lchat/ola/vn/h;->H:S

    invoke-virtual {v0, v1}, Lchat/ola/vn/message/d;->a(S)V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/message/d;->a(J)V

    return-object v0
.end method

.method private ah()V
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->k()S

    move-result v0

    const/4 v1, 0x4

    if-eq v0, v1, :cond_0

    packed-switch v0, :pswitch_data_0

    goto :goto_0

    :pswitch_0
    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->ai()V

    return-void

    :pswitch_1
    invoke-static {p0}, Lchat/ola/vn/m/e;->b(Landroid/content/Context;)V

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->finish()V

    goto :goto_0

    :cond_0
    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz v0, :cond_1

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/Long;->valueOf(Ljava/lang/String;)Ljava/lang/Long;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Long;->longValue()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/network/OlaNetworkService;->e(J)V

    :cond_1
    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->onBackPressed()V

    :goto_0
    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v2}, Lchat/ola/vn/message/f;->k()S

    move-result v2

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/message/g;->a(Ljava/lang/String;S)Lchat/ola/vn/message/f;

    :cond_2
    return-void

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private ai()V
    .locals 7

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    if-nez v0, :cond_0

    return-void

    :cond_0
    const v0, 0x7f0f0280

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object v2

    const v0, 0x7f0f01d6

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v3, 0x0

    iget-object v4, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v4}, Lchat/ola/vn/message/f;->b()Ljava/lang/String;

    move-result-object v4

    aput-object v4, v1, v3

    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    const v0, 0x7f0f06c2

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object v4

    const v0, 0x7f0f0577

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object v5

    new-instance v6, Lchat/ola/vn/activity/OlaChatViewActivity$14;

    invoke-direct {v6, p0}, Lchat/ola/vn/activity/OlaChatViewActivity$14;-><init>(Lchat/ola/vn/activity/OlaChatViewActivity;)V

    move-object v1, p0

    invoke-static/range {v1 .. v6}, Lchat/ola/vn/i/i;->d(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/content/DialogInterface$OnClickListener;)Lchat/ola/vn/i/f;

    return-void
.end method

.method private aj()Landroid/app/Dialog;
    .locals 3

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    const v1, 0x7f0f061f

    invoke-virtual {p0, v1}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v1, 0x7f0f047f

    invoke-virtual {p0, v1}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v1, Lchat/ola/vn/i/m;

    invoke-direct {v1, p0}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    invoke-virtual {v1, v0}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance v2, Lchat/ola/vn/activity/OlaChatViewActivity$20;

    invoke-direct {v2, p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity$20;-><init>(Lchat/ola/vn/activity/OlaChatViewActivity;Ljava/util/List;)V

    invoke-virtual {v1, v2}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {v1}, Lchat/ola/vn/i/m;->show()V

    return-object v1
.end method

.method private ak()V
    .locals 2
    .annotation build Landroid/annotation/TargetApi;
        value = 0xd
    .end annotation

    :try_start_0
    const-string v0, "window"

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

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

.method private al()V
    .locals 6

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->D()V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->k()S

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    const/4 v1, 0x0

    const/4 v2, 0x0

    const/4 v3, 0x1

    if-eqz v0, :cond_2

    const/4 v4, 0x2

    if-eq v0, v4, :cond_0

    return-void

    :cond_0
    :try_start_1
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->X()Z

    move-result v0

    if-nez v0, :cond_3

    invoke-direct {p0, v3}, Lchat/ola/vn/activity/OlaChatViewActivity;->e(Z)V

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v4, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v4}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v4

    new-instance v5, Lchat/ola/vn/activity/OlaChatViewActivity$21;

    invoke-direct {v5, p0}, Lchat/ola/vn/activity/OlaChatViewActivity$21;-><init>(Lchat/ola/vn/activity/OlaChatViewActivity;)V

    invoke-static {v5}, Lchat/ola/vn/entry/c/f;->a(Lchat/ola/vn/entry/c/e;)S

    move-result v5

    invoke-virtual {v0, v4, v2, v5}, Lchat/ola/vn/network/OlaNetworkService;->h(Ljava/lang/String;Ljava/lang/String;S)Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    iput-byte v3, v0, Lchat/ola/vn/message/f;->V:B

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    iput-object v2, v0, Lchat/ola/vn/message/f;->O:Ljava/lang/String;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    :goto_0
    iput-boolean v3, v0, Lchat/ola/vn/message/f;->Q:Z

    return-void

    :cond_1
    invoke-direct {p0, v1}, Lchat/ola/vn/activity/OlaChatViewActivity;->e(Z)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    return-void

    :catch_0
    :try_start_2
    invoke-direct {p0, v1}, Lchat/ola/vn/activity/OlaChatViewActivity;->e(Z)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    return-void

    :cond_2
    :try_start_3
    invoke-direct {p0, v3}, Lchat/ola/vn/activity/OlaChatViewActivity;->e(Z)V

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v4, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v4}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v4

    new-instance v5, Lchat/ola/vn/activity/OlaChatViewActivity$22;

    invoke-direct {v5, p0}, Lchat/ola/vn/activity/OlaChatViewActivity$22;-><init>(Lchat/ola/vn/activity/OlaChatViewActivity;)V

    invoke-static {v5}, Lchat/ola/vn/entry/c/f;->a(Lchat/ola/vn/entry/c/e;)S

    move-result v5

    invoke-virtual {v0, v4, v2, v5}, Lchat/ola/vn/network/OlaNetworkService;->i(Ljava/lang/String;Ljava/lang/String;S)Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    iput-byte v3, v0, Lchat/ola/vn/message/f;->V:B

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    iput-object v2, v0, Lchat/ola/vn/message/f;->O:Ljava/lang/String;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_0

    goto :goto_0

    :catch_1
    :cond_3
    return-void
.end method

.method private am()V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->Q()Lchat/ola/vn/game/caro/b;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_0
    return-void
.end method

.method private an()V
    .locals 3

    :try_start_0
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x17

    if-lt v0, v1, :cond_0

    const-string v0, "android.permission.CAMERA"

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->checkSelfPermission(Ljava/lang/String;)I

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "android.permission.CAMERA"

    aput-object v2, v0, v1

    const/16 v1, 0x69

    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/activity/OlaChatViewActivity;->requestPermissions([Ljava/lang/String;I)V

    return-void

    :cond_0
    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->ao()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method private ao()V
    .locals 4

    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.media.action.IMAGE_CAPTURE"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    new-instance v1, Ljava/io/File;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-static {v2, v3}, Lchat/ola/vn/d;->a(J)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    iput-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ax:Ljava/io/File;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ax:Ljava/io/File;

    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ax:Ljava/io/File;

    invoke-virtual {v1}, Ljava/io/File;->delete()Z

    :cond_0
    const-string v1, "output"

    iget-object v2, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ax:Ljava/io/File;

    invoke-static {v2}, Landroid/net/Uri;->fromFile(Ljava/io/File;)Landroid/net/Uri;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Parcelable;)Landroid/content/Intent;

    const/4 v1, 0x2

    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/activity/OlaChatViewActivity;->startActivityForResult(Landroid/content/Intent;I)V

    return-void
.end method

.method private ap()V
    .locals 3
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "InlinedApi"
        }
    .end annotation

    invoke-static {}, Lcom/mg/ola/common/d/g;->h()Z

    move-result v0

    if-eqz v0, :cond_0

    new-instance v0, Landroid/content/Intent;

    invoke-direct {v0}, Landroid/content/Intent;-><init>()V

    const-string v1, "image/*"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setType(Ljava/lang/String;)Landroid/content/Intent;

    const-string v1, "android.intent.extra.ALLOW_MULTIPLE"

    const/4 v2, 0x1

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    const-string v1, "android.intent.action.GET_CONTENT"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    const v1, 0x7f0f060c

    invoke-virtual {p0, v1}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/content/Intent;->createChooser(Landroid/content/Intent;Ljava/lang/CharSequence;)Landroid/content/Intent;

    move-result-object v0

    const/4 v1, 0x3

    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/activity/OlaChatViewActivity;->startActivityForResult(Landroid/content/Intent;I)V

    :cond_0
    return-void
.end method

.method private aq()V
    .locals 2

    iget v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->aw:I

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->N:Landroid/support/v4/widget/DrawerLayout;

    invoke-virtual {v0}, Landroid/support/v4/widget/DrawerLayout;->getHeight()I

    move-result v0

    sget v1, Lchat/ola/vn/activity/OlaChatViewActivity;->g:I

    sub-int/2addr v0, v1

    iput v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->aw:I

    :cond_0
    new-instance v0, Lchat/ola/vn/activity/OlaChatViewActivity$25;

    invoke-direct {v0, p0}, Lchat/ola/vn/activity/OlaChatViewActivity$25;-><init>(Lchat/ola/vn/activity/OlaChatViewActivity;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method private ar()V
    .locals 1

    new-instance v0, Lchat/ola/vn/activity/OlaChatViewActivity$26;

    invoke-direct {v0, p0}, Lchat/ola/vn/activity/OlaChatViewActivity$26;-><init>(Lchat/ola/vn/activity/OlaChatViewActivity;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method private as()V
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->aq:Landroid/widget/ImageButton;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/ImageButton;->setSelected(Z)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ar:Landroid/widget/ImageButton;

    invoke-virtual {v0, v1}, Landroid/widget/ImageButton;->setSelected(Z)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->as:Landroid/widget/ImageButton;

    invoke-virtual {v0, v1}, Landroid/widget/ImageButton;->setSelected(Z)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->at:Landroid/widget/ImageButton;

    invoke-virtual {v0, v1}, Landroid/widget/ImageButton;->setSelected(Z)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->au:Landroid/widget/ImageButton;

    invoke-virtual {v0, v1}, Landroid/widget/ImageButton;->setSelected(Z)V

    iget v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ae:I

    const/4 v2, 0x1

    packed-switch v0, :pswitch_data_0

    return-void

    :pswitch_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->au:Landroid/widget/ImageButton;

    goto :goto_0

    :pswitch_1
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->at:Landroid/widget/ImageButton;

    goto :goto_0

    :pswitch_2
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->as:Landroid/widget/ImageButton;

    goto :goto_0

    :pswitch_3
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ar:Landroid/widget/ImageButton;

    goto :goto_0

    :pswitch_4
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->aq:Landroid/widget/ImageButton;

    :goto_0
    invoke-virtual {v0, v2}, Landroid/widget/ImageButton;->setSelected(Z)V

    return-void

    :pswitch_5
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->aq:Landroid/widget/ImageButton;

    invoke-virtual {v0, v1}, Landroid/widget/ImageButton;->setSelected(Z)V

    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private at()V
    .locals 4

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ay:Lchat/ola/vn/i/c;

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/i/c;

    invoke-direct {v0, p0}, Lchat/ola/vn/i/c;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ay:Lchat/ola/vn/i/c;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ay:Lchat/ola/vn/i/c;

    const v1, 0x7f0f0275

    invoke-virtual {v0, v1}, Lchat/ola/vn/i/c;->a(I)V

    :cond_0
    :try_start_0
    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v0

    const-wide/32 v1, 0x2bf20

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/n/c;->a(J)[Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_2

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->ag()Lchat/ola/vn/message/d;

    move-result-object v0

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v1

    invoke-virtual {v1}, Lchat/ola/vn/n/c;->b()Ljava/lang/String;

    move-result-object v1

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v2

    invoke-virtual {v2}, Lchat/ola/vn/n/c;->c()Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x2

    invoke-static {v0, v3, v1, v2}, Lchat/ola/vn/message/e;->a(Lchat/ola/vn/message/d;BLjava/lang/String;Ljava/lang/String;)Lchat/ola/vn/message/k;

    move-result-object v0

    invoke-direct {p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->c(Lchat/ola/vn/message/d;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->k()S

    move-result v0

    if-ne v0, v3, :cond_1

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v2

    invoke-virtual {v2}, Lchat/ola/vn/n/c;->b()Ljava/lang/String;

    move-result-object v2

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v3

    invoke-virtual {v3}, Lchat/ola/vn/n/c;->c()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v1, v2, v3}, Lchat/ola/vn/network/OlaNetworkService;->b(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void

    :cond_1
    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v2

    invoke-virtual {v2}, Lchat/ola/vn/n/c;->b()Ljava/lang/String;

    move-result-object v2

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v3

    invoke-virtual {v3}, Lchat/ola/vn/n/c;->c()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v1, v2, v3}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    :cond_2
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ay:Lchat/ola/vn/i/c;

    const-wide/16 v1, 0x7530

    const/4 v3, 0x0

    invoke-virtual {v0, v1, v2, v3}, Lchat/ola/vn/i/c;->a(JLjava/lang/Runnable;)V

    const-wide/16 v0, 0x3a98

    new-instance v2, Lchat/ola/vn/activity/OlaChatViewActivity$31;

    invoke-direct {v2, p0}, Lchat/ola/vn/activity/OlaChatViewActivity$31;-><init>(Lchat/ola/vn/activity/OlaChatViewActivity;)V

    invoke-static {p0, v0, v1, v2}, Lchat/ola/vn/n/b;->b(Landroid/content/Context;JLchat/ola/vn/n/b$b;)V

    return-void
.end method

.method private au()Z
    .locals 4

    :try_start_0
    invoke-static {}, Lchat/ola/vn/activity/OlaQuickReplyComposerActivity;->B()Ljava/util/List;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v1

    if-lez v1, :cond_0

    new-instance v1, Lchat/ola/vn/i/m;

    invoke-direct {v1, p0}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Lchat/ola/vn/i/m;->setCanceledOnTouchOutside(Z)V

    invoke-virtual {v1, v0}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    const v3, 0x7f0f05ca

    invoke-virtual {v1, v3}, Lchat/ola/vn/i/m;->setTitle(I)V

    new-instance v3, Lchat/ola/vn/activity/OlaChatViewActivity$35;

    invoke-direct {v3, p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity$35;-><init>(Lchat/ola/vn/activity/OlaChatViewActivity;Ljava/util/List;)V

    invoke-virtual {v1, v3}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {v1}, Lchat/ola/vn/i/m;->show()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return v2

    :catch_0
    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method static synthetic b(Lchat/ola/vn/activity/OlaChatViewActivity;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->Z()V

    return-void
.end method

.method static synthetic b(Lchat/ola/vn/activity/OlaChatViewActivity;Lchat/ola/vn/message/f;Ljava/lang/String;ILjava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1, p2, p3, p4}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Lchat/ola/vn/message/f;Ljava/lang/String;ILjava/lang/String;)V

    return-void
.end method

.method static synthetic b(Lchat/ola/vn/activity/OlaChatViewActivity;Ljava/lang/String;IZ)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Lchat/ola/vn/activity/OlaChatViewActivity;->b(Ljava/lang/String;IZ)V

    return-void
.end method

.method static synthetic b(Lchat/ola/vn/activity/OlaChatViewActivity;Z)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/activity/OlaChatViewActivity;->d(Z)V

    return-void
.end method

.method private b(Lchat/ola/vn/message/f;Ljava/lang/String;ILjava/lang/String;)V
    .locals 1

    :try_start_0
    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    if-eqz p3, :cond_6

    :cond_0
    if-nez p1, :cond_1

    return-void

    :cond_1
    const/4 v0, 0x0

    iput-boolean v0, p1, Lchat/ola/vn/message/f;->B:Z

    sget-object v0, Lchat/ola/vn/f/c;->b:Ljava/lang/String;

    invoke-static {p2, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    sget-object p2, Lchat/ola/vn/f/c;->a:Ljava/lang/String;

    :cond_2
    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->ag()Lchat/ola/vn/message/d;

    move-result-object v0

    invoke-virtual {v0, p2}, Lchat/ola/vn/message/d;->f(Ljava/lang/String;)V

    int-to-short p2, p3

    invoke-virtual {v0, p2}, Lchat/ola/vn/message/d;->b(S)V

    invoke-virtual {v0, p4}, Lchat/ola/vn/message/d;->h(Ljava/lang/String;)V

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->k()S

    move-result p1

    if-eqz p1, :cond_5

    const/4 p2, 0x2

    if-eq p1, p2, :cond_4

    const/4 p2, 0x4

    if-eq p1, p2, :cond_3

    return-void

    :cond_3
    invoke-virtual {v0}, Lchat/ola/vn/message/d;->j()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide p1

    sget-object p3, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0}, Lchat/ola/vn/message/d;->k()Ljava/lang/String;

    move-result-object p4

    invoke-virtual {v0}, Lchat/ola/vn/message/d;->o()S

    move-result v0

    invoke-virtual {p3, p1, p2, p4, v0}, Lchat/ola/vn/network/OlaNetworkService;->a(JLjava/lang/String;S)V

    return-void

    :cond_4
    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz p1, :cond_6

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0}, Lchat/ola/vn/message/d;->j()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {v0}, Lchat/ola/vn/message/d;->k()Ljava/lang/String;

    move-result-object p3

    invoke-virtual {v0}, Lchat/ola/vn/message/d;->p()Ljava/lang/String;

    move-result-object p4

    invoke-virtual {v0}, Lchat/ola/vn/message/d;->o()S

    move-result v0

    invoke-virtual {p1, p2, p3, p4, v0}, Lchat/ola/vn/network/OlaNetworkService;->c(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;S)V

    return-void

    :cond_5
    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz p1, :cond_6

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0}, Lchat/ola/vn/message/d;->j()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {v0}, Lchat/ola/vn/message/d;->k()Ljava/lang/String;

    move-result-object p3

    invoke-virtual {v0}, Lchat/ola/vn/message/d;->p()Ljava/lang/String;

    move-result-object p4

    invoke-virtual {v0}, Lchat/ola/vn/message/d;->o()S

    move-result v0

    invoke-virtual {p1, p2, p3, p4, v0}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;S)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_6
    return-void
.end method

.method private b(Ljava/lang/CharSequence;)V
    .locals 2

    iget-boolean v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->aA:Z

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    iput-boolean v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->aA:Z

    return-void

    :cond_0
    const/16 v0, 0x8

    if-eqz p1, :cond_2

    :try_start_0
    invoke-interface {p1}, Ljava/lang/CharSequence;->length()I

    move-result p1

    if-nez p1, :cond_1

    goto :goto_0

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->v:Landroid/widget/ImageButton;

    invoke-virtual {p1, v0}, Landroid/widget/ImageButton;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->u:Landroid/widget/Button;

    invoke-virtual {p1, v1}, Landroid/widget/Button;->setVisibility(I)V

    return-void

    :cond_2
    :goto_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->v:Landroid/widget/ImageButton;

    invoke-virtual {p1, v1}, Landroid/widget/ImageButton;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->u:Landroid/widget/Button;

    invoke-virtual {p1, v0}, Landroid/widget/Button;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->v:Landroid/widget/ImageButton;

    invoke-virtual {p1, v1}, Landroid/widget/ImageButton;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->u:Landroid/widget/Button;

    invoke-virtual {p1, v0}, Landroid/widget/Button;->setVisibility(I)V

    return-void
.end method

.method private b(Ljava/lang/String;IZ)V
    .locals 8

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    if-eqz p2, :cond_4

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    if-nez v0, :cond_1

    return-void

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lchat/ola/vn/message/f;->d(Z)V

    sget-object v0, Lchat/ola/vn/f/c;->b:Ljava/lang/String;

    invoke-static {p1, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    sget-object p1, Lchat/ola/vn/f/c;->a:Ljava/lang/String;

    :cond_2
    move-object v4, p1

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->ag()Lchat/ola/vn/message/d;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    const/4 v1, 0x0

    iput-boolean v1, v0, Lchat/ola/vn/message/f;->B:Z

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    iput-wide v1, v0, Lchat/ola/vn/message/f;->H:J

    invoke-virtual {p1, v4}, Lchat/ola/vn/message/d;->f(Ljava/lang/String;)V

    int-to-short v0, p2

    invoke-virtual {p1, v0}, Lchat/ola/vn/message/d;->b(S)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v6

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->k()S

    move-result v3

    const/4 v0, 0x2

    invoke-static {p1, v0}, Lchat/ola/vn/message/e;->a(Lchat/ola/vn/message/d;B)Lchat/ola/vn/message/d;

    move-result-object p1

    new-instance v7, Lchat/ola/vn/activity/OlaChatViewActivity$9;

    move-object v0, v7

    move-object v1, p0

    move-object v2, p1

    move v5, p2

    invoke-direct/range {v0 .. v6}, Lchat/ola/vn/activity/OlaChatViewActivity$9;-><init>(Lchat/ola/vn/activity/OlaChatViewActivity;Lchat/ola/vn/message/d;SLjava/lang/String;ILjava/lang/String;)V

    invoke-interface {v7}, Ljava/lang/Runnable;->run()V

    invoke-virtual {p1, v7}, Lchat/ola/vn/message/d;->a(Ljava/lang/Runnable;)V

    if-eqz p3, :cond_3

    const-string p2, ""

    invoke-direct {p0, p2}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Ljava/lang/CharSequence;)V

    :cond_3
    invoke-direct {p0, p1}, Lchat/ola/vn/activity/OlaChatViewActivity;->c(Lchat/ola/vn/message/d;)V

    :cond_4
    return-void
.end method

.method static synthetic c(Lchat/ola/vn/activity/OlaChatViewActivity;)Landroid/os/Handler;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->F:Landroid/os/Handler;

    return-object p0
.end method

.method private c(Lchat/ola/vn/message/d;)V
    .locals 2

    const/4 v0, 0x1

    if-eqz p1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v1, p1}, Lchat/ola/vn/message/f;->a(Lchat/ola/vn/message/d;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {p1, v0}, Lchat/ola/vn/message/f;->d(Z)V

    :cond_0
    invoke-direct {p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->h(Z)V

    return-void
.end method

.method static synthetic c(Lchat/ola/vn/activity/OlaChatViewActivity;Z)Z
    .locals 0

    iput-boolean p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ab:Z

    return p1
.end method

.method static synthetic d(Lchat/ola/vn/activity/OlaChatViewActivity;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->ad()V

    return-void
.end method

.method private d(Z)V
    .locals 5

    if-eqz p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->V:Landroid/widget/ImageView;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    iget-object p1, p1, Lchat/ola/vn/message/f;->J:Ljava/lang/Long;

    const v0, 0x7f08063e

    if-eqz p1, :cond_0

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    iget-object p1, p1, Lchat/ola/vn/message/f;->J:Ljava/lang/Long;

    invoke-virtual {p1}, Ljava/lang/Long;->longValue()J

    move-result-wide v3

    cmp-long p1, v1, v3

    if-gez p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->V:Landroid/widget/ImageView;

    const v0, 0x7f08063f

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->V:Landroid/widget/ImageView;

    :goto_0
    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->setImageResource(I)V

    return-void

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->V:Landroid/widget/ImageView;

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->setVisibility(I)V

    return-void
.end method

.method static synthetic e(Lchat/ola/vn/activity/OlaChatViewActivity;)Landroid/widget/TextView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->r:Landroid/widget/TextView;

    return-object p0
.end method

.method private e(Z)V
    .locals 1

    if-eqz p1, :cond_0

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->p:Landroid/widget/ListView;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->Y:Landroid/view/View;

    invoke-virtual {p1, v0}, Landroid/widget/ListView;->addHeaderView(Landroid/view/View;)V

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->p:Landroid/widget/ListView;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->Y:Landroid/view/View;

    invoke-virtual {p1, v0}, Landroid/widget/ListView;->removeHeaderView(Landroid/view/View;)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic f(Lchat/ola/vn/activity/OlaChatViewActivity;)Ljava/lang/Runnable;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->G:Ljava/lang/Runnable;

    return-object p0
.end method

.method private f(Z)V
    .locals 1
    .annotation build Landroid/annotation/TargetApi;
        value = 0xc
    .end annotation

    :try_start_0
    new-instance v0, Lchat/ola/vn/activity/OlaChatViewActivity$2;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/activity/OlaChatViewActivity$2;-><init>(Lchat/ola/vn/activity/OlaChatViewActivity;Z)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic g(Lchat/ola/vn/activity/OlaChatViewActivity;)Landroid/widget/EditText;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->q:Landroid/widget/EditText;

    return-object p0
.end method

.method private g(Z)V
    .locals 2

    const/4 v0, 0x0

    if-eqz p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->A:Landroid/widget/TextView;

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->A:Landroid/widget/TextView;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->B:Landroid/view/animation/Animation;

    invoke-virtual {p1, v1}, Landroid/widget/TextView;->startAnimation(Landroid/view/animation/Animation;)V

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->U:Landroid/view/View;

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    return-void

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->A:Landroid/widget/TextView;

    const/16 v1, 0x8

    invoke-virtual {p1, v1}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->A:Landroid/widget/TextView;

    invoke-virtual {p1}, Landroid/widget/TextView;->clearAnimation()V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->r:Landroid/widget/TextView;

    invoke-virtual {p1}, Landroid/widget/TextView;->getVisibility()I

    move-result p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->U:Landroid/view/View;

    invoke-virtual {p1, v1}, Landroid/view/View;->setVisibility(I)V

    return-void
.end method

.method static synthetic h(Lchat/ola/vn/activity/OlaChatViewActivity;)Landroid/widget/Button;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->u:Landroid/widget/Button;

    return-object p0
.end method

.method private h(Z)V
    .locals 4
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "NewApi"
        }
    .end annotation

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    const/4 v1, -0x1

    iput v1, v0, Lchat/ola/vn/message/f;->D:I

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    const/4 v1, 0x0

    iput v1, v0, Lchat/ola/vn/message/f;->E:I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->p:Landroid/widget/ListView;

    new-instance v1, Lchat/ola/vn/activity/OlaChatViewActivity$13;

    invoke-direct {v1, p0, p1}, Lchat/ola/vn/activity/OlaChatViewActivity$13;-><init>(Lchat/ola/vn/activity/OlaChatViewActivity;Z)V

    const-wide/16 v2, 0xfa

    invoke-virtual {v0, v1, v2, v3}, Landroid/widget/ListView;->postDelayed(Ljava/lang/Runnable;J)Z

    return-void
.end method

.method static synthetic i(Lchat/ola/vn/activity/OlaChatViewActivity;)Landroid/widget/ImageButton;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->v:Landroid/widget/ImageButton;

    return-object p0
.end method

.method private i(Z)V
    .locals 2

    if-eqz p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->av:Landroid/widget/FrameLayout;

    invoke-virtual {p1}, Landroid/widget/FrameLayout;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object p1

    iget v0, p1, Landroid/view/ViewGroup$LayoutParams;->height:I

    sget v1, Lchat/ola/vn/activity/OlaChatViewActivity;->g:I

    if-eq v0, v1, :cond_0

    sget v0, Lchat/ola/vn/activity/OlaChatViewActivity;->g:I

    iput v0, p1, Landroid/view/ViewGroup$LayoutParams;->height:I

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->av:Landroid/widget/FrameLayout;

    invoke-virtual {v0, p1}, Landroid/widget/FrameLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->av:Landroid/widget/FrameLayout;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/widget/FrameLayout;->setVisibility(I)V

    return-void

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->av:Landroid/widget/FrameLayout;

    invoke-virtual {p1}, Landroid/widget/FrameLayout;->getVisibility()I

    move-result p1

    const/16 v0, 0x8

    if-eq p1, v0, :cond_2

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->av:Landroid/widget/FrameLayout;

    invoke-virtual {p1, v0}, Landroid/widget/FrameLayout;->setVisibility(I)V

    :cond_2
    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->av:Landroid/widget/FrameLayout;

    invoke-virtual {p1}, Landroid/widget/FrameLayout;->removeAllViews()V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->al:Lchat/ola/vn/view/d;

    if-eqz p1, :cond_3

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->al:Lchat/ola/vn/view/d;

    invoke-virtual {p1}, Lchat/ola/vn/view/d;->a()V

    :cond_3
    const/4 p1, 0x0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->al:Lchat/ola/vn/view/d;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic j(Lchat/ola/vn/activity/OlaChatViewActivity;)Landroid/widget/TextView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->y:Landroid/widget/TextView;

    return-object p0
.end method

.method private j(Z)V
    .locals 3

    :try_start_0
    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->as()V

    iget v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ae:I

    const/4 v1, 0x0

    const/4 v2, 0x1

    packed-switch v0, :pswitch_data_0

    goto/16 :goto_2

    :pswitch_0
    invoke-direct {p0, v2}, Lchat/ola/vn/activity/OlaChatViewActivity;->i(Z)V

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->aq()V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ak:Lchat/ola/vn/view/f;

    if-nez p1, :cond_0

    new-instance p1, Lchat/ola/vn/view/f;

    invoke-direct {p1, p0}, Lchat/ola/vn/view/f;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ak:Lchat/ola/vn/view/f;

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ak:Lchat/ola/vn/view/f;

    invoke-virtual {p1, p0}, Lchat/ola/vn/view/f;->setOnMoreActionClickedListener(Lchat/ola/vn/view/f$a;)V

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ak:Lchat/ola/vn/view/f;

    if-eqz p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->k()S

    move-result p1

    const/4 v0, 0x2

    if-ne p1, v0, :cond_1

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ak:Lchat/ola/vn/view/f;

    invoke-virtual {p1, v1}, Lchat/ola/vn/view/f;->setTransferKenButtonVisibility(Z)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ak:Lchat/ola/vn/view/f;

    invoke-virtual {p1, v1}, Lchat/ola/vn/view/f;->setTradingVipButtonVisibility(Z)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ak:Lchat/ola/vn/view/f;

    invoke-virtual {p1, v1}, Lchat/ola/vn/view/f;->setSendVipDayButtonVisibility(Z)V

    goto :goto_0

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ak:Lchat/ola/vn/view/f;

    invoke-virtual {p1, v2}, Lchat/ola/vn/view/f;->setTransferKenButtonVisibility(Z)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ak:Lchat/ola/vn/view/f;

    invoke-virtual {p1, v2}, Lchat/ola/vn/view/f;->setTradingVipButtonVisibility(Z)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ak:Lchat/ola/vn/view/f;

    invoke-virtual {p1, v2}, Lchat/ola/vn/view/f;->setSendVipDayButtonVisibility(Z)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_2

    :cond_2
    :goto_0
    :try_start_1
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->al:Lchat/ola/vn/view/d;

    if-eqz p1, :cond_3

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->al:Lchat/ola/vn/view/d;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ak:Lchat/ola/vn/view/f;

    if-eq p1, v0, :cond_d

    :cond_3
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->av:Landroid/widget/FrameLayout;

    invoke-virtual {p1}, Landroid/widget/FrameLayout;->removeAllViews()V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->av:Landroid/widget/FrameLayout;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ak:Lchat/ola/vn/view/f;

    invoke-virtual {p1, v0}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ak:Lchat/ola/vn/view/f;

    :goto_1
    iput-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->al:Lchat/ola/vn/view/d;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto/16 :goto_2

    :pswitch_1
    :try_start_2
    invoke-direct {p0, v2}, Lchat/ola/vn/activity/OlaChatViewActivity;->i(Z)V

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->aq()V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->aj:Lchat/ola/vn/view/j;

    if-nez p1, :cond_4

    new-instance p1, Lchat/ola/vn/view/j;

    invoke-direct {p1, p0}, Lchat/ola/vn/view/j;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->aj:Lchat/ola/vn/view/j;

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->aj:Lchat/ola/vn/view/j;

    invoke-virtual {p1, p0}, Lchat/ola/vn/view/j;->setOnVoiceRecordListener(Lchat/ola/vn/view/j$a;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    :cond_4
    :try_start_3
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->al:Lchat/ola/vn/view/d;

    if-eqz p1, :cond_5

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->al:Lchat/ola/vn/view/d;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->aj:Lchat/ola/vn/view/j;

    if-eq p1, v0, :cond_d

    :cond_5
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->av:Landroid/widget/FrameLayout;

    invoke-virtual {p1}, Landroid/widget/FrameLayout;->removeAllViews()V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->av:Landroid/widget/FrameLayout;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->aj:Lchat/ola/vn/view/j;

    invoke-virtual {p1, v0}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->aj:Lchat/ola/vn/view/j;
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_0

    goto :goto_1

    :pswitch_2
    :try_start_4
    invoke-direct {p0, v2}, Lchat/ola/vn/activity/OlaChatViewActivity;->i(Z)V

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->aq()V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ai:Lchat/ola/vn/view/g;

    if-nez p1, :cond_6

    new-instance p1, Lchat/ola/vn/view/g;

    invoke-direct {p1, p0}, Lchat/ola/vn/view/g;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ai:Lchat/ola/vn/view/g;

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ai:Lchat/ola/vn/view/g;

    invoke-virtual {p1, v1}, Lchat/ola/vn/view/g;->setAllowVideo(Z)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ai:Lchat/ola/vn/view/g;

    invoke-virtual {p1, p0}, Lchat/ola/vn/view/g;->setOlaPhotoListener(Lchat/ola/vn/view/g$e;)V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_2

    :cond_6
    :try_start_5
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->al:Lchat/ola/vn/view/d;

    if-eqz p1, :cond_7

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->al:Lchat/ola/vn/view/d;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ai:Lchat/ola/vn/view/g;

    if-eq p1, v0, :cond_d

    :cond_7
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->av:Landroid/widget/FrameLayout;

    invoke-virtual {p1}, Landroid/widget/FrameLayout;->removeAllViews()V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->av:Landroid/widget/FrameLayout;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ai:Lchat/ola/vn/view/g;

    invoke-virtual {p1, v0}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ai:Lchat/ola/vn/view/g;
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_0

    goto :goto_1

    :pswitch_3
    :try_start_6
    invoke-direct {p0, v2}, Lchat/ola/vn/activity/OlaChatViewActivity;->i(Z)V

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->aq()V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ah:Lchat/ola/vn/view/i;

    if-nez p1, :cond_8

    new-instance p1, Lchat/ola/vn/view/i;

    invoke-direct {p1, p0}, Lchat/ola/vn/view/i;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ah:Lchat/ola/vn/view/i;

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ah:Lchat/ola/vn/view/i;

    invoke-virtual {p1, p0}, Lchat/ola/vn/view/i;->setOnStickerClickedListener(Lchat/ola/vn/view/i$e;)V
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_2

    :cond_8
    :try_start_7
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->al:Lchat/ola/vn/view/d;

    if-eqz p1, :cond_9

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->al:Lchat/ola/vn/view/d;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ah:Lchat/ola/vn/view/i;

    if-eq p1, v0, :cond_d

    :cond_9
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->av:Landroid/widget/FrameLayout;

    invoke-virtual {p1}, Landroid/widget/FrameLayout;->removeAllViews()V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->av:Landroid/widget/FrameLayout;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ah:Lchat/ola/vn/view/i;

    invoke-virtual {p1, v0}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ah:Lchat/ola/vn/view/i;
    :try_end_7
    .catch Ljava/lang/Throwable; {:try_start_7 .. :try_end_7} :catch_0

    goto/16 :goto_1

    :pswitch_4
    :try_start_8
    invoke-direct {p0, v2}, Lchat/ola/vn/activity/OlaChatViewActivity;->i(Z)V

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->aq()V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ag:Lchat/ola/vn/view/h;

    if-nez p1, :cond_a

    new-instance p1, Lchat/ola/vn/view/h;

    invoke-direct {p1, p0}, Lchat/ola/vn/view/h;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ag:Lchat/ola/vn/view/h;

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ag:Lchat/ola/vn/view/h;

    invoke-virtual {p1, p0}, Lchat/ola/vn/view/h;->setOlaSmileyListener(Lchat/ola/vn/view/h$b;)V
    :try_end_8
    .catch Ljava/lang/Throwable; {:try_start_8 .. :try_end_8} :catch_2

    :cond_a
    :try_start_9
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->al:Lchat/ola/vn/view/d;

    if-eqz p1, :cond_b

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->al:Lchat/ola/vn/view/d;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ag:Lchat/ola/vn/view/h;

    if-eq p1, v0, :cond_e

    :cond_b
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->av:Landroid/widget/FrameLayout;

    invoke-virtual {p1}, Landroid/widget/FrameLayout;->removeAllViews()V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->av:Landroid/widget/FrameLayout;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ag:Lchat/ola/vn/view/h;

    invoke-virtual {p1, v0}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ag:Lchat/ola/vn/view/h;

    iput-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->al:Lchat/ola/vn/view/d;
    :try_end_9
    .catch Ljava/lang/Throwable; {:try_start_9 .. :try_end_9} :catch_1

    goto :goto_3

    :pswitch_5
    :try_start_a
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->av:Landroid/widget/FrameLayout;

    invoke-virtual {v0}, Landroid/widget/FrameLayout;->removeAllViews()V

    invoke-direct {p0, v1}, Lchat/ola/vn/activity/OlaChatViewActivity;->i(Z)V

    if-eqz p1, :cond_c

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->aq()V

    goto :goto_3

    :cond_c
    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->ar()V

    goto :goto_3

    :catch_0
    :cond_d
    :goto_2
    const/4 v2, 0x0

    :catch_1
    :cond_e
    :goto_3
    if-eqz v2, :cond_f

    new-instance p1, Lchat/ola/vn/activity/OlaChatViewActivity$24;

    invoke-direct {p1, p0}, Lchat/ola/vn/activity/OlaChatViewActivity$24;-><init>(Lchat/ola/vn/activity/OlaChatViewActivity;)V

    invoke-static {p1}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V
    :try_end_a
    .catch Ljava/lang/Throwable; {:try_start_a .. :try_end_a} :catch_2

    :catch_2
    :cond_f
    return-void

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method static synthetic k(Lchat/ola/vn/activity/OlaChatViewActivity;)Landroid/widget/FrameLayout;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->t:Landroid/widget/FrameLayout;

    return-object p0
.end method

.method static synthetic l(Lchat/ola/vn/activity/OlaChatViewActivity;)Lchat/ola/vn/b/o;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->o:Lchat/ola/vn/b/o;

    return-object p0
.end method

.method static synthetic m(Lchat/ola/vn/activity/OlaChatViewActivity;)Landroid/widget/ListView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->p:Landroid/widget/ListView;

    return-object p0
.end method

.method private m(Ljava/lang/String;)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->r:Landroid/widget/TextView;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->r:Landroid/widget/TextView;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->s:Landroid/widget/ImageView;

    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->U:Landroid/view/View;

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->s:Landroid/widget/ImageView;

    invoke-virtual {p1}, Landroid/widget/ImageView;->getDrawable()Landroid/graphics/drawable/Drawable;

    move-result-object p1

    check-cast p1, Landroid/graphics/drawable/AnimationDrawable;

    invoke-virtual {p1}, Landroid/graphics/drawable/AnimationDrawable;->start()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic n(Lchat/ola/vn/activity/OlaChatViewActivity;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->S()V

    return-void
.end method

.method private n(Ljava/lang/String;)V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    if-nez v0, :cond_0

    return-void

    :cond_0
    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz v0, :cond_1

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->ag()Lchat/ola/vn/message/d;

    move-result-object v0

    const/4 v1, 0x2

    invoke-static {v0, v1, p1}, Lchat/ola/vn/message/e;->a(Lchat/ola/vn/message/d;BLjava/lang/String;)Lchat/ola/vn/message/aa;

    move-result-object v0

    invoke-direct {p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->c(Lchat/ola/vn/message/d;)V

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    new-instance v2, Lchat/ola/vn/activity/OlaChatViewActivity$11;

    invoke-direct {v2, p0, v0, p1, v1}, Lchat/ola/vn/activity/OlaChatViewActivity$11;-><init>(Lchat/ola/vn/activity/OlaChatViewActivity;Lchat/ola/vn/message/aa;Ljava/lang/String;Lchat/ola/vn/message/f;)V

    invoke-virtual {v0, v2}, Lchat/ola/vn/message/aa;->a(Ljava/lang/Runnable;)V

    invoke-interface {v2}, Ljava/lang/Runnable;->run()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_1
    return-void
.end method

.method static synthetic o(Lchat/ola/vn/activity/OlaChatViewActivity;)Landroid/widget/TextView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ac:Landroid/widget/TextView;

    return-object p0
.end method

.method private o(Ljava/lang/String;)V
    .locals 1

    new-instance v0, Lchat/ola/vn/activity/OlaChatViewActivity$18;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/activity/OlaChatViewActivity$18;-><init>(Lchat/ola/vn/activity/OlaChatViewActivity;Ljava/lang/String;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method static synthetic p(Lchat/ola/vn/activity/OlaChatViewActivity;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->al()V

    return-void
.end method

.method private p(Ljava/lang/String;)V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->q:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->q:Landroid/widget/EditText;

    invoke-virtual {v1}, Landroid/widget/EditText;->getSelectionStart()I

    move-result v1

    if-ltz v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->q:Landroid/widget/EditText;

    invoke-virtual {v1}, Landroid/widget/EditText;->getSelectionStart()I

    move-result v1

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v1, p1}, Ljava/lang/StringBuilder;->insert(ILjava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->q:Landroid/widget/EditText;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {p0, v2}, Lchat/ola/vn/activity/OlaChatViewActivity;->q(Ljava/lang/String;)Ljava/lang/CharSequence;

    move-result-object v2

    invoke-virtual {v0, v2}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->q:Landroid/widget/EditText;

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v2

    add-int/2addr v1, v2

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setSelection(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->q:Landroid/widget/EditText;

    invoke-virtual {v0, p1}, Landroid/widget/EditText;->append(Ljava/lang/CharSequence;)V

    return-void
.end method

.method private q(Ljava/lang/String;)Ljava/lang/CharSequence;
    .locals 1

    const/4 v0, 0x0

    invoke-static {p1, v0}, Lchat/ola/vn/util/i;->a(Ljava/lang/String;Lcom/mg/ola/common/widget/OlaTextView$b;)Ljava/lang/CharSequence;

    move-result-object p1

    return-object p1
.end method

.method static synthetic q(Lchat/ola/vn/activity/OlaChatViewActivity;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->ah()V

    return-void
.end method

.method static synthetic r(Lchat/ola/vn/activity/OlaChatViewActivity;)Landroid/app/Dialog;
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->aj()Landroid/app/Dialog;

    move-result-object p0

    return-object p0
.end method

.method static synthetic s(Lchat/ola/vn/activity/OlaChatViewActivity;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->X()V

    return-void
.end method

.method static synthetic t(Lchat/ola/vn/activity/OlaChatViewActivity;)Landroid/support/v4/widget/DrawerLayout;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->N:Landroid/support/v4/widget/DrawerLayout;

    return-object p0
.end method

.method static synthetic u(Lchat/ola/vn/activity/OlaChatViewActivity;)I
    .locals 0

    iget p0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->aw:I

    return p0
.end method

.method static synthetic v(Lchat/ola/vn/activity/OlaChatViewActivity;)Lchat/ola/vn/i/c;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ay:Lchat/ola/vn/i/c;

    return-object p0
.end method

.method static synthetic w(Lchat/ola/vn/activity/OlaChatViewActivity;)Lchat/ola/vn/message/d;
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->ag()Lchat/ola/vn/message/d;

    move-result-object p0

    return-object p0
.end method


# virtual methods
.method public C()V
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    if-eqz v0, :cond_0

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v2}, Lchat/ola/vn/message/f;->k()S

    move-result v2

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/message/g;->d(Ljava/lang/String;S)Lchat/ola/vn/message/f;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-direct {p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Lchat/ola/vn/message/f;)V

    :cond_0
    return-void
.end method

.method public D()V
    .locals 0

    return-void
.end method

.method public E()V
    .locals 0

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

.method public H()Z
    .locals 1

    const/4 v0, 0x1

    return v0
.end method

.method public I()Z
    .locals 1

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->an()V

    const/4 v0, 0x0

    iput v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ae:I

    invoke-direct {p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->j(Z)V

    const/4 v0, 0x1

    return v0
.end method

.method public J()Z
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->av:Landroid/widget/FrameLayout;

    invoke-virtual {v0}, Landroid/widget/FrameLayout;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    const/4 v1, -0x1

    iput v1, v0, Landroid/view/ViewGroup$LayoutParams;->height:I

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->av:Landroid/widget/FrameLayout;

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
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->av:Landroid/widget/FrameLayout;

    invoke-virtual {v0}, Landroid/widget/FrameLayout;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    iget v1, v0, Landroid/view/ViewGroup$LayoutParams;->height:I

    sget v2, Lchat/ola/vn/activity/OlaChatViewActivity;->g:I

    if-eq v1, v2, :cond_0

    sget v1, Lchat/ola/vn/activity/OlaChatViewActivity;->g:I

    iput v1, v0, Landroid/view/ViewGroup$LayoutParams;->height:I

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->av:Landroid/widget/FrameLayout;

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
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->q:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->q:Landroid/widget/EditText;

    invoke-virtual {v1}, Landroid/widget/EditText;->getSelectionStart()I

    move-result v1

    if-ltz v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->q:Landroid/widget/EditText;

    invoke-virtual {v1}, Landroid/widget/EditText;->getSelectionStart()I

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

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->q:Landroid/widget/EditText;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->q:Landroid/widget/EditText;

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setSelection(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public M()V
    .locals 0

    return-void
.end method

.method public N()V
    .locals 1

    invoke-static {p0}, Lchat/ola/vn/n/b;->b(Landroid/content/Context;)Z

    move-result v0

    if-nez v0, :cond_0

    const/16 v0, 0x65

    invoke-static {p0, v0}, Lchat/ola/vn/n/b;->a(Landroid/app/Activity;I)V

    return-void

    :cond_0
    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->at()V

    return-void
.end method

.method public O()V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, v0}, Lchat/ola/vn/transferken/OlaTransferKenActivity;->a(Landroid/content/Context;Ljava/lang/String;)V

    return-void
.end method

.method public P()V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, v0}, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->a(Landroid/content/Context;Ljava/lang/String;)V

    return-void
.end method

.method public Q()V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, v0}, Lchat/ola/vn/activity/BuyVipActivity;->c(Landroid/content/Context;Ljava/lang/String;)V

    return-void
.end method

.method protected a()V
    .locals 5

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->X:Lchat/ola/vn/util/d/a;

    invoke-virtual {v0}, Lchat/ola/vn/util/d/a;->a()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :try_start_1
    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v0

    iget v0, v0, Landroid/content/res/Configuration;->orientation:I

    iput v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->az:I
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->G:Ljava/lang/Runnable;

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/activity/OlaChatViewActivity$38;

    invoke-direct {v0, p0}, Lchat/ola/vn/activity/OlaChatViewActivity$38;-><init>(Lchat/ola/vn/activity/OlaChatViewActivity;)V

    iput-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->G:Ljava/lang/Runnable;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->F:Landroid/os/Handler;

    if-nez v0, :cond_1

    new-instance v0, Landroid/os/Handler;

    invoke-direct {v0}, Landroid/os/Handler;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->F:Landroid/os/Handler;

    goto :goto_0

    :cond_1
    :try_start_2
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->F:Landroid/os/Handler;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->G:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    :catch_2
    :goto_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->F:Landroid/os/Handler;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->G:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v0, p0}, Lchat/ola/vn/message/g;->a(Lchat/ola/vn/p/f;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->q:Landroid/widget/EditText;

    invoke-virtual {v0, p0}, Landroid/widget/EditText;->addTextChangedListener(Landroid/text/TextWatcher;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    const/4 v1, 0x0

    const/4 v2, 0x1

    if-eqz v0, :cond_3

    sget-object v0, Lchat/ola/vn/activity/OlaChatViewActivity;->e:Ljava/lang/String;

    if-eqz v0, :cond_2

    sget-object v0, Lchat/ola/vn/activity/OlaChatViewActivity;->e:Ljava/lang/String;

    sget-short v3, Lchat/ola/vn/activity/OlaChatViewActivity;->f:S

    invoke-static {v0, v3}, Lchat/ola/vn/message/f;->b(Ljava/lang/String;S)Ljava/lang/String;

    move-result-object v0

    iget-object v3, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v3}, Lchat/ola/vn/message/f;->y()Ljava/lang/String;

    move-result-object v3

    invoke-static {v0, v3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_4

    goto :goto_1

    :cond_2
    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    iget-object v3, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v3}, Lchat/ola/vn/message/f;->k()S

    move-result v3

    invoke-virtual {v0, v1, v3, v2}, Lchat/ola/vn/message/g;->b(Ljava/lang/String;SZ)Lchat/ola/vn/message/f;

    move-result-object v0

    invoke-direct {p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Lchat/ola/vn/message/f;)V

    goto :goto_2

    :cond_3
    sget-object v0, Lchat/ola/vn/activity/OlaChatViewActivity;->e:Ljava/lang/String;

    if-eqz v0, :cond_5

    :goto_1
    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    sget-object v3, Lchat/ola/vn/activity/OlaChatViewActivity;->e:Ljava/lang/String;

    sget-short v4, Lchat/ola/vn/activity/OlaChatViewActivity;->f:S

    invoke-virtual {v0, v3, v4, v2}, Lchat/ola/vn/message/g;->b(Ljava/lang/String;SZ)Lchat/ola/vn/message/f;

    move-result-object v0

    invoke-direct {p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Lchat/ola/vn/message/f;)V

    sput-object v1, Lchat/ola/vn/activity/OlaChatViewActivity;->e:Ljava/lang/String;

    :cond_4
    :goto_2
    :try_start_3
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->U()I

    move-result v0

    invoke-static {p0, v0}, Lchat/ola/vn/util/c/b;->a(Landroid/content/Context;I)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_3

    goto :goto_3

    :catch_3
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    :goto_3
    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->X()V

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->af()Z

    :try_start_4
    sget-object v0, Lchat/ola/vn/OlaApplication;->c:Lchat/ola/vn/balloon/OlaBalloonService;

    invoke-virtual {v0}, Lchat/ola/vn/balloon/OlaBalloonService;->a()V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_4

    :catch_4
    return-void

    :cond_5
    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->onBackPressed()V

    return-void
.end method

.method public a(ILjava/lang/String;[B[Lchat/ola/vn/entity/d;S)V
    .locals 0

    return-void
.end method

.method public a(Lchat/ola/vn/entity/w;)V
    .locals 3

    :try_start_0
    invoke-virtual {p1}, Lchat/ola/vn/entity/w;->a()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    const/4 v2, 0x0

    if-nez v1, :cond_0

    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "##"

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v0, "#"

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1, v2, v2}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Ljava/lang/String;IZ)V

    return-void

    :cond_0
    invoke-virtual {p1}, Lchat/ola/vn/entity/w;->c()I

    move-result v0

    if-lez v0, :cond_1

    const/4 v0, 0x0

    invoke-virtual {p1}, Lchat/ola/vn/entity/w;->c()I

    move-result p1

    invoke-direct {p0, v0, p1, v2}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Ljava/lang/String;IZ)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method

.method protected a(Lchat/ola/vn/message/d;)V
    .locals 4

    :try_start_0
    invoke-virtual {p1}, Lchat/ola/vn/message/d;->i()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    sget-object v1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {p1}, Lchat/ola/vn/message/d;->i()Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x0

    invoke-virtual {v1, v2, v3}, Lchat/ola/vn/message/g;->e(Ljava/lang/String;S)Lchat/ola/vn/message/f;

    move-result-object v1

    if-nez v1, :cond_1

    new-instance v1, Lchat/ola/vn/message/f;

    invoke-virtual {p1}, Lchat/ola/vn/message/d;->i()Ljava/lang/String;

    move-result-object p1

    invoke-direct {v1, p1, v3}, Lchat/ola/vn/message/f;-><init>(Ljava/lang/String;S)V

    :cond_1
    invoke-virtual {v1}, Lchat/ola/vn/message/f;->k()S

    move-result p1

    packed-switch p1, :pswitch_data_0

    return-void

    :pswitch_0
    invoke-virtual {v1}, Lchat/ola/vn/message/f;->u()B

    move-result p1

    const/4 v2, 0x1

    if-eq p1, v2, :cond_2

    const p1, 0x7f0f0550

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object p1

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_2
    const p1, 0x7f0f0465

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object p1

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const p1, 0x7f0f069f

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object p1

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->u()B

    move-result p1

    if-eq p1, v2, :cond_3

    const p1, 0x7f0f0439

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object p1

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_3
    :pswitch_1
    new-instance p1, Lchat/ola/vn/i/m;

    invoke-direct {p1, p0}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    invoke-virtual {p1, v0}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance v2, Lchat/ola/vn/activity/OlaChatViewActivity$5;

    invoke-direct {v2, p0, v0, v1}, Lchat/ola/vn/activity/OlaChatViewActivity$5;-><init>(Lchat/ola/vn/activity/OlaChatViewActivity;Ljava/util/List;Lchat/ola/vn/message/f;)V

    invoke-virtual {p1, v2}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {p1}, Lchat/ola/vn/i/m;->show()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method

.method public a(Lchat/ola/vn/message/d;BB)V
    .locals 0

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->o:Lchat/ola/vn/b/o;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->o:Lchat/ola/vn/b/o;

    invoke-virtual {p1}, Lchat/ola/vn/b/o;->notifyDataSetChanged()V

    :cond_0
    return-void
.end method

.method public a(Lchat/ola/vn/message/f;ILjava/lang/String;Ljava/util/List;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lchat/ola/vn/message/f;",
            "I",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/d;",
            ">;)V"
        }
    .end annotation

    const/4 p4, 0x0

    :try_start_0
    invoke-direct {p0, p4}, Lchat/ola/vn/activity/OlaChatViewActivity;->e(Z)V

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->S()V

    if-lez p2, :cond_2

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {p1, v0}, Lchat/ola/vn/message/f;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_2

    invoke-static {p3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_0

    invoke-direct {p0, p4}, Lchat/ola/vn/activity/OlaChatViewActivity;->h(Z)V

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->p:Landroid/widget/ListView;

    invoke-virtual {p1}, Landroid/widget/ListView;->getFirstVisiblePosition()I

    move-result p1

    add-int/2addr p1, p2

    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->o:Lchat/ola/vn/b/o;

    if-eqz p2, :cond_1

    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->o:Lchat/ola/vn/b/o;

    invoke-virtual {p2}, Lchat/ola/vn/b/o;->notifyDataSetChanged()V

    :cond_1
    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->p:Landroid/widget/ListView;

    invoke-virtual {p2, p1}, Landroid/widget/ListView;->setSelection(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_2
    return-void
.end method

.method public a(Lchat/ola/vn/message/f;Lchat/ola/vn/message/d;)V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    if-eqz v0, :cond_5

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->z()I

    move-result v0

    if-lez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lchat/ola/vn/message/f;->a(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->A()V

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->y()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->y()Ljava/lang/String;

    move-result-object p1

    invoke-static {v0, p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_4

    invoke-virtual {p2}, Lchat/ola/vn/message/d;->d()B

    move-result p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    const/4 v0, 0x1

    if-ne p1, v0, :cond_2

    :try_start_1
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->p:Landroid/widget/ListView;

    invoke-virtual {p1}, Landroid/widget/ListView;->getLastVisiblePosition()I

    move-result p1

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->p:Landroid/widget/ListView;

    invoke-virtual {v1, p1}, Landroid/widget/ListView;->getItemAtPosition(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/message/d;

    invoke-virtual {p1}, Lchat/ola/vn/message/d;->p()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2}, Lchat/ola/vn/message/d;->p()Ljava/lang/String;

    move-result-object v1

    invoke-static {p1, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_1

    invoke-direct {p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->g(Z)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :cond_1
    :try_start_2
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    iget p1, p1, Lchat/ola/vn/message/f;->D:I

    if-gez p1, :cond_2

    invoke-direct {p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->h(Z)V

    :cond_2
    invoke-virtual {p2}, Lchat/ola/vn/message/d;->e()B

    move-result p1

    if-nez p1, :cond_3

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->ac()V

    :cond_3
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->o:Lchat/ola/vn/b/o;

    invoke-virtual {p1}, Lchat/ola/vn/b/o;->notifyDataSetChanged()V

    :cond_4
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->K:Lchat/ola/vn/b/r;

    invoke-virtual {p1}, Lchat/ola/vn/b/r;->notifyDataSetChanged()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    :cond_5
    return-void
.end method

.method public a(Lchat/ola/vn/message/f;Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lchat/ola/vn/message/f;",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/d;",
            ">;)V"
        }
    .end annotation

    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {p1, p2}, Lchat/ola/vn/message/f;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_0

    const/4 p1, 0x0

    invoke-direct {p0, p1}, Lchat/ola/vn/activity/OlaChatViewActivity;->e(Z)V

    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->o:Lchat/ola/vn/b/o;

    if-eqz p2, :cond_0

    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->o:Lchat/ola/vn/b/o;

    invoke-virtual {p2}, Lchat/ola/vn/b/o;->notifyDataSetChanged()V

    invoke-direct {p0, p1}, Lchat/ola/vn/activity/OlaChatViewActivity;->h(Z)V

    :cond_0
    return-void
.end method

.method public a(Ljava/lang/String;I)V
    .locals 0

    invoke-super {p0, p1, p2}, Lchat/ola/vn/c;->a(Ljava/lang/String;I)V

    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {p2}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_0

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->am()V

    :cond_0
    return-void
.end method

.method public a(Ljava/lang/String;I[I[I)V
    .locals 0

    invoke-super {p0, p1, p2, p3, p4}, Lchat/ola/vn/c;->a(Ljava/lang/String;I[I[I)V

    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {p2}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    invoke-super/range {p0 .. p6}, Lchat/ola/vn/c;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->z:Lchat/ola/vn/i/c;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->z:Lchat/ola/vn/i/c;

    invoke-virtual {p1}, Lchat/ola/vn/i/c;->a()V

    :cond_0
    sget-object p1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    const/4 p2, 0x2

    const/4 p4, 0x1

    invoke-virtual {p1, p3, p2, p4}, Lchat/ola/vn/message/g;->b(Ljava/lang/String;SZ)Lchat/ola/vn/message/f;

    move-result-object p1

    invoke-direct {p0, p1}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Lchat/ola/vn/message/f;)V

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->X()V

    const/4 p1, 0x0

    invoke-direct {p0, p1}, Lchat/ola/vn/activity/OlaChatViewActivity;->h(Z)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public a(ZI)V
    .locals 3

    const/4 v0, 0x0

    if-eqz p1, :cond_1

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->ak()V

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
    iput p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->aw:I

    iput v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ae:I

    goto :goto_0

    :cond_1
    sget p2, Lchat/ola/vn/activity/OlaChatViewActivity;->g:I

    if-nez p2, :cond_2

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->getResources()Landroid/content/res/Resources;

    move-result-object p2

    const v1, 0x7f07012a

    invoke-virtual {p2, v1}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result p2

    sput p2, Lchat/ola/vn/activity/OlaChatViewActivity;->g:I

    :cond_2
    :goto_0
    invoke-direct {p0, p1}, Lchat/ola/vn/activity/OlaChatViewActivity;->j(Z)V

    iget p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ae:I

    if-nez p1, :cond_3

    invoke-direct {p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->i(Z)V

    :cond_3
    return-void
.end method

.method public a_()V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->o:Lchat/ola/vn/b/o;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->o:Lchat/ola/vn/b/o;

    invoke-virtual {v0}, Lchat/ola/vn/b/o;->notifyDataSetChanged()V

    :cond_0
    return-void
.end method

.method public a_(Ljava/lang/String;)V
    .locals 3

    :try_start_0
    new-instance v0, Lchat/ola/vn/message/d;

    invoke-direct {v0}, Lchat/ola/vn/message/d;-><init>()V

    new-instance v1, Lchat/ola/vn/message/p;

    const/4 v2, 0x2

    invoke-direct {v1, v0, v2}, Lchat/ola/vn/message/p;-><init>(Lchat/ola/vn/message/d;B)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Lchat/ola/vn/message/p;->e(Ljava/lang/String;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->k()S

    move-result v0

    invoke-virtual {v1, v0}, Lchat/ola/vn/message/p;->c(S)V

    new-instance v0, Ljava/util/ArrayList;

    const/4 v2, 0x1

    invoke-direct {v0, v2}, Ljava/util/ArrayList;-><init>(I)V

    invoke-static {p1}, Lchat/ola/vn/entity/ab;->a(Ljava/lang/String;)Lchat/ola/vn/entity/ab;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    invoke-virtual {v1, v0}, Lchat/ola/vn/message/p;->b(Ljava/util/List;)V

    if-eqz v1, :cond_0

    invoke-direct {p0, v1}, Lchat/ola/vn/activity/OlaChatViewActivity;->c(Lchat/ola/vn/message/d;)V

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    new-instance v2, Lchat/ola/vn/activity/OlaChatViewActivity$27;

    invoke-direct {v2, p0, v1, p1, v0}, Lchat/ola/vn/activity/OlaChatViewActivity$27;-><init>(Lchat/ola/vn/activity/OlaChatViewActivity;Lchat/ola/vn/message/p;Ljava/lang/String;Lchat/ola/vn/message/f;)V

    invoke-virtual {v1, v2}, Lchat/ola/vn/message/p;->a(Ljava/lang/Runnable;)V

    invoke-interface {v2}, Ljava/lang/Runnable;->run()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public afterTextChanged(Landroid/text/Editable;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/activity/OlaChatViewActivity;->b(Ljava/lang/CharSequence;)V

    return-void
.end method

.method public b(Lchat/ola/vn/message/f;)V
    .locals 0

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->K:Lchat/ola/vn/b/r;

    invoke-virtual {p1}, Lchat/ola/vn/b/r;->notifyDataSetChanged()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public b(Lchat/ola/vn/message/f;Lchat/ola/vn/message/d;)V
    .locals 0

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->o:Lchat/ola/vn/b/o;

    invoke-virtual {p1}, Lchat/ola/vn/b/o;->notifyDataSetChanged()V

    return-void
.end method

.method public b(Ljava/lang/Short;I)V
    .locals 0

    return-void
.end method

.method public b(Lchat/ola/vn/message/d;)Z
    .locals 6

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iget-boolean v1, p1, Lchat/ola/vn/message/d;->w:Z

    if-nez v1, :cond_0

    iget-object v1, p1, Lchat/ola/vn/message/d;->p:Ljava/lang/Long;

    if-eqz v1, :cond_0

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    iget-object v3, p1, Lchat/ola/vn/message/d;->p:Ljava/lang/Long;

    invoke-virtual {v3}, Ljava/lang/Long;->longValue()J

    move-result-wide v3

    cmp-long v5, v1, v3

    if-gez v5, :cond_0

    const v1, 0x7f0f05f4

    goto :goto_0

    :cond_0
    iget-boolean v1, p1, Lchat/ola/vn/message/d;->x:Z

    if-nez v1, :cond_1

    const v1, 0x7f0f043d

    :goto_0
    invoke-virtual {p0, v1}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_1
    invoke-virtual {p1}, Lchat/ola/vn/message/d;->w()Z

    move-result v1

    if-eqz v1, :cond_2

    const v1, 0x7f0f0491

    invoke-virtual {p0, v1}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v1, 0x7f0f0493

    invoke-virtual {p0, v1}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_2
    invoke-virtual {p1}, Lchat/ola/vn/message/d;->e()B

    move-result v1

    const/4 v2, 0x1

    if-ne v1, v2, :cond_3

    const v1, 0x7f0f00fa

    invoke-virtual {p0, v1}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_3
    const v1, 0x7f0f04a6

    invoke-virtual {p0, v1}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v1, Lchat/ola/vn/i/m;

    invoke-direct {v1, p0}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    invoke-virtual {v1, v0}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance v3, Lchat/ola/vn/activity/OlaChatViewActivity$15;

    invoke-direct {v3, p0, v0, p1}, Lchat/ola/vn/activity/OlaChatViewActivity$15;-><init>(Lchat/ola/vn/activity/OlaChatViewActivity;Ljava/util/List;Lchat/ola/vn/message/d;)V

    invoke-virtual {v1, v3}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {v1}, Lchat/ola/vn/i/m;->show()V

    return v2
.end method

.method public b_()V
    .locals 0

    return-void
.end method

.method public beforeTextChanged(Ljava/lang/CharSequence;III)V
    .locals 0

    return-void
.end method

.method public c(I)V
    .locals 2

    if-nez p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->w:Landroid/widget/TextView;

    const/16 v0, 0x8

    :goto_0
    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    return-void

    :cond_0
    const/16 v0, 0x64

    if-lt p1, v0, :cond_1

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->w:Landroid/widget/TextView;

    const-string v0, "99+"

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_1

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->w:Landroid/widget/TextView;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string p1, ""

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :goto_1
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->w:Landroid/widget/TextView;

    const/4 v0, 0x0

    goto :goto_0

    return-void
.end method

.method public c(Lchat/ola/vn/message/f;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    if-ne v0, p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    iget-boolean p1, p1, Lchat/ola/vn/message/f;->B:Z

    if-nez p1, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->finish()V

    :cond_0
    return-void
.end method

.method public c(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2

    invoke-super {p0, p1, p2}, Lchat/ola/vn/c;->c(Ljava/lang/String;Ljava/lang/String;)V

    :try_start_0
    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->z:Lchat/ola/vn/i/c;

    if-eqz p2, :cond_0

    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->z:Lchat/ola/vn/i/c;

    invoke-virtual {p2}, Lchat/ola/vn/i/c;->a()V

    :cond_0
    sget-object p2, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    const/4 v0, 0x2

    const/4 v1, 0x1

    invoke-virtual {p2, p1, v0, v1}, Lchat/ola/vn/message/g;->b(Ljava/lang/String;SZ)Lchat/ola/vn/message/f;

    move-result-object p1

    invoke-direct {p0, p1}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Lchat/ola/vn/message/f;)V

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->X()V

    const/4 p1, 0x0

    invoke-direct {p0, p1}, Lchat/ola/vn/activity/OlaChatViewActivity;->h(Z)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public c(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;)V"
        }
    .end annotation

    return-void
.end method

.method public c(Z)V
    .locals 0

    return-void
.end method

.method public d(Lchat/ola/vn/message/f;)V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->y()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->y()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v0, p1}, Lchat/ola/vn/message/f;->b(Lchat/ola/vn/message/f;)V

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->ac()V

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->Z()V

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->K:Lchat/ola/vn/b/r;

    invoke-virtual {p1}, Lchat/ola/vn/b/r;->notifyDataSetChanged()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public d(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    invoke-super {p0, p1, p2}, Lchat/ola/vn/c;->d(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public d(Ljava/util/List;)V
    .locals 5
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

    if-lez v0, :cond_1

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0, p1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "##"

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const/4 v1, 0x0

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    invoke-virtual {p1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, "#"

    invoke-virtual {p1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v2

    const/4 v3, 0x1

    :goto_0
    if-ge v3, v2, :cond_0

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, " ##"

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-interface {v0, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, "#"

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :cond_0
    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    invoke-direct {p0, p1, v1, v1}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Ljava/lang/String;IZ)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method

.method public e(Lchat/ola/vn/message/f;)V
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v0, p1}, Lchat/ola/vn/message/f;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const v0, 0x7f0f01d0

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    iget-object p1, p1, Lchat/ola/vn/message/f;->n:Ljava/lang/String;

    aput-object p1, v1, v2

    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Lchat/ola/vn/activity/OlaChatViewActivity;->m(Ljava/lang/String;)V

    :cond_0
    return-void
.end method

.method public e(Ljava/util/List;)V
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

.method public f(Lchat/ola/vn/message/f;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v0, p1}, Lchat/ola/vn/message/f;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_0

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->ad()V

    :cond_0
    return-void
.end method

.method public f(Ljava/lang/String;)V
    .locals 2

    const v0, 0x7f0f05ad

    :try_start_0
    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object v0

    const v1, 0x7f0f01c8

    invoke-virtual {p0, v1}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {p0, v0, v1}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/app/ProgressDialog;

    move-result-object v0

    new-instance v1, Lchat/ola/vn/activity/OlaChatViewActivity$32;

    invoke-direct {v1, p0, v0, p1}, Lchat/ola/vn/activity/OlaChatViewActivity$32;-><init>(Lchat/ola/vn/activity/OlaChatViewActivity;Landroid/app/ProgressDialog;Ljava/lang/String;)V

    const/4 p1, 0x0

    new-array p1, p1, [Ljava/lang/Void;

    invoke-virtual {v1, p1}, Lchat/ola/vn/activity/OlaChatViewActivity$32;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public f(Ljava/util/List;)V
    .locals 3
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

    if-lez v0, :cond_2

    new-instance v0, Ljava/util/ArrayList;

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v1

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    invoke-static {v1}, Lchat/ola/vn/entity/ab;->a(Ljava/lang/String;)Lchat/ola/vn/entity/ab;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_0
    new-instance p1, Lchat/ola/vn/message/d;

    invoke-direct {p1}, Lchat/ola/vn/message/d;-><init>()V

    new-instance v1, Lchat/ola/vn/message/p;

    const/4 v2, 0x2

    invoke-direct {v1, p1, v2}, Lchat/ola/vn/message/p;-><init>(Lchat/ola/vn/message/d;B)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Lchat/ola/vn/message/p;->e(Ljava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->k()S

    move-result p1

    invoke-virtual {v1, p1}, Lchat/ola/vn/message/p;->c(S)V

    const/4 p1, 0x4

    invoke-virtual {v1, p1}, Lchat/ola/vn/message/p;->b(B)V

    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1, v0}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    invoke-virtual {v1, p1}, Lchat/ola/vn/message/p;->b(Ljava/util/List;)V

    if-eqz v1, :cond_1

    invoke-direct {p0, v1}, Lchat/ola/vn/activity/OlaChatViewActivity;->c(Lchat/ola/vn/message/d;)V

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    new-instance v2, Lchat/ola/vn/activity/OlaChatViewActivity$30;

    invoke-direct {v2, p0, p1, v1, v0}, Lchat/ola/vn/activity/OlaChatViewActivity$30;-><init>(Lchat/ola/vn/activity/OlaChatViewActivity;Ljava/util/List;Lchat/ola/vn/message/p;Lchat/ola/vn/message/f;)V

    invoke-virtual {v1, v2}, Lchat/ola/vn/message/p;->a(Ljava/lang/Runnable;)V

    invoke-interface {v2}, Ljava/lang/Runnable;->run()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_2
    return-void
.end method

.method public finish()V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    iget-boolean v0, v0, Lchat/ola/vn/message/f;->B:Z

    if-eqz v0, :cond_0

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v0, v1}, Lchat/ola/vn/message/g;->a(Lchat/ola/vn/message/f;)Lchat/ola/vn/message/f;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    :try_start_1
    sget-object v0, Lchat/ola/vn/OlaApplication;->c:Lchat/ola/vn/balloon/OlaBalloonService;

    invoke-virtual {v0}, Lchat/ola/vn/balloon/OlaBalloonService;->c()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    invoke-super {p0}, Lchat/ola/vn/c;->finish()V

    const v0, 0x7f01003a

    const v1, 0x7f01003b

    :try_start_2
    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/activity/OlaChatViewActivity;->overridePendingTransition(II)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    :catch_2
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

    invoke-direct {p0, p1}, Lchat/ola/vn/activity/OlaChatViewActivity;->p(Ljava/lang/String;)V

    return-void
.end method

.method public g(Ljava/lang/String;S)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->k()S

    move-result v0

    if-ne v0, p2, :cond_0

    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {p2}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_0

    invoke-static {p0}, Lchat/ola/vn/m/e;->b(Landroid/content/Context;)V

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->finish()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public g(Ljava/util/List;)V
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

.method public g(Lchat/ola/vn/message/f;)Z
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {p1, v0}, Lchat/ola/vn/message/f;->equals(Ljava/lang/Object;)Z

    move-result p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return p1

    :catch_0
    const/4 p1, 0x0

    return p1
.end method

.method public h(Ljava/lang/String;)V
    .locals 0

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaChatViewActivity;->a_(Ljava/lang/String;)V

    return-void
.end method

.method public h(Ljava/lang/String;S)V
    .locals 6

    :try_start_0
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-static {v0}, Lcom/mg/ola/common/d/c;->a(Ljava/io/File;)[B

    move-result-object v0

    if-eqz v0, :cond_2

    array-length v1, v0

    if-lez v1, :cond_2

    array-length v1, v0

    int-to-long v1, v1

    const-wide/32 v3, 0x7d000

    cmp-long v5, v1, v3

    if-gez v5, :cond_2

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    if-eqz v1, :cond_2

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v2}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v3}, Lchat/ola/vn/message/f;->k()S

    move-result v3

    sget-short v4, Lchat/ola/vn/h;->H:S

    const/4 v5, 0x2

    invoke-static {v1, v2, v3, v4, v5}, Lchat/ola/vn/message/e;->a(Ljava/lang/String;Ljava/lang/String;SSB)Lchat/ola/vn/message/t;

    move-result-object v1

    if-eqz v1, :cond_2

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Lchat/ola/vn/message/t;->b(B)V

    invoke-virtual {v1, p1, p2}, Lchat/ola/vn/message/t;->a(Ljava/lang/String;S)V

    invoke-direct {p0, v1}, Lchat/ola/vn/activity/OlaChatViewActivity;->c(Lchat/ola/vn/message/d;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->k()S

    move-result p1

    if-eqz p1, :cond_1

    if-eq p1, v5, :cond_0

    return-void

    :cond_0
    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v1, v0, p2}, Lchat/ola/vn/network/OlaNetworkService;->b(Ljava/lang/String;[BS)V

    return-void

    :cond_1
    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v1, v0, p2}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;[BS)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_2
    return-void
.end method

.method public h(Ljava/util/List;)V
    .locals 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;)V"
        }
    .end annotation

    if-eqz p1, :cond_6

    :try_start_0
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->k()S

    move-result v0

    const/4 v1, 0x0

    const/4 v2, 0x2

    if-ne v0, v2, :cond_2

    if-eqz p1, :cond_6

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_6

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    new-array v0, v0, [Ljava/lang/String;

    :goto_0
    array-length v2, v0

    if-ge v1, v2, :cond_1

    invoke-interface {p1, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/message/f;

    invoke-virtual {v2}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v2

    aput-object v2, v0, v1

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_1
    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v1, v0}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;[Ljava/lang/String;)V

    return-void

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->k()S

    move-result v0

    if-nez v0, :cond_6

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    const/4 v3, 0x1

    const/4 v4, 0x1

    :cond_3
    :goto_1
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_4

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lchat/ola/vn/message/f;

    iget-object v6, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v5, v6}, Lchat/ola/vn/message/f;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_3

    const/4 v4, 0x0

    goto :goto_1

    :cond_4
    if-eqz v4, :cond_5

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-interface {p1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_5
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const v1, 0x7f0f0466

    invoke-static {v1}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, " "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v1

    add-int/2addr v1, v3

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, " "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v1, 0x7f0f0566

    invoke-static {v1}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v1

    sget-object v4, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v1, v4}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sget-object v1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, ".chatgroup."

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v5

    invoke-virtual {v4, v5, v6}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v4, v2, v3}, Lchat/ola/vn/message/g;->b(Ljava/lang/String;SZ)Lchat/ola/vn/message/f;

    move-result-object v1

    invoke-virtual {v1, v0}, Lchat/ola/vn/message/f;->c(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Lchat/ola/vn/message/f;->a(Ljava/util/List;)V

    invoke-direct {p0, v1}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Lchat/ola/vn/message/f;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_6
    return-void
.end method

.method public i(Ljava/lang/String;)V
    .locals 0

    return-void
.end method

.method public i_()Ljava/lang/String;
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->E:Ljava/lang/String;

    if-nez v0, :cond_0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "chat.ola.vn.activity.ChatViewActivity"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->E:Ljava/lang/String;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->E:Ljava/lang/String;

    return-object v0
.end method

.method public j(Ljava/lang/String;)V
    .locals 5

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->k()S

    move-result v0

    const/4 v1, 0x4

    const/4 v2, 0x2

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->k()S

    move-result v0

    if-eq v0, v2, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->k()S

    move-result v0

    if-eq v0, v1, :cond_0

    return-void

    :cond_0
    new-instance v0, Lchat/ola/vn/message/d;

    invoke-direct {v0}, Lchat/ola/vn/message/d;-><init>()V

    new-instance v3, Lchat/ola/vn/message/p;

    invoke-direct {v3, v0, v2}, Lchat/ola/vn/message/p;-><init>(Lchat/ola/vn/message/d;B)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v0}, Lchat/ola/vn/message/p;->e(Ljava/lang/String;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->k()S

    move-result v0

    invoke-virtual {v3, v0}, Lchat/ola/vn/message/p;->c(S)V

    new-instance v0, Ljava/util/ArrayList;

    const/4 v4, 0x1

    invoke-direct {v0, v4}, Ljava/util/ArrayList;-><init>(I)V

    invoke-static {p1}, Lchat/ola/vn/entity/ab;->b(Ljava/lang/String;)Lchat/ola/vn/entity/ab;

    move-result-object v4

    invoke-interface {v0, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-virtual {v3, v0}, Lchat/ola/vn/message/p;->b(Ljava/util/List;)V

    if-eqz v3, :cond_1

    invoke-direct {p0, v3}, Lchat/ola/vn/activity/OlaChatViewActivity;->c(Lchat/ola/vn/message/d;)V

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->k()S

    move-result v0

    if-nez v0, :cond_2

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v3}, Lchat/ola/vn/message/p;->p()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, p1, v2}, Lchat/ola/vn/network/OlaNetworkService;->c(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->k()S

    move-result v0

    if-ne v0, v2, :cond_4

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->X()Z

    move-result v0

    if-eqz v0, :cond_3

    new-instance v0, Lchat/ola/vn/activity/OlaChatViewActivity$28;

    invoke-direct {v0, p0, p1, v3}, Lchat/ola/vn/activity/OlaChatViewActivity$28;-><init>(Lchat/ola/vn/activity/OlaChatViewActivity;Ljava/lang/String;Lchat/ola/vn/message/p;)V

    invoke-direct {p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Ljava/lang/Runnable;)V

    return-void

    :cond_3
    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v3}, Lchat/ola/vn/message/p;->p()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, p1, v2}, Lchat/ola/vn/network/OlaNetworkService;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void

    :cond_4
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->k()S

    move-result v0

    if-ne v0, v1, :cond_5

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "##"

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, "#"

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const/4 v1, 0x0

    invoke-virtual {v3}, Lchat/ola/vn/message/p;->p()Ljava/lang/String;

    move-result-object v4

    invoke-direct {p0, v0, p1, v1, v4}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Lchat/ola/vn/message/f;Ljava/lang/String;ILjava/lang/String;)V

    invoke-virtual {v3, v2}, Lchat/ola/vn/message/p;->b(B)V

    :cond_5
    return-void
.end method

.method public k(Ljava/lang/String;)V
    .locals 5

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->k()S

    move-result v0

    const/4 v1, 0x4

    const/4 v2, 0x2

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->k()S

    move-result v0

    if-eq v0, v2, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->k()S

    move-result v0

    if-eq v0, v1, :cond_0

    return-void

    :cond_0
    new-instance v0, Lchat/ola/vn/message/d;

    invoke-direct {v0}, Lchat/ola/vn/message/d;-><init>()V

    new-instance v3, Lchat/ola/vn/message/p;

    invoke-direct {v3, v0, v2}, Lchat/ola/vn/message/p;-><init>(Lchat/ola/vn/message/d;B)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v0}, Lchat/ola/vn/message/p;->e(Ljava/lang/String;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->k()S

    move-result v0

    invoke-virtual {v3, v0}, Lchat/ola/vn/message/p;->c(S)V

    new-instance v0, Ljava/util/ArrayList;

    const/4 v4, 0x1

    invoke-direct {v0, v4}, Ljava/util/ArrayList;-><init>(I)V

    invoke-static {p1}, Lchat/ola/vn/entity/ab;->c(Ljava/lang/String;)Lchat/ola/vn/entity/ab;

    move-result-object v4

    invoke-interface {v0, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-virtual {v3, v0}, Lchat/ola/vn/message/p;->b(Ljava/util/List;)V

    if-eqz v3, :cond_1

    invoke-direct {p0, v3}, Lchat/ola/vn/activity/OlaChatViewActivity;->c(Lchat/ola/vn/message/d;)V

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->k()S

    move-result v0

    if-nez v0, :cond_2

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v3}, Lchat/ola/vn/message/p;->p()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, p1, v2}, Lchat/ola/vn/network/OlaNetworkService;->c(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->k()S

    move-result v0

    if-ne v0, v2, :cond_4

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->X()Z

    move-result v0

    if-eqz v0, :cond_3

    new-instance v0, Lchat/ola/vn/activity/OlaChatViewActivity$29;

    invoke-direct {v0, p0, p1, v3}, Lchat/ola/vn/activity/OlaChatViewActivity$29;-><init>(Lchat/ola/vn/activity/OlaChatViewActivity;Ljava/lang/String;Lchat/ola/vn/message/p;)V

    invoke-direct {p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Ljava/lang/Runnable;)V

    return-void

    :cond_3
    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v3}, Lchat/ola/vn/message/p;->p()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, p1, v2}, Lchat/ola/vn/network/OlaNetworkService;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void

    :cond_4
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->k()S

    move-result v0

    if-ne v0, v1, :cond_5

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "##"

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, "#"

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const/4 v1, 0x0

    invoke-virtual {v3}, Lchat/ola/vn/message/p;->p()Ljava/lang/String;

    move-result-object v4

    invoke-direct {p0, v0, p1, v1, v4}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Lchat/ola/vn/message/f;Ljava/lang/String;ILjava/lang/String;)V

    invoke-virtual {v3, v2}, Lchat/ola/vn/message/p;->b(B)V

    :cond_5
    return-void
.end method

.method public l(Ljava/lang/String;)V
    .locals 0

    :try_start_0
    invoke-direct {p0, p1}, Lchat/ola/vn/activity/OlaChatViewActivity;->n(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public n()V
    .locals 4

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    if-eqz v0, :cond_0

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v2}, Lchat/ola/vn/message/f;->k()S

    move-result v2

    const/4 v3, 0x1

    invoke-virtual {v0, v1, v2, v3}, Lchat/ola/vn/message/g;->b(Ljava/lang/String;SZ)Lchat/ola/vn/message/f;

    move-result-object v0

    invoke-direct {p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Lchat/ola/vn/message/f;)V

    :cond_0
    return-void
.end method

.method protected onActivityResult(IILandroid/content/Intent;)V
    .locals 0

    const/4 p3, 0x2

    if-ne p1, p3, :cond_0

    const/4 p1, -0x1

    if-ne p2, p1, :cond_0

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ax:Ljava/io/File;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ax:Ljava/io/File;

    invoke-virtual {p1}, Ljava/io/File;->exists()Z

    move-result p1

    if-eqz p1, :cond_0

    new-instance p1, Ljava/io/File;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ax:Ljava/io/File;

    invoke-virtual {p2}, Ljava/io/File;->length()J

    move-result-wide p2

    invoke-static {p2, p3}, Lchat/ola/vn/d;->a(J)Ljava/lang/String;

    move-result-object p2

    invoke-direct {p1, p2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ax:Ljava/io/File;

    const/4 p3, 0x1

    invoke-static {p2, p1, p3}, Lcom/mg/ola/common/d/c;->a(Ljava/io/File;Ljava/io/File;Z)V

    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ax:Ljava/io/File;

    invoke-virtual {p2}, Ljava/io/File;->delete()Z

    invoke-virtual {p1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaChatViewActivity;->a_(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    const/4 p1, 0x0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ax:Ljava/io/File;

    return-void
.end method

.method public onBackPressed()V
    .locals 1

    :try_start_0
    iget v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ae:I

    packed-switch v0, :pswitch_data_0

    goto :goto_0

    :pswitch_0
    const/4 v0, 0x0

    iput v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ae:I

    invoke-direct {p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->j(Z)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    :goto_0
    :try_start_1
    sget-object v0, Lchat/ola/vn/activity/OlaChatViewActivity;->Z:Lchat/ola/vn/entity/n;

    invoke-virtual {v0, p0}, Lchat/ola/vn/entity/n;->a(Landroid/content/Context;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x0

    sput-object v0, Lchat/ola/vn/activity/OlaChatViewActivity;->Z:Lchat/ola/vn/entity/n;

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->finish()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    return-void

    :catch_1
    :cond_0
    invoke-super {p0}, Lchat/ola/vn/c;->onBackPressed()V

    return-void

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
    .end packed-switch
.end method

.method public onClick(Landroid/view/View;)V
    .locals 3

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const/4 v0, 0x4

    const/4 v1, 0x1

    const/4 v2, 0x0

    sparse-switch p1, :sswitch_data_0

    return-void

    :sswitch_0
    invoke-direct {p0, v2}, Lchat/ola/vn/activity/OlaChatViewActivity;->f(Z)V

    iput v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ae:I

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->M:Lcom/mg/ola/common/widget/SoftKeyLinearLayout;

    invoke-virtual {p1}, Lcom/mg/ola/common/widget/SoftKeyLinearLayout;->a()Z

    move-result p1

    if-nez p1, :cond_4

    :goto_0
    invoke-direct {p0, v2}, Lchat/ola/vn/activity/OlaChatViewActivity;->j(Z)V

    return-void

    :sswitch_1
    iput-boolean v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->aA:Z

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->q:Landroid/widget/EditText;

    invoke-virtual {p1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1, v2, v1}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Ljava/lang/String;IZ)V

    const p1, 0x7f01001d

    invoke-static {p0, p1}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object p1

    const-wide/16 v0, 0xc8

    invoke-virtual {p1, v0, v1}, Landroid/view/animation/Animation;->setDuration(J)V

    new-instance v0, Lchat/ola/vn/activity/OlaChatViewActivity$3;

    invoke-direct {v0, p0}, Lchat/ola/vn/activity/OlaChatViewActivity$3;-><init>(Lchat/ola/vn/activity/OlaChatViewActivity;)V

    invoke-virtual {p1, v0}, Landroid/view/animation/Animation;->setAnimationListener(Landroid/view/animation/Animation$AnimationListener;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->u:Landroid/widget/Button;

    invoke-virtual {v0, p1}, Landroid/widget/Button;->startAnimation(Landroid/view/animation/Animation;)V

    return-void

    :sswitch_2
    invoke-direct {p0, v1}, Lchat/ola/vn/activity/OlaChatViewActivity;->h(Z)V

    return-void

    :sswitch_3
    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->W()V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->F()Ljava/util/List;

    move-result-object p1

    invoke-static {p0, p1, p0}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->a(Landroid/content/Context;Ljava/util/List;Lchat/ola/vn/contactpicker/OlaContactPickerActivity$b;)V

    return-void

    :sswitch_4
    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->au()Z

    return-void

    :sswitch_5
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->k()S

    move-result p1

    if-nez p1, :cond_4

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    invoke-static {p0, p1, v0, v1}, Lchat/ola/vn/me/c;->a(Landroid/content/Context;Lchat/ola/vn/network/OlaNetworkService;Ljava/lang/String;Lchat/ola/vn/entity/n;)V

    return-void

    :sswitch_6
    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->v()Landroid/app/Dialog;

    return-void

    :sswitch_7
    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->V()V

    return-void

    :sswitch_8
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->k()S

    move-result p1

    if-ne p1, v0, :cond_0

    sget-object p1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {p1}, Lchat/ola/vn/message/g;->q()I

    move-result p1

    if-lez p1, :cond_1

    :cond_0
    invoke-static {p0}, Lchat/ola/vn/m/e;->b(Landroid/content/Context;)V

    goto :goto_1

    :cond_1
    invoke-static {p0}, Lchat/ola/vn/m/l;->a(Landroid/content/Context;)V

    :goto_1
    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->finish()V

    return-void

    :sswitch_9
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->q:Landroid/widget/EditText;

    invoke-virtual {p1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_2

    invoke-direct {p0, p1, v2, v1}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Ljava/lang/String;IZ)V

    return-void

    :cond_2
    invoke-direct {p0, v2}, Lchat/ola/vn/activity/OlaChatViewActivity;->f(Z)V

    const/4 p1, 0x5

    iput p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ae:I

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->M:Lcom/mg/ola/common/widget/SoftKeyLinearLayout;

    invoke-virtual {p1}, Lcom/mg/ola/common/widget/SoftKeyLinearLayout;->a()Z

    move-result p1

    if-nez p1, :cond_4

    goto/16 :goto_0

    :sswitch_a
    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->U()V

    return-void

    :sswitch_b
    const-string p1, "(y)"

    invoke-direct {p0, p1, v2, v2}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Ljava/lang/String;IZ)V

    const p1, 0x7f010057

    invoke-static {p0, p1}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object p1

    const-wide/16 v0, 0x96

    invoke-virtual {p1, v0, v1}, Landroid/view/animation/Animation;->setDuration(J)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->v:Landroid/widget/ImageButton;

    invoke-virtual {v0, p1}, Landroid/widget/ImageButton;->startAnimation(Landroid/view/animation/Animation;)V

    return-void

    :sswitch_c
    invoke-direct {p0, v2}, Lchat/ola/vn/activity/OlaChatViewActivity;->f(Z)V

    const/4 p1, 0x2

    iput p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ae:I

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->M:Lcom/mg/ola/common/widget/SoftKeyLinearLayout;

    invoke-virtual {p1}, Lcom/mg/ola/common/widget/SoftKeyLinearLayout;->a()Z

    move-result p1

    if-nez p1, :cond_4

    goto/16 :goto_0

    :sswitch_d
    iput v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ae:I

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->M:Lcom/mg/ola/common/widget/SoftKeyLinearLayout;

    invoke-virtual {p1}, Lcom/mg/ola/common/widget/SoftKeyLinearLayout;->a()Z

    move-result p1

    if-nez p1, :cond_3

    goto/16 :goto_0

    :cond_3
    invoke-direct {p0, v2}, Lchat/ola/vn/activity/OlaChatViewActivity;->f(Z)V

    return-void

    :sswitch_e
    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->an()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_4
    return-void

    nop

    :sswitch_data_0
    .sparse-switch
        0x7f090143 -> :sswitch_e
        0x7f09015c -> :sswitch_d
        0x7f0902c8 -> :sswitch_c
        0x7f0902d3 -> :sswitch_b
        0x7f090310 -> :sswitch_a
        0x7f090360 -> :sswitch_9
        0x7f09039a -> :sswitch_8
        0x7f09039d -> :sswitch_7
        0x7f0903a1 -> :sswitch_6
        0x7f0903a4 -> :sswitch_5
        0x7f0903fb -> :sswitch_4
        0x7f09041f -> :sswitch_3
        0x7f090447 -> :sswitch_2
        0x7f090466 -> :sswitch_1
        0x7f0905ef -> :sswitch_5
        0x7f090600 -> :sswitch_0
    .end sparse-switch
.end method

.method public onConfigurationChanged(Landroid/content/res/Configuration;)V
    .locals 2

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onConfigurationChanged(Landroid/content/res/Configuration;)V

    iget v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->az:I

    iget v1, p1, Landroid/content/res/Configuration;->orientation:I

    if-eq v0, v1, :cond_0

    iget p1, p1, Landroid/content/res/Configuration;->orientation:I

    iput p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->az:I

    :cond_0
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 3

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    const p1, 0x7f0b0145

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaChatViewActivity;->setContentView(I)V

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->getIntent()Landroid/content/Intent;

    move-result-object p1

    invoke-virtual {p1}, Landroid/content/Intent;->getExtras()Landroid/os/Bundle;

    move-result-object p1

    const-string v0, "_conv_id"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "_conv_type"

    invoke-virtual {p1, v1}, Landroid/os/Bundle;->getShort(Ljava/lang/String;)S

    move-result p1

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    sput-object v0, Lchat/ola/vn/activity/OlaChatViewActivity;->e:Ljava/lang/String;

    sput-short p1, Lchat/ola/vn/activity/OlaChatViewActivity;->f:S
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    :try_start_1
    sget p1, Lchat/ola/vn/activity/OlaChatViewActivity;->g:I

    if-nez p1, :cond_1

    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/e;->e()I

    move-result p1

    sput p1, Lchat/ola/vn/activity/OlaChatViewActivity;->g:I
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    :cond_1
    const p1, 0x7f010023

    invoke-static {p0, p1}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->B:Landroid/view/animation/Animation;

    const p1, 0x7f010021

    invoke-static {p0, p1}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->S:Landroid/view/animation/Animation;

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->S:Landroid/view/animation/Animation;

    const-wide/16 v0, 0xc8

    invoke-virtual {p1, v0, v1}, Landroid/view/animation/Animation;->setDuration(J)V

    const p1, 0x7f010024

    invoke-static {p0, p1}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->T:Landroid/view/animation/Animation;

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->T:Landroid/view/animation/Animation;

    invoke-virtual {p1, v0, v1}, Landroid/view/animation/Animation;->setDuration(J)V

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->T()V

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->ae()V

    new-instance p1, Lchat/ola/vn/b/o;

    const/4 v0, 0x0

    invoke-direct {p1, p0, v0}, Lchat/ola/vn/b/o;-><init>(Landroid/content/Context;Lchat/ola/vn/message/f;)V

    iput-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->o:Lchat/ola/vn/b/o;

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->o:Lchat/ola/vn/b/o;

    new-instance v0, Lchat/ola/vn/activity/OlaChatViewActivity$1;

    invoke-direct {v0, p0}, Lchat/ola/vn/activity/OlaChatViewActivity$1;-><init>(Lchat/ola/vn/activity/OlaChatViewActivity;)V

    invoke-virtual {p1, v0}, Lchat/ola/vn/b/o;->a(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->o:Lchat/ola/vn/b/o;

    invoke-virtual {p1, p0}, Lchat/ola/vn/b/o;->a(Landroid/view/View$OnLongClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->p:Landroid/widget/ListView;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->o:Lchat/ola/vn/b/o;

    invoke-virtual {p1, v0}, Landroid/widget/ListView;->setAdapter(Landroid/widget/ListAdapter;)V

    new-instance p1, Lchat/ola/vn/b/r;

    invoke-direct {p1, p0}, Lchat/ola/vn/b/r;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->K:Lchat/ola/vn/b/r;

    new-instance p1, Lchat/ola/vn/b/z;

    invoke-direct {p1, p0}, Lchat/ola/vn/b/z;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->L:Lchat/ola/vn/b/z;

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->I:Landroid/widget/ListView;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->K:Lchat/ola/vn/b/r;

    invoke-virtual {p1, v0}, Landroid/widget/ListView;->setAdapter(Landroid/widget/ListAdapter;)V

    :try_start_2
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->X:Lchat/ola/vn/util/d/a;

    if-nez p1, :cond_2

    sget-boolean p1, Lchat/ola/vn/c/x;->s:Z

    if-eqz p1, :cond_2

    new-instance p1, Lchat/ola/vn/util/d/a;

    invoke-direct {p1, p0}, Lchat/ola/vn/util/d/a;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->X:Lchat/ola/vn/util/d/a;

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->X:Lchat/ola/vn/util/d/a;

    new-instance v0, Lchat/ola/vn/activity/OlaChatViewActivity$12;

    invoke-direct {v0, p0}, Lchat/ola/vn/activity/OlaChatViewActivity$12;-><init>(Lchat/ola/vn/activity/OlaChatViewActivity;)V

    invoke-virtual {p1, v0}, Lchat/ola/vn/util/d/a;->a(Lchat/ola/vn/util/d/a$a;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    :catch_2
    :cond_2
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->p:Landroid/widget/ListView;

    new-instance v0, Lchat/ola/vn/activity/OlaChatViewActivity$23;

    invoke-direct {v0, p0}, Lchat/ola/vn/activity/OlaChatViewActivity$23;-><init>(Lchat/ola/vn/activity/OlaChatViewActivity;)V

    const-wide/16 v1, 0xbb8

    invoke-virtual {p1, v0, v1, v2}, Landroid/widget/ListView;->postDelayed(Ljava/lang/Runnable;J)Z

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz p1, :cond_3

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {p1, p0}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/network/f;)V

    :cond_3
    return-void
.end method

.method protected onDestroy()V
    .locals 3

    invoke-super {p0}, Lchat/ola/vn/c;->onDestroy()V

    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->F:Landroid/os/Handler;

    iget-object v2, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->G:Ljava/lang/Runnable;

    invoke-virtual {v1, v2}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    iput-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->F:Landroid/os/Handler;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->G:Ljava/lang/Runnable;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->X:Lchat/ola/vn/util/d/a;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :try_start_1
    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->q:Landroid/widget/EditText;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->q:Landroid/widget/EditText;

    invoke-virtual {v1, p0}, Landroid/widget/EditText;->removeTextChangedListener(Landroid/text/TextWatcher;)V

    :cond_0
    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->ad()V

    iput-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    return-void
.end method

.method public onItemClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/widget/AdapterView<",
            "*>;",
            "Landroid/view/View;",
            "IJ)V"
        }
    .end annotation

    :try_start_0
    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->I:Landroid/widget/ListView;

    if-ne p1, p2, :cond_5

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->k()S

    move-result p1

    const/4 p2, 0x4

    if-ne p1, p2, :cond_0

    sget-object p1, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    invoke-virtual {p1, p3}, Lchat/ola/vn/r/a/f;->c(I)Lchat/ola/vn/message/f;

    move-result-object p1

    if-eqz p1, :cond_6

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->ad()V

    invoke-direct {p0, p1}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Lchat/ola/vn/message/f;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->L:Lchat/ola/vn/b/z;

    invoke-virtual {p1}, Lchat/ola/vn/b/z;->notifyDataSetChanged()V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->N:Landroid/support/v4/widget/DrawerLayout;

    if-eqz p1, :cond_6

    :goto_0
    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->W()V

    return-void

    :cond_0
    sget-object p1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {p1, p3}, Lchat/ola/vn/message/g;->c(I)Lchat/ola/vn/message/f;

    move-result-object p1

    if-eqz p1, :cond_6

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->k()S

    move-result p2
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    const/4 p3, 0x5

    if-ne p2, p3, :cond_1

    :try_start_1
    move-object p2, p1

    check-cast p2, Lchat/ola/vn/message/u;

    invoke-virtual {p2, p0}, Lchat/ola/vn/message/u;->a(Landroid/content/Context;)Z

    move-result p2

    if-eqz p2, :cond_4

    sget-object p2, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {p2, p1}, Lchat/ola/vn/message/g;->b(Lchat/ola/vn/message/f;)Lchat/ola/vn/message/f;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_1

    :cond_1
    :try_start_2
    invoke-virtual {p1}, Lchat/ola/vn/message/f;->k()S

    move-result p2

    const/4 p3, 0x6

    if-ne p2, p3, :cond_2

    goto :goto_1

    :cond_2
    invoke-virtual {p1}, Lchat/ola/vn/message/f;->k()S

    move-result p2

    const/4 p3, 0x7

    if-ne p2, p3, :cond_3

    invoke-static {p0}, Lchat/ola/vn/message/OlaOtherPeopleListActivity;->a(Landroid/content/Context;)V

    goto :goto_1

    :cond_3
    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->ad()V

    invoke-direct {p0, p1}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Lchat/ola/vn/message/f;)V

    :catch_0
    :cond_4
    :goto_1
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->K:Lchat/ola/vn/b/r;

    invoke-virtual {p1}, Lchat/ola/vn/b/r;->notifyDataSetChanged()V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->N:Landroid/support/v4/widget/DrawerLayout;

    if-eqz p1, :cond_6

    goto :goto_0

    :cond_5
    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->J:Landroid/widget/ListView;

    if-ne p1, p2, :cond_6

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->O:Lchat/ola/vn/b/n;

    invoke-virtual {p1, p3}, Lchat/ola/vn/b/n;->a(I)Lchat/ola/vn/message/f;

    move-result-object p1

    invoke-direct {p0, p1}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Lchat/ola/vn/message/f;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->N:Landroid/support/v4/widget/DrawerLayout;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    if-eqz p1, :cond_6

    goto :goto_0

    :catch_1
    :cond_6
    return-void
.end method

.method public onLongClick(Landroid/view/View;)Z
    .locals 4

    const/4 v0, 0x0

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v1

    const v2, 0x7f090143

    const/4 v3, 0x1

    if-eq v1, v2, :cond_4

    const v2, 0x7f090158

    if-eq v1, v2, :cond_3

    const v2, 0x7f09015a

    if-eq v1, v2, :cond_3

    const v2, 0x7f090295

    if-eq v1, v2, :cond_3

    const v2, 0x7f0902d3

    if-eq v1, v2, :cond_2

    const v2, 0x7f090310

    if-eq v1, v2, :cond_1

    const v2, 0x7f0903fb

    if-eq v1, v2, :cond_0

    packed-switch v1, :pswitch_data_0

    return v0

    :cond_0
    invoke-static {p0}, Lchat/ola/vn/activity/OlaQuickReplyComposerActivity;->a(Landroid/content/Context;)V

    return v3

    :cond_1
    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->ap()V

    return v3

    :cond_2
    const-string p1, "(Y)"

    invoke-direct {p0, p1, v0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Ljava/lang/String;IZ)V

    const p1, 0x7f010057

    invoke-static {p0, p1}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object p1

    const-wide/16 v1, 0x96

    invoke-virtual {p1, v1, v2}, Landroid/view/animation/Animation;->setDuration(J)V

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->v:Landroid/widget/ImageButton;

    invoke-virtual {v1, p1}, Landroid/widget/ImageButton;->startAnimation(Landroid/view/animation/Animation;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    return v3

    :cond_3
    :pswitch_0
    :try_start_1
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/message/d;

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaChatViewActivity;->b(Lchat/ola/vn/message/d;)Z

    move-result p1
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    return p1

    :catch_0
    return v3

    :cond_4
    :try_start_2
    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->an()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    return v3

    :catch_1
    return v0

    nop

    :pswitch_data_0
    .packed-switch 0x7f090348
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
    .end packed-switch
.end method

.method public onMessageItemButtonClick(Landroid/view/View;)V
    .locals 4

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v1

    sparse-switch v1, :sswitch_data_0

    return-void

    :sswitch_0
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/message/d;

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Lchat/ola/vn/message/d;)V

    return-void

    :sswitch_1
    check-cast v0, Lchat/ola/vn/message/d;

    move-object p1, v0

    check-cast p1, Lchat/ola/vn/message/k;

    invoke-virtual {v0}, Lchat/ola/vn/message/d;->d()B

    move-result v1

    const/4 v2, 0x1

    if-ne v1, v2, :cond_0

    invoke-virtual {v0}, Lchat/ola/vn/message/d;->i()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_0
    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v0

    :goto_0
    invoke-virtual {p1}, Lchat/ola/vn/message/k;->C()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1}, Lchat/ola/vn/message/k;->a()Ljava/lang/String;

    move-result-object p1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "@"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, v1, p1, v0}, Lchat/ola/vn/util/b;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void

    :sswitch_2
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/message/d;

    if-eqz p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->j(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    const/4 v1, 0x0

    invoke-virtual {v0, p1, v1}, Lchat/ola/vn/network/OlaNetworkService;->b(Ljava/lang/String;Ljava/lang/String;)V

    return-void

    :sswitch_3
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/message/d;

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v2}, Lchat/ola/vn/message/f;->k()S

    move-result v2

    invoke-virtual {p1}, Lchat/ola/vn/message/d;->p()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v1, v2, v3}, Lchat/ola/vn/network/OlaNetworkService;->d(Ljava/lang/String;SLjava/lang/String;)V

    const/4 v0, 0x0

    iput-boolean v0, p1, Lchat/ola/vn/message/d;->x:Z

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->o:Lchat/ola/vn/b/o;

    invoke-virtual {p1}, Lchat/ola/vn/b/o;->notifyDataSetChanged()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void

    nop

    :sswitch_data_0
    .sparse-switch
        0x7f090092 -> :sswitch_3
        0x7f0900df -> :sswitch_2
        0x7f090354 -> :sswitch_1
        0x7f090355 -> :sswitch_0
    .end sparse-switch
.end method

.method protected onNewIntent(Landroid/content/Intent;)V
    .locals 2

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onNewIntent(Landroid/content/Intent;)V

    :try_start_0
    invoke-virtual {p1}, Landroid/content/Intent;->getExtras()Landroid/os/Bundle;

    move-result-object p1

    const-string v0, "_conv_id"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "_conv_type"

    invoke-virtual {p1, v1}, Landroid/os/Bundle;->getShort(Ljava/lang/String;)S

    move-result p1

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    sput-object v0, Lchat/ola/vn/activity/OlaChatViewActivity;->e:Ljava/lang/String;

    sput-short p1, Lchat/ola/vn/activity/OlaChatViewActivity;->f:S
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method protected onPause()V
    .locals 1

    invoke-super {p0}, Lchat/ola/vn/c;->onPause()V

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->X:Lchat/ola/vn/util/d/a;

    invoke-virtual {v0}, Lchat/ola/vn/util/d/a;->b()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :try_start_1
    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v0, p0}, Lchat/ola/vn/message/g;->b(Lchat/ola/vn/p/f;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->q:Landroid/widget/EditText;

    invoke-virtual {v0, p0}, Landroid/widget/EditText;->removeTextChangedListener(Landroid/text/TextWatcher;)V

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->ad()V
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

    if-nez p1, :cond_3

    invoke-direct {p0, p2}, Lchat/ola/vn/activity/OlaChatViewActivity;->f(Z)V

    const/4 p1, 0x3

    iput p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ae:I

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->M:Lcom/mg/ola/common/widget/SoftKeyLinearLayout;

    invoke-virtual {p1}, Lcom/mg/ola/common/widget/SoftKeyLinearLayout;->a()Z

    move-result p1

    if-nez p1, :cond_3

    invoke-direct {p0, p2}, Lchat/ola/vn/activity/OlaChatViewActivity;->j(Z)V

    return-void

    :cond_0
    const/16 v0, 0x65

    if-ne p1, v0, :cond_2

    invoke-static {p0}, Lchat/ola/vn/n/b;->b(Landroid/content/Context;)Z

    move-result p1

    if-eqz p1, :cond_1

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->at()V

    return-void

    :cond_1
    const p1, 0x7f0f00a2

    const p2, 0x7f0f0336

    invoke-static {p0, p1, p2}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;II)Landroid/app/Dialog;

    return-void

    :cond_2
    const/16 v0, 0x69

    if-ne p1, v0, :cond_3

    aget p1, p3, p2

    if-nez p1, :cond_3

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->ao()V

    :cond_3
    return-void
.end method

.method protected onRestoreInstanceState(Landroid/os/Bundle;)V
    .locals 3

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onRestoreInstanceState(Landroid/os/Bundle;)V

    if-eqz p1, :cond_1

    const-string v0, "_conv_id"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    const-string v1, "_conv_type"

    invoke-virtual {p1, v1}, Landroid/os/Bundle;->getShort(Ljava/lang/String;)S

    move-result p1

    sget-object v1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    const/4 v2, 0x1

    invoke-virtual {v1, v0, p1, v2}, Lchat/ola/vn/message/g;->b(Ljava/lang/String;SZ)Lchat/ola/vn/message/f;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    return-void

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->finish()V

    :cond_1
    return-void
.end method

.method protected onSaveInstanceState(Landroid/os/Bundle;)V
    .locals 2

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onSaveInstanceState(Landroid/os/Bundle;)V

    if-eqz p1, :cond_1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    if-eqz v0, :cond_0

    const-string v0, "_conv_id"

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "_conv_type"

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->k()S

    move-result v1

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putShort(Ljava/lang/String;S)V

    :cond_0
    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->p:Landroid/widget/ListView;

    invoke-virtual {v0}, Landroid/widget/ListView;->onSaveInstanceState()Landroid/os/Parcelable;

    move-result-object v0

    if-eqz v0, :cond_1

    const-string v1, "BUNDLE_LIST_VIEW_PARCELABLE"

    invoke-virtual {p1, v1, v0}, Landroid/os/Bundle;->putParcelable(Ljava/lang/String;Landroid/os/Parcelable;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method

.method public onScroll(Landroid/widget/AbsListView;III)V
    .locals 1

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    if-eqz p1, :cond_1

    add-int p1, p2, p3

    if-lt p1, p4, :cond_0

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    const/4 v0, -0x1

    iput v0, p1, Lchat/ola/vn/message/f;->D:I

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    iput p2, p1, Lchat/ola/vn/message/f;->D:I

    :cond_1
    :goto_0
    iput p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->am:I

    iput p3, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->an:I

    iput p4, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ao:I

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->o:Lchat/ola/vn/b/o;

    if-eqz p1, :cond_4

    add-int/2addr p3, p2

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->o:Lchat/ola/vn/b/o;

    invoke-virtual {p1}, Lchat/ola/vn/b/o;->getCount()I

    move-result p1

    const/4 p4, 0x0

    if-lt p3, p1, :cond_2

    invoke-direct {p0, p4}, Lchat/ola/vn/activity/OlaChatViewActivity;->g(Z)V

    :cond_2
    if-ltz p2, :cond_4

    iget p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->k:I

    if-eq p1, p2, :cond_4

    iput p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->k:I

    iget p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->k:I

    add-int/lit8 p1, p1, 0x1

    iput p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->l:I

    iget p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->l:I

    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->o:Lchat/ola/vn/b/o;

    invoke-virtual {p2}, Lchat/ola/vn/b/o;->getCount()I

    move-result p2

    add-int/lit8 p2, p2, -0x1

    invoke-static {p1, p2}, Ljava/lang/Math;->min(II)I

    move-result p1

    iput p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->l:I

    iget p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->k:I

    add-int/lit8 p1, p1, -0x1

    iput p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->j:I

    iget p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->j:I

    invoke-static {p1, p4}, Ljava/lang/Math;->max(II)I

    move-result p1

    iput p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->j:I

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->o:Lchat/ola/vn/b/o;

    iget p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->j:I

    invoke-virtual {p1, p2}, Lchat/ola/vn/b/o;->a(I)Lchat/ola/vn/message/d;

    move-result-object p1

    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->o:Lchat/ola/vn/b/o;

    iget p3, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->k:I

    invoke-virtual {p2, p3}, Lchat/ola/vn/b/o;->a(I)Lchat/ola/vn/message/d;

    move-result-object p2

    iget-object p3, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->o:Lchat/ola/vn/b/o;

    iget p4, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->l:I

    invoke-virtual {p3, p4}, Lchat/ola/vn/b/o;->a(I)Lchat/ola/vn/message/d;

    move-result-object p3

    invoke-virtual {p1}, Lchat/ola/vn/message/d;->e()B

    move-result p4

    const/4 v0, 0x4

    if-eq p4, v0, :cond_4

    invoke-virtual {p1}, Lchat/ola/vn/message/d;->e()B

    move-result p4

    if-eq p4, v0, :cond_3

    invoke-virtual {p1}, Lchat/ola/vn/message/d;->m()J

    move-result-wide p1

    invoke-static {}, Lchat/ola/vn/b;->d()Lchat/ola/vn/b;

    move-result-object p3

    invoke-virtual {p3}, Lchat/ola/vn/b;->c()[Ljava/lang/String;

    move-result-object p3

    invoke-static {}, Lchat/ola/vn/b;->d()Lchat/ola/vn/b;

    move-result-object p4

    invoke-virtual {p4}, Lchat/ola/vn/b;->a()[Ljava/lang/String;

    move-result-object p4

    invoke-static {p1, p2, p3, p4}, Lcom/mg/ola/common/d/i;->b(J[Ljava/lang/String;[Ljava/lang/String;)Ljava/lang/CharSequence;

    move-result-object p1

    :goto_1
    invoke-interface {p1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Lchat/ola/vn/activity/OlaChatViewActivity;->o(Ljava/lang/String;)V

    return-void

    :cond_3
    invoke-virtual {p3}, Lchat/ola/vn/message/d;->e()B

    move-result p1

    if-eq p1, v0, :cond_4

    invoke-virtual {p2}, Lchat/ola/vn/message/d;->m()J

    move-result-wide p1

    invoke-static {}, Lchat/ola/vn/b;->d()Lchat/ola/vn/b;

    move-result-object p3

    invoke-virtual {p3}, Lchat/ola/vn/b;->c()[Ljava/lang/String;

    move-result-object p3

    invoke-static {}, Lchat/ola/vn/b;->d()Lchat/ola/vn/b;

    move-result-object p4

    invoke-virtual {p4}, Lchat/ola/vn/b;->a()[Ljava/lang/String;

    move-result-object p4

    invoke-static {p1, p2, p3, p4}, Lcom/mg/ola/common/d/i;->b(J[Ljava/lang/String;[Ljava/lang/String;)Ljava/lang/CharSequence;

    move-result-object p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    :cond_4
    return-void
.end method

.method public onScrollStateChanged(Landroid/widget/AbsListView;I)V
    .locals 4

    if-eqz p2, :cond_0

    return-void

    :cond_0
    const/4 p1, 0x0

    :try_start_0
    iget p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ao:I

    iget v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->am:I

    iget v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->an:I

    add-int/2addr v0, v1

    sub-int/2addr p2, v0

    const/16 v0, 0xa

    const/16 v1, 0x8

    if-le p2, v0, :cond_1

    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ad:Landroid/view/View;

    invoke-virtual {p2}, Landroid/view/View;->getVisibility()I

    move-result p2

    if-ne p2, v1, :cond_2

    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ad:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->S:Landroid/view/animation/Animation;

    invoke-virtual {p2, v0}, Landroid/view/View;->startAnimation(Landroid/view/animation/Animation;)V

    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ad:Landroid/view/View;

    invoke-virtual {p2, p1}, Landroid/view/View;->setVisibility(I)V

    goto :goto_0

    :cond_1
    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ad:Landroid/view/View;

    invoke-virtual {p2}, Landroid/view/View;->getVisibility()I

    move-result p2

    if-nez p2, :cond_2

    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ad:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->T:Landroid/view/animation/Animation;

    invoke-virtual {p2, v0}, Landroid/view/View;->startAnimation(Landroid/view/animation/Animation;)V

    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ad:Landroid/view/View;

    invoke-virtual {p2, v1}, Landroid/view/View;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_2
    :goto_0
    :try_start_1
    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->p:Landroid/widget/ListView;

    invoke-virtual {p2, p1}, Landroid/widget/ListView;->getChildAt(I)Landroid/view/View;

    move-result-object p2

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    if-nez p2, :cond_3

    const/4 p2, 0x0

    goto :goto_1

    :cond_3
    invoke-virtual {p2}, Landroid/view/View;->getTop()I

    move-result p2

    :goto_1
    iput p2, v0, Lchat/ola/vn/message/f;->E:I

    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    iget p2, p2, Lchat/ola/vn/message/f;->D:I

    const/4 v0, 0x2

    const/4 v1, 0x1

    if-ltz p2, :cond_4

    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->p:Landroid/widget/ListView;

    invoke-virtual {p2, v1}, Landroid/widget/ListView;->setTranscriptMode(I)V

    goto :goto_2

    :cond_4
    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->p:Landroid/widget/ListView;

    invoke-virtual {p2, v0}, Landroid/widget/ListView;->setTranscriptMode(I)V

    :goto_2
    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->p:Landroid/widget/ListView;

    invoke-virtual {p2}, Landroid/widget/ListView;->getFirstVisiblePosition()I

    move-result p2

    const/4 v2, 0x6

    if-gt p2, v2, :cond_7

    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    iget-boolean p2, p2, Lchat/ola/vn/message/f;->Q:Z

    if-eqz p2, :cond_7

    invoke-static {}, Lchat/ola/vn/h;->g()Z

    move-result p2

    if-eqz p2, :cond_7

    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {p2}, Lchat/ola/vn/message/f;->T()Ljava/lang/String;

    move-result-object p2

    iget-object v2, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v2}, Lchat/ola/vn/message/f;->k()S

    move-result v2

    if-ne v2, v0, :cond_6

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->X()Z

    move-result v0

    if-nez v0, :cond_6

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    iget-object v0, v0, Lchat/ola/vn/message/f;->O:Ljava/lang/String;

    invoke-static {p2, v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_7

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v2, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v2}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v2

    new-instance v3, Lchat/ola/vn/activity/OlaChatViewActivity$16;

    invoke-direct {v3, p0}, Lchat/ola/vn/activity/OlaChatViewActivity$16;-><init>(Lchat/ola/vn/activity/OlaChatViewActivity;)V

    invoke-static {v3}, Lchat/ola/vn/entry/c/f;->a(Lchat/ola/vn/entry/c/e;)S

    move-result v3

    invoke-virtual {v0, v2, p2, v3}, Lchat/ola/vn/network/OlaNetworkService;->h(Ljava/lang/String;Ljava/lang/String;S)Z

    move-result v0

    if-eqz v0, :cond_5

    invoke-direct {p0, v1}, Lchat/ola/vn/activity/OlaChatViewActivity;->e(Z)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    iput-object p2, p1, Lchat/ola/vn/message/f;->O:Ljava/lang/String;

    :goto_3
    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    iput-boolean v1, p1, Lchat/ola/vn/message/f;->Q:Z

    return-void

    :cond_5
    invoke-direct {p0, p1}, Lchat/ola/vn/activity/OlaChatViewActivity;->e(Z)V

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaChatViewActivity;->S()V

    return-void

    :cond_6
    const-string v0, "null"

    invoke-static {p2, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_7

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    iget-object v0, v0, Lchat/ola/vn/message/f;->O:Ljava/lang/String;

    invoke-static {p2, v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_7

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v2, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v2}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v2

    new-instance v3, Lchat/ola/vn/activity/OlaChatViewActivity$17;

    invoke-direct {v3, p0}, Lchat/ola/vn/activity/OlaChatViewActivity$17;-><init>(Lchat/ola/vn/activity/OlaChatViewActivity;)V

    invoke-static {v3}, Lchat/ola/vn/entry/c/f;->a(Lchat/ola/vn/entry/c/e;)S

    move-result v3

    invoke-virtual {v0, v2, p2, v3}, Lchat/ola/vn/network/OlaNetworkService;->i(Ljava/lang/String;Ljava/lang/String;S)Z

    move-result v0

    if-eqz v0, :cond_5

    invoke-direct {p0, v1}, Lchat/ola/vn/activity/OlaChatViewActivity;->e(Z)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    iput-object p2, p1, Lchat/ola/vn/message/f;->O:Ljava/lang/String;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_3

    :catch_1
    :cond_7
    return-void
.end method

.method public onTextChanged(Ljava/lang/CharSequence;III)V
    .locals 2

    if-lez p4, :cond_1

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    if-eqz p1, :cond_1

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz p1, :cond_1

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide p1

    iget-wide p3, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->H:J

    sub-long v0, p1, p3

    const-wide/16 p1, 0x5dc

    cmp-long p3, v0, p1

    if-ltz p3, :cond_1

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide p1

    iput-wide p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->H:J

    iget-object p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->k()S

    move-result p1

    const/4 p2, 0x2

    if-ne p1, p2, :cond_0

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {p2}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Lchat/ola/vn/network/OlaNetworkService;->f(Ljava/lang/String;)V

    return-void

    :cond_0
    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {p2}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Lchat/ola/vn/network/OlaNetworkService;->g(Ljava/lang/String;)V

    :cond_1
    return-void
.end method

.method public onTouch(Landroid/view/View;Landroid/view/MotionEvent;)Z
    .locals 2
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "ClickableViewAccessibility"
        }
    .end annotation

    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const v0, 0x7f090313

    const/4 v1, 0x0

    if-eq p1, v0, :cond_2

    const v0, 0x7f0903a1

    if-eq p1, v0, :cond_1

    const p2, 0x7f090564

    if-eq p1, p2, :cond_0

    return v1

    :cond_0
    const/4 p1, 0x1

    invoke-direct {p0, p1}, Lchat/ola/vn/activity/OlaChatViewActivity;->h(Z)V

    return v1

    :cond_1
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getAction()I

    move-result p1

    if-nez p1, :cond_4

    iget p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ae:I

    if-nez p1, :cond_3

    goto :goto_0

    :cond_2
    invoke-virtual {p2}, Landroid/view/MotionEvent;->getAction()I

    move-result p1

    if-nez p1, :cond_4

    iget p1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ae:I

    if-nez p1, :cond_3

    :goto_0
    invoke-direct {p0, v1}, Lchat/ola/vn/activity/OlaChatViewActivity;->f(Z)V

    return v1

    :cond_3
    iput v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ae:I

    invoke-direct {p0, v1}, Lchat/ola/vn/activity/OlaChatViewActivity;->j(Z)V

    :cond_4
    return v1
.end method

.method protected v()Landroid/app/Dialog;
    .locals 7

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iget-object v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->k()S

    move-result v1

    const/4 v2, 0x4

    if-eq v1, v2, :cond_3

    const v2, 0x7f0f061f

    const v3, 0x7f0f0457

    const v4, 0x7f0f05e4

    const v5, 0x7f0f04ad

    packed-switch v1, :pswitch_data_0

    goto/16 :goto_2

    :pswitch_0
    const v1, 0x7f0f0529

    invoke-virtual {p0, v1}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v1, 0x7f0f05ce

    invoke-virtual {p0, v1}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-virtual {p0, v4}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-virtual {p0, v5}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-boolean v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ab:Z

    if-eqz v1, :cond_0

    :goto_0
    invoke-virtual {p0, v3}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    goto :goto_1

    :cond_0
    invoke-virtual {p0, v2}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    goto :goto_1

    :pswitch_1
    invoke-virtual {p0, v5}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    :goto_1
    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_2

    :pswitch_2
    sget-object v1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-object v6, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->C:Lchat/ola/vn/message/f;

    invoke-virtual {v6}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v1, v6}, Lchat/ola/vn/message/g;->c(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_1

    const v6, 0x7f0f0550

    invoke-virtual {p0, v6}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object v6

    invoke-interface {v0, v6}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_1
    invoke-virtual {p0, v4}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object v4

    invoke-interface {v0, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-virtual {p0, v5}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object v4

    invoke-interface {v0, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v4, 0x7f0f0492

    invoke-virtual {p0, v4}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object v4

    invoke-interface {v0, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    if-eqz v1, :cond_2

    const v1, 0x7f0f043a

    invoke-virtual {p0, v1}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_2
    iget-boolean v1, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->ab:Z

    if-eqz v1, :cond_0

    goto :goto_0

    :cond_3
    const v1, 0x7f0f05cc

    invoke-virtual {p0, v1}, Lchat/ola/vn/activity/OlaChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    goto :goto_1

    :goto_2
    new-instance v1, Lchat/ola/vn/i/m;

    invoke-direct {v1, p0}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    invoke-virtual {v1, v0}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance v2, Lchat/ola/vn/activity/OlaChatViewActivity$19;

    invoke-direct {v2, p0, v0}, Lchat/ola/vn/activity/OlaChatViewActivity$19;-><init>(Lchat/ola/vn/activity/OlaChatViewActivity;Ljava/util/List;)V

    invoke-virtual {v1, v2}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {v1}, Lchat/ola/vn/i/m;->show()V

    return-object v1

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public z()Landroid/widget/FrameLayout;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;->t:Landroid/widget/FrameLayout;

    return-object v0
.end method
