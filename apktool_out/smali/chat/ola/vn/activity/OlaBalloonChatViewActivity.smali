.class public Lchat/ola/vn/activity/OlaBalloonChatViewActivity;
.super Lchat/ola/vn/c;

# interfaces
.implements Landroid/text/TextWatcher;
.implements Landroid/view/View$OnClickListener;
.implements Landroid/view/View$OnLongClickListener;
.implements Landroid/view/View$OnTouchListener;
.implements Landroid/widget/AbsListView$OnScrollListener;
.implements Landroid/widget/AdapterView$OnItemClickListener;
.implements Landroid/widget/AdapterView$OnItemLongClickListener;
.implements Lchat/ola/vn/contactpicker/OlaContactPickerActivity$b;
.implements Lchat/ola/vn/p/f;
.implements Lchat/ola/vn/view/e$a;
.implements Lchat/ola/vn/view/f$a;
.implements Lchat/ola/vn/view/g$e;
.implements Lchat/ola/vn/view/h$b;
.implements Lchat/ola/vn/view/i$e;
.implements Lchat/ola/vn/view/j$a;
.implements Lcom/mg/ola/common/widget/a/a;


# static fields
.field private static N:Landroid/view/animation/Animation; = null

.field private static O:Landroid/view/animation/Animation; = null

.field public static f:Landroid/graphics/Bitmap; = null

.field public static g:Landroid/graphics/Bitmap; = null

.field private static i:I = -0x1

.field private static j:I = -0x1


# instance fields
.field private A:Lchat/ola/vn/view/OlaCachedImageView;

.field private B:Landroid/widget/TextView;

.field private C:Landroid/view/View;

.field private D:Lchat/ola/vn/view/OlaCachedImageView;

.field private E:Landroid/widget/TextView;

.field private F:Lchat/ola/vn/message/f;

.field private G:Lchat/ola/vn/b/o;

.field private H:Lchat/ola/vn/b/r;

.field private I:J

.field private J:Ljava/lang/String;

.field private K:Landroid/view/View;

.field private L:Lcom/mg/ola/a/a/b/c;

.field private M:I

.field private P:Z

.field private Q:Landroid/widget/Button;

.field private R:Landroid/widget/ImageButton;

.field private S:Landroid/widget/FrameLayout;

.field private T:Lchat/ola/vn/view/h;

.field private U:Lchat/ola/vn/view/i;

.field private V:Lchat/ola/vn/view/d;

.field private W:Lchat/ola/vn/view/g;

.field private X:Lchat/ola/vn/view/j;

.field private Y:Lchat/ola/vn/view/f;

.field private Z:Lchat/ola/vn/view/d;

.field private aa:Landroid/widget/ImageButton;

.field private ab:Landroid/widget/ImageButton;

.field private ac:Landroid/widget/ImageButton;

.field private ad:Landroid/widget/ImageButton;

.field private ae:Landroid/widget/ImageButton;

.field private af:Landroid/widget/ImageButton;

.field private ag:Landroid/widget/ImageButton;

.field private ah:Landroid/view/View;

.field private ai:I

.field private aj:I

.field private ak:Lchat/ola/vn/i/c;

.field private al:Z

.field private am:Ljava/io/File;

.field protected e:Z

.field protected h:Landroid/widget/FrameLayout;

.field private k:Lcom/mg/ola/common/widget/SoftKeyLinearLayout;

.field private l:Landroid/widget/ListView;

.field private m:Landroid/widget/EditText;

.field private n:Landroid/widget/TextView;

.field private o:Landroid/widget/TextView;

.field private p:Landroid/view/View;

.field private q:Landroid/view/View;

.field private r:Landroid/view/View;

.field private s:Lchat/ola/vn/view/OlaCachedImageView;

.field private t:Landroid/view/View;

.field private u:Lchat/ola/vn/view/OlaCachedImageView;

.field private v:Landroid/widget/TextView;

.field private w:Landroid/view/View;

.field private x:Lchat/ola/vn/view/OlaCachedImageView;

.field private y:Landroid/widget/TextView;

.field private z:Landroid/view/View;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 2

    invoke-direct {p0}, Lchat/ola/vn/c;-><init>()V

    const/4 v0, 0x1

    iput-boolean v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->e:Z

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->I:J

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->J:Ljava/lang/String;

    const/16 v1, 0x96

    iput v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->M:I

    const/4 v1, 0x0

    iput-boolean v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->P:Z

    iput-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->T:Lchat/ola/vn/view/h;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->U:Lchat/ola/vn/view/i;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->V:Lchat/ola/vn/view/d;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->W:Lchat/ola/vn/view/g;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->X:Lchat/ola/vn/view/j;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->Y:Lchat/ola/vn/view/f;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->Z:Lchat/ola/vn/view/d;

    iput v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->ai:I

    iput v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->aj:I

    iput-boolean v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->al:Z

    return-void
.end method

.method public static E()Z
    .locals 2

    :try_start_0
    sget-object v0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->b_:Lchat/ola/vn/c;

    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    const-class v1, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    invoke-virtual {v1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    return v0

    :catch_0
    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method public static F()V
    .locals 1

    :try_start_0
    invoke-static {}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->E()Z

    move-result v0

    if-eqz v0, :cond_0

    sget-object v0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->b_:Lchat/ola/vn/c;

    invoke-virtual {v0}, Lchat/ola/vn/c;->finish()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method private R()V
    .locals 6

    const v0, 0x7f0b0027

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->setContentView(I)V

    const v0, 0x7f090152

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/FrameLayout;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->h:Landroid/widget/FrameLayout;

    const v0, 0x7f09048c

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lcom/mg/ola/common/widget/SoftKeyLinearLayout;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->k:Lcom/mg/ola/common/widget/SoftKeyLinearLayout;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->k:Lcom/mg/ola/common/widget/SoftKeyLinearLayout;

    invoke-virtual {v0, p0}, Lcom/mg/ola/common/widget/SoftKeyLinearLayout;->setOnSoftKeyboardListener(Lcom/mg/ola/common/widget/a/a;)V

    const v0, 0x7f090089

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->K:Landroid/view/View;

    const v0, 0x7f0904e9

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->n:Landroid/widget/TextView;

    const v0, 0x7f0904e8

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->o:Landroid/widget/TextView;

    const v0, 0x7f0902da

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f090313

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ListView;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->l:Landroid/widget/ListView;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->l:Landroid/widget/ListView;

    invoke-virtual {v0, p0}, Landroid/widget/ListView;->setOnItemClickListener(Landroid/widget/AdapterView$OnItemClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->l:Landroid/widget/ListView;

    const/4 v1, 0x2

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->setTranscriptMode(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->l:Landroid/widget/ListView;

    new-instance v2, Landroid/graphics/drawable/ColorDrawable;

    const/4 v3, 0x0

    invoke-direct {v2, v3}, Landroid/graphics/drawable/ColorDrawable;-><init>(I)V

    invoke-virtual {v0, v2}, Landroid/widget/ListView;->setSelector(Landroid/graphics/drawable/Drawable;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->l:Landroid/widget/ListView;

    invoke-virtual {v0, p0}, Landroid/widget/ListView;->setOnItemLongClickListener(Landroid/widget/AdapterView$OnItemLongClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->l:Landroid/widget/ListView;

    invoke-virtual {v0, p0}, Landroid/widget/ListView;->setOnScrollListener(Landroid/widget/AbsListView$OnScrollListener;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->l:Landroid/widget/ListView;

    invoke-virtual {v0, p0}, Landroid/widget/ListView;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->l:Landroid/widget/ListView;

    sget v2, Lchat/ola/vn/f;->g:I

    invoke-virtual {v0, v2}, Landroid/widget/ListView;->setBackgroundColor(I)V

    const v0, 0x7f09059d

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    const/16 v2, 0x8

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    new-instance v0, Landroid/view/View;

    invoke-direct {v0, p0}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    new-instance v2, Landroid/widget/AbsListView$LayoutParams;

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v4

    const v5, 0x7f0700ec

    invoke-virtual {v4, v5}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v4

    invoke-direct {v2, v1, v4}, Landroid/widget/AbsListView$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v2}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->l:Landroid/widget/ListView;

    invoke-virtual {v1, v0}, Landroid/widget/ListView;->addFooterView(Landroid/view/View;)V

    const v0, 0x7f090157

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->m:Landroid/widget/EditText;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->m:Landroid/widget/EditText;

    invoke-virtual {v0, p0}, Landroid/widget/EditText;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->m:Landroid/widget/EditText;

    new-instance v1, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$12;

    invoke-direct {v1, p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$12;-><init>(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;)V

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setOnEditorActionListener(Landroid/widget/TextView$OnEditorActionListener;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->m:Landroid/widget/EditText;

    new-instance v1, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$22;

    invoke-direct {v1, p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$22;-><init>(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;)V

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setOnKeyListener(Landroid/view/View$OnKeyListener;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->m:Landroid/widget/EditText;

    invoke-virtual {v0, p0}, Landroid/widget/EditText;->addTextChangedListener(Landroid/text/TextWatcher;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->m:Landroid/widget/EditText;

    invoke-virtual {v0, p0}, Landroid/widget/EditText;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V

    const v0, 0x7f090466

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->Q:Landroid/widget/Button;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->Q:Landroid/widget/Button;

    const v1, 0x7f0f0612

    invoke-virtual {p0, v1}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    sget-object v2, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v1, v2}, Ljava/lang/String;->toUpperCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->Q:Landroid/widget/Button;

    invoke-virtual {v0, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f0902d3

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageButton;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->R:Landroid/widget/ImageButton;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->R:Landroid/widget/ImageButton;

    invoke-virtual {v0, p0}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->R:Landroid/widget/ImageButton;

    invoke-virtual {v0, p0}, Landroid/widget/ImageButton;->setOnLongClickListener(Landroid/view/View$OnLongClickListener;)V

    const v0, 0x7f090086

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->q:Landroid/view/View;

    const v0, 0x7f0901c8

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->r:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->r:Landroid/view/View;

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->r:Landroid/view/View;

    const v1, 0x7f09015e

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->s:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const v2, 0x7f08006f

    invoke-static {v0, v2}, Landroid/graphics/BitmapFactory;->decodeResource(Landroid/content/res/Resources;I)Landroid/graphics/Bitmap;

    move-result-object v0

    const/4 v2, 0x1

    invoke-static {p0, v0, v3, v2}, Lchat/ola/vn/balloon/b;->a(Landroid/content/Context;Landroid/graphics/Bitmap;ZZ)Landroid/graphics/Bitmap;

    move-result-object v0

    iget-object v2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->s:Lchat/ola/vn/view/OlaCachedImageView;

    const/4 v3, 0x0

    invoke-virtual {v2, v0, v3}, Lchat/ola/vn/view/OlaCachedImageView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    const v0, 0x7f0901c3

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->t:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->t:Landroid/view/View;

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->t:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->u:Lchat/ola/vn/view/OlaCachedImageView;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->t:Landroid/view/View;

    const v2, 0x7f090501

    invoke-virtual {v0, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->v:Landroid/widget/TextView;

    const v0, 0x7f0901c4

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->w:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->w:Landroid/view/View;

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->w:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->x:Lchat/ola/vn/view/OlaCachedImageView;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->w:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->y:Landroid/widget/TextView;

    const v0, 0x7f0901c5

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->z:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->z:Landroid/view/View;

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->z:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->A:Lchat/ola/vn/view/OlaCachedImageView;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->z:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->B:Landroid/widget/TextView;

    const v0, 0x7f0901c6

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->C:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->C:Landroid/view/View;

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->C:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->D:Lchat/ola/vn/view/OlaCachedImageView;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->C:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->E:Landroid/widget/TextView;

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->S()V

    return-void
.end method

.method private S()V
    .locals 3

    const v0, 0x7f090155

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->p:Landroid/view/View;

    const v0, 0x7f09015b

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->ah:Landroid/view/View;

    const v0, 0x7f09014e

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/FrameLayout;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->S:Landroid/widget/FrameLayout;

    const v0, 0x7f0903fb

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageButton;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->aa:Landroid/widget/ImageButton;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->aa:Landroid/widget/ImageButton;

    invoke-virtual {v0, p0}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    sget-boolean v0, Lchat/ola/vn/c/x;->y:Z

    const/16 v1, 0x8

    const/4 v2, 0x0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->aa:Landroid/widget/ImageButton;

    invoke-virtual {v0, v2}, Landroid/widget/ImageButton;->setVisibility(I)V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->aa:Landroid/widget/ImageButton;

    invoke-virtual {v0, v1}, Landroid/widget/ImageButton;->setVisibility(I)V

    :goto_0
    const v0, 0x7f09015c

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageButton;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->ab:Landroid/widget/ImageButton;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->ab:Landroid/widget/ImageButton;

    invoke-virtual {v0, p0}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f090143

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageButton;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->ac:Landroid/widget/ImageButton;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->ac:Landroid/widget/ImageButton;

    invoke-virtual {v0, p0}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->ac:Landroid/widget/ImageButton;

    invoke-virtual {v0, p0}, Landroid/widget/ImageButton;->setOnLongClickListener(Landroid/view/View$OnLongClickListener;)V

    invoke-static {}, Lcom/mg/ola/common/d/g;->f()Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->ac:Landroid/widget/ImageButton;

    invoke-virtual {v0, v2}, Landroid/widget/ImageButton;->setVisibility(I)V

    goto :goto_1

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->ac:Landroid/widget/ImageButton;

    invoke-virtual {v0, v1}, Landroid/widget/ImageButton;->setVisibility(I)V

    :goto_1
    const v0, 0x7f0902c8

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageButton;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->ad:Landroid/widget/ImageButton;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->ad:Landroid/widget/ImageButton;

    invoke-virtual {v0, p0}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f090310

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageButton;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->ae:Landroid/widget/ImageButton;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->ae:Landroid/widget/ImageButton;

    invoke-virtual {v0, p0}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f090600

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageButton;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->af:Landroid/widget/ImageButton;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->af:Landroid/widget/ImageButton;

    invoke-virtual {v0, p0}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f090360

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageButton;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->ag:Landroid/widget/ImageButton;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->ag:Landroid/widget/ImageButton;

    invoke-virtual {v0, p0}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    return-void
.end method

.method private T()I
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->r:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->isSelected()Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x0

    return v0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->t:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->isSelected()Z

    move-result v0

    if-eqz v0, :cond_1

    const/4 v0, 0x1

    return v0

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->w:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->isSelected()Z

    move-result v0

    if-eqz v0, :cond_2

    const/4 v0, 0x2

    return v0

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->z:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->isSelected()Z

    move-result v0

    if-eqz v0, :cond_3

    const/4 v0, 0x3

    return v0

    :cond_3
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->C:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->isSelected()Z

    move-result v0

    if-eqz v0, :cond_4

    const/4 v0, 0x4

    return v0

    :cond_4
    const/4 v0, -0x1

    return v0
.end method

.method private U()V
    .locals 4

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    if-eqz v0, :cond_1

    const-string v1, "_conv_id"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    const-string v2, "_conv_type"

    const/4 v3, 0x0

    invoke-virtual {v0, v2, v3}, Landroid/content/Intent;->getShortExtra(Ljava/lang/String;S)S

    move-result v0

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_0

    sget-object v2, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    const/4 v3, 0x1

    invoke-virtual {v2, v1, v0, v3}, Lchat/ola/vn/message/g;->b(Ljava/lang/String;SZ)Lchat/ola/vn/message/f;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    sget-object v0, Lchat/ola/vn/OlaApplication;->c:Lchat/ola/vn/balloon/OlaBalloonService;

    invoke-virtual {v0}, Lchat/ola/vn/balloon/OlaBalloonService;->f()Ljava/util/List;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->a(Lchat/ola/vn/message/f;)V

    return-void

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->finish()V

    :cond_1
    return-void
.end method

.method private V()Z
    .locals 5

    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    iget v1, v1, Lchat/ola/vn/message/f;->D:I

    if-ltz v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->l:Landroid/widget/ListView;

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Landroid/widget/ListView;->setTranscriptMode(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->l:Landroid/widget/ListView;

    iget-object v3, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    iget v3, v3, Lchat/ola/vn/message/f;->D:I

    iget-object v4, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    iget v4, v4, Lchat/ola/vn/message/f;->E:I

    invoke-virtual {v1, v3, v4}, Landroid/widget/ListView;->setSelectionFromTop(II)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    return v2

    :catch_0
    :try_start_2
    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->l:Landroid/widget/ListView;

    iget-object v3, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    iget v3, v3, Lchat/ola/vn/message/f;->D:I

    invoke-virtual {v1, v3}, Landroid/widget/ListView;->setSelection(I)V

    return v2

    :cond_0
    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->d(Z)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    return v0
.end method

.method private W()Landroid/view/View;
    .locals 1

    const/4 v0, 0x0

    return-object v0
.end method

.method private X()V
    .locals 11

    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->K:Landroid/view/View;

    invoke-virtual {v1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->L:Lcom/mg/ola/a/a/b/c;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->L:Lcom/mg/ola/a/a/b/c;

    invoke-virtual {v1}, Lcom/mg/ola/a/a/b/c;->b()V

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const v2, 0x7f0700f8

    invoke-virtual {v1, v2}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v1

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->W()Landroid/view/View;

    move-result-object v2

    new-instance v3, Landroid/graphics/Rect;

    invoke-direct {v3, v0, v0, v0, v0}, Landroid/graphics/Rect;-><init>(IIII)V

    if-eqz v2, :cond_1

    invoke-virtual {v2, v3}, Landroid/view/View;->getGlobalVisibleRect(Landroid/graphics/Rect;)Z

    :cond_1
    new-instance v2, Landroid/graphics/Rect;

    sget v4, Lchat/ola/vn/e;->c:I

    sget v5, Lchat/ola/vn/e;->d:I

    invoke-direct {v2, v0, v1, v4, v5}, Landroid/graphics/Rect;-><init>(IIII)V

    invoke-static {p0}, Lchat/ola/vn/util/n;->a(Landroid/content/Context;)I

    move-result v1

    neg-int v1, v1

    invoke-virtual {v3, v0, v1}, Landroid/graphics/Rect;->offset(II)V

    invoke-virtual {v2, v0, v1}, Landroid/graphics/Rect;->offset(II)V

    invoke-virtual {v3}, Landroid/graphics/Rect;->width()I

    move-result v1

    int-to-float v1, v1

    invoke-virtual {v2}, Landroid/graphics/Rect;->width()I

    move-result v4

    int-to-float v4, v4

    div-float/2addr v1, v4

    iget-object v4, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->K:Landroid/view/View;

    const/4 v5, 0x0

    invoke-static {v4, v5}, Lcom/mg/ola/a/a/c/b;->b(Landroid/view/View;F)V

    iget-object v4, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->K:Landroid/view/View;

    invoke-static {v4, v5}, Lcom/mg/ola/a/a/c/b;->c(Landroid/view/View;F)V

    new-instance v4, Lcom/mg/ola/a/a/b/c;

    invoke-direct {v4}, Lcom/mg/ola/a/a/b/c;-><init>()V

    iget-object v5, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->K:Landroid/view/View;

    const-string v6, "translationX"

    const/4 v7, 0x2

    new-array v8, v7, [F

    iget v3, v3, Landroid/graphics/Rect;->left:I

    int-to-float v3, v3

    aput v3, v8, v0

    iget v2, v2, Landroid/graphics/Rect;->left:I

    int-to-float v2, v2

    const/4 v3, 0x1

    aput v2, v8, v3

    invoke-static {v5, v6, v8}, Lcom/mg/ola/a/a/b/j;->a(Ljava/lang/Object;Ljava/lang/String;[F)Lcom/mg/ola/a/a/b/j;

    move-result-object v2

    iget-object v5, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->K:Landroid/view/View;

    const-string v6, "scaleX"

    new-array v8, v7, [F

    aput v1, v8, v0

    const/high16 v9, 0x3f800000    # 1.0f

    aput v9, v8, v3

    invoke-static {v5, v6, v8}, Lcom/mg/ola/a/a/b/j;->a(Ljava/lang/Object;Ljava/lang/String;[F)Lcom/mg/ola/a/a/b/j;

    move-result-object v5

    iget-object v6, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->K:Landroid/view/View;

    const-string v8, "scaleY"

    new-array v10, v7, [F

    aput v1, v10, v0

    aput v9, v10, v3

    invoke-static {v6, v8, v10}, Lcom/mg/ola/a/a/b/j;->a(Ljava/lang/Object;Ljava/lang/String;[F)Lcom/mg/ola/a/a/b/j;

    move-result-object v1

    iget-object v3, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->K:Landroid/view/View;

    const-string v6, "alpha"

    new-array v8, v7, [F

    fill-array-data v8, :array_0

    invoke-static {v3, v6, v8}, Lcom/mg/ola/a/a/b/j;->a(Ljava/lang/Object;Ljava/lang/String;[F)Lcom/mg/ola/a/a/b/j;

    move-result-object v3

    iget-object v6, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->q:Landroid/view/View;

    const-string v8, "alpha"

    new-array v7, v7, [F

    fill-array-data v7, :array_1

    invoke-static {v6, v8, v7}, Lcom/mg/ola/a/a/b/j;->a(Ljava/lang/Object;Ljava/lang/String;[F)Lcom/mg/ola/a/a/b/j;

    move-result-object v6

    invoke-virtual {v4, v5}, Lcom/mg/ola/a/a/b/c;->a(Lcom/mg/ola/a/a/b/a;)Lcom/mg/ola/a/a/b/c$b;

    move-result-object v5

    invoke-virtual {v5, v1}, Lcom/mg/ola/a/a/b/c$b;->a(Lcom/mg/ola/a/a/b/a;)Lcom/mg/ola/a/a/b/c$b;

    move-result-object v1

    invoke-virtual {v1, v2}, Lcom/mg/ola/a/a/b/c$b;->a(Lcom/mg/ola/a/a/b/a;)Lcom/mg/ola/a/a/b/c$b;

    move-result-object v1

    invoke-virtual {v1, v3}, Lcom/mg/ola/a/a/b/c$b;->a(Lcom/mg/ola/a/a/b/a;)Lcom/mg/ola/a/a/b/c$b;

    move-result-object v1

    invoke-virtual {v1, v6}, Lcom/mg/ola/a/a/b/c$b;->a(Lcom/mg/ola/a/a/b/a;)Lcom/mg/ola/a/a/b/c$b;

    iget v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->M:I

    int-to-long v1, v1

    invoke-virtual {v4, v1, v2}, Lcom/mg/ola/a/a/b/c;->b(J)Lcom/mg/ola/a/a/b/c;

    new-instance v1, Landroid/view/animation/DecelerateInterpolator;

    invoke-direct {v1}, Landroid/view/animation/DecelerateInterpolator;-><init>()V

    invoke-virtual {v4, v1}, Lcom/mg/ola/a/a/b/c;->a(Landroid/view/animation/Interpolator;)V

    new-instance v1, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$26;

    invoke-direct {v1, p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$26;-><init>(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;)V

    invoke-virtual {v4, v1}, Lcom/mg/ola/a/a/b/c;->a(Lcom/mg/ola/a/a/b/a$a;)V

    invoke-virtual {v4}, Lcom/mg/ola/a/a/b/c;->a()V

    iput-object v4, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->L:Lcom/mg/ola/a/a/b/c;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    const/4 v1, 0x0

    :try_start_1
    iput-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->L:Lcom/mg/ola/a/a/b/c;

    iget-boolean v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->e:Z

    if-eqz v1, :cond_2

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->U()V

    iput-boolean v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->e:Z
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    :cond_2
    return-void

    nop

    :array_0
    .array-data 4
        0x0
        0x3f800000    # 1.0f
    .end array-data

    :array_1
    .array-data 4
        0x3e99999a    # 0.3f
        0x3f800000    # 1.0f
    .end array-data
.end method

.method private Y()V
    .locals 1

    invoke-super {p0}, Lchat/ola/vn/c;->finish()V

    sget-object v0, Lchat/ola/vn/OlaApplication;->c:Lchat/ola/vn/balloon/OlaBalloonService;

    if-eqz v0, :cond_0

    sget-object v0, Lchat/ola/vn/OlaApplication;->c:Lchat/ola/vn/balloon/OlaBalloonService;

    invoke-virtual {v0}, Lchat/ola/vn/balloon/OlaBalloonService;->c()V

    :cond_0
    return-void
.end method

.method private Z()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->aa()V

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->ab()V

    return-void
.end method

.method public static a(Landroid/content/Context;)Landroid/graphics/Bitmap;
    .locals 2

    sget-object v0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->f:Landroid/graphics/Bitmap;

    if-nez v0, :cond_0

    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const v1, 0x7f080692

    invoke-static {v0, v1}, Landroid/graphics/BitmapFactory;->decodeResource(Landroid/content/res/Resources;I)Landroid/graphics/Bitmap;

    move-result-object v0

    sput-object v0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->f:Landroid/graphics/Bitmap;

    sget-object v0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->f:Landroid/graphics/Bitmap;

    const/4 v1, 0x0

    invoke-static {p0, v0, v1, v1}, Lchat/ola/vn/balloon/b;->a(Landroid/content/Context;Landroid/graphics/Bitmap;ZZ)Landroid/graphics/Bitmap;

    move-result-object p0

    sput-object p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->f:Landroid/graphics/Bitmap;

    :cond_0
    sget-object p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->f:Landroid/graphics/Bitmap;

    return-object p0
.end method

.method static synthetic a(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;)Landroid/widget/EditText;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->m:Landroid/widget/EditText;

    return-object p0
.end method

.method static synthetic a(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;Lcom/mg/ola/a/a/b/c;)Lcom/mg/ola/a/a/b/c;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->L:Lcom/mg/ola/a/a/b/c;

    return-object p1
.end method

.method public static a(Landroid/content/Context;Ljava/lang/String;S)V
    .locals 2

    :try_start_0
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const/high16 v1, 0x18010000

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setFlags(I)Landroid/content/Intent;

    const-string v1, "_conv_id"

    invoke-virtual {v0, v1, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string p1, "_conv_type"

    invoke-virtual {v0, p1, p2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;S)Landroid/content/Intent;

    invoke-virtual {p0, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic a(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;Lchat/ola/vn/message/d;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->b(Lchat/ola/vn/message/d;)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;Lchat/ola/vn/message/f;Ljava/lang/String;ILjava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1, p2, p3, p4}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->a(Lchat/ola/vn/message/f;Ljava/lang/String;ILjava/lang/String;)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;Ljava/lang/String;IZ)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->a(Ljava/lang/String;IZ)V

    return-void
.end method

.method private a(Lchat/ola/vn/message/f;Ljava/lang/String;ILjava/lang/String;)V
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
    invoke-direct {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->ac()Lchat/ola/vn/message/d;

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

.method private a(Ljava/lang/CharSequence;)V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->m:Landroid/widget/EditText;

    invoke-virtual {v0, p0}, Landroid/widget/EditText;->removeTextChangedListener(Landroid/text/TextWatcher;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->m:Landroid/widget/EditText;

    invoke-virtual {v0, p1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->m:Landroid/widget/EditText;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->m:Landroid/widget/EditText;

    invoke-virtual {v1}, Landroid/widget/EditText;->length()I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setSelection(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->m:Landroid/widget/EditText;

    invoke-virtual {v0, p0}, Landroid/widget/EditText;->addTextChangedListener(Landroid/text/TextWatcher;)V

    invoke-direct {p0, p1}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->b(Ljava/lang/CharSequence;)V

    return-void
.end method

.method private a(Ljava/lang/String;IZ)V
    .locals 9

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    if-eqz p2, :cond_4

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    if-nez v0, :cond_1

    return-void

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lchat/ola/vn/message/f;->d(Z)V

    sget-object v0, Lchat/ola/vn/f/c;->b:Ljava/lang/String;

    invoke-static {p1, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    sget-object p1, Lchat/ola/vn/f/c;->a:Ljava/lang/String;

    :cond_2
    move-object v6, p1

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->ac()Lchat/ola/vn/message/d;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    const/4 v2, 0x0

    iput-boolean v2, v0, Lchat/ola/vn/message/f;->B:Z

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    iput-wide v2, v0, Lchat/ola/vn/message/f;->H:J

    invoke-virtual {p1, v6}, Lchat/ola/vn/message/d;->f(Ljava/lang/String;)V

    int-to-short v0, p2

    invoke-virtual {p1, v0}, Lchat/ola/vn/message/d;->b(S)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v8

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->k()S

    move-result v5

    const/4 v0, 0x2

    invoke-static {p1, v0}, Lchat/ola/vn/message/e;->a(Lchat/ola/vn/message/d;B)Lchat/ola/vn/message/d;

    move-result-object p1

    new-instance v0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$6;

    move-object v2, v0

    move-object v3, p0

    move-object v4, p1

    move v7, p2

    invoke-direct/range {v2 .. v8}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$6;-><init>(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;Lchat/ola/vn/message/d;SLjava/lang/String;ILjava/lang/String;)V

    invoke-interface {v0}, Ljava/lang/Runnable;->run()V

    invoke-virtual {p1, v0}, Lchat/ola/vn/message/d;->a(Ljava/lang/Runnable;)V

    iget-object p2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {p2, p1}, Lchat/ola/vn/message/f;->a(Lchat/ola/vn/message/d;)V

    if-eqz p3, :cond_3

    const-string p1, ""

    invoke-direct {p0, p1}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->a(Ljava/lang/CharSequence;)V

    :cond_3
    invoke-virtual {p0, v1}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->d(Z)V

    :cond_4
    return-void
.end method

.method private aa()V
    .locals 12

    sget-object v0, Lchat/ola/vn/OlaApplication;->c:Lchat/ola/vn/balloon/OlaBalloonService;

    invoke-virtual {v0}, Lchat/ola/vn/balloon/OlaBalloonService;->f()Ljava/util/List;

    move-result-object v0

    const/16 v1, 0x8

    if-eqz v0, :cond_7

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v2

    if-lez v2, :cond_7

    iget-object v2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->t:Landroid/view/View;

    invoke-virtual {v2, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->w:Landroid/view/View;

    invoke-virtual {v2, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->z:Landroid/view/View;

    invoke-virtual {v2, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->C:Landroid/view/View;

    invoke-virtual {v2, v1}, Landroid/view/View;->setVisibility(I)V

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v2

    const/4 v3, 0x0

    const/4 v4, 0x0

    :goto_0
    const/4 v5, 0x4

    if-ge v4, v5, :cond_8

    if-ge v4, v2, :cond_8

    invoke-interface {v0, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lchat/ola/vn/balloon/e;

    const/4 v6, 0x0

    packed-switch v4, :pswitch_data_0

    move-object v7, v6

    goto :goto_1

    :pswitch_0
    iget-object v6, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->C:Landroid/view/View;

    invoke-virtual {v6, v3}, Landroid/view/View;->setVisibility(I)V

    iget-object v6, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->D:Lchat/ola/vn/view/OlaCachedImageView;

    iget-object v7, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->E:Landroid/widget/TextView;

    goto :goto_1

    :pswitch_1
    iget-object v6, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->z:Landroid/view/View;

    invoke-virtual {v6, v3}, Landroid/view/View;->setVisibility(I)V

    iget-object v6, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->A:Lchat/ola/vn/view/OlaCachedImageView;

    iget-object v7, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->B:Landroid/widget/TextView;

    goto :goto_1

    :pswitch_2
    iget-object v6, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->w:Landroid/view/View;

    invoke-virtual {v6, v3}, Landroid/view/View;->setVisibility(I)V

    iget-object v6, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->x:Lchat/ola/vn/view/OlaCachedImageView;

    iget-object v7, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->y:Landroid/widget/TextView;

    goto :goto_1

    :pswitch_3
    iget-object v6, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->t:Landroid/view/View;

    invoke-virtual {v6, v3}, Landroid/view/View;->setVisibility(I)V

    iget-object v6, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->u:Lchat/ola/vn/view/OlaCachedImageView;

    iget-object v7, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->v:Landroid/widget/TextView;

    :goto_1
    if-eqz v6, :cond_2

    invoke-virtual {v5}, Lchat/ola/vn/balloon/e;->getContact()Lchat/ola/vn/message/f;

    move-result-object v8

    invoke-virtual {v8}, Lchat/ola/vn/message/f;->k()S

    move-result v8

    const/4 v9, 0x2

    if-ne v8, v9, :cond_1

    invoke-virtual {v5}, Lchat/ola/vn/balloon/e;->getContact()Lchat/ola/vn/message/f;

    move-result-object v8

    invoke-virtual {v8}, Lchat/ola/vn/message/f;->o()Ljava/lang/String;

    move-result-object v8

    invoke-static {v8}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v9

    if-nez v9, :cond_0

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v9

    invoke-static {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->a(Landroid/content/Context;)Landroid/graphics/Bitmap;

    move-result-object v10

    const/16 v11, 0xc8

    invoke-virtual {v9, v8, v6, v10, v11}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Landroid/graphics/Bitmap;I)V

    goto :goto_2

    :cond_0
    iget-object v8, v5, Lchat/ola/vn/balloon/e;->s:Lchat/ola/vn/message/f;

    invoke-virtual {v8}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v6, v8}, Lchat/ola/vn/view/OlaCachedImageView;->a(Ljava/lang/String;)Z

    move-result v8

    if-nez v8, :cond_2

    invoke-static {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->a(Landroid/content/Context;)Landroid/graphics/Bitmap;

    move-result-object v8

    iget-object v9, v5, Lchat/ola/vn/balloon/e;->s:Lchat/ola/vn/message/f;

    invoke-virtual {v9}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v6, v8, v9}, Lchat/ola/vn/view/OlaCachedImageView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    goto :goto_2

    :cond_1
    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v8

    invoke-virtual {v5}, Lchat/ola/vn/balloon/e;->getContact()Lchat/ola/vn/message/f;

    move-result-object v9

    invoke-virtual {v9}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v9

    invoke-static {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->b(Landroid/content/Context;)Landroid/graphics/Bitmap;

    move-result-object v10

    invoke-virtual {v8, v9, v6, v10}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Landroid/graphics/Bitmap;)V

    :cond_2
    :goto_2
    if-eqz v7, :cond_5

    invoke-virtual {v5}, Lchat/ola/vn/balloon/e;->getContact()Lchat/ola/vn/message/f;

    move-result-object v6

    invoke-virtual {v6}, Lchat/ola/vn/message/f;->z()I

    move-result v6

    if-lez v6, :cond_4

    invoke-virtual {v7, v3}, Landroid/widget/TextView;->setVisibility(I)V

    const/16 v8, 0x9

    if-le v6, v8, :cond_3

    const-string v6, "9+"

    :goto_3
    invoke-virtual {v7, v6}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_4

    :cond_3
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, ""

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v8, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    goto :goto_3

    :cond_4
    invoke-virtual {v7, v1}, Landroid/widget/TextView;->setVisibility(I)V

    :cond_5
    :goto_4
    invoke-virtual {v5}, Lchat/ola/vn/balloon/e;->getContact()Lchat/ola/vn/message/f;

    move-result-object v5

    iget-object v6, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {v5, v6}, Lchat/ola/vn/message/f;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_6

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->T()I

    move-result v5

    if-eqz v5, :cond_6

    iget-object v5, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->r:Landroid/view/View;

    invoke-virtual {v5, v3}, Landroid/view/View;->setSelected(Z)V

    iget-object v5, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->t:Landroid/view/View;

    invoke-virtual {v5, v3}, Landroid/view/View;->setSelected(Z)V

    iget-object v5, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->w:Landroid/view/View;

    invoke-virtual {v5, v3}, Landroid/view/View;->setSelected(Z)V

    iget-object v5, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->z:Landroid/view/View;

    invoke-virtual {v5, v3}, Landroid/view/View;->setSelected(Z)V

    iget-object v5, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->C:Landroid/view/View;

    invoke-virtual {v5, v3}, Landroid/view/View;->setSelected(Z)V

    const/4 v5, 0x1

    packed-switch v4, :pswitch_data_1

    goto :goto_6

    :pswitch_4
    iget-object v6, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->C:Landroid/view/View;

    goto :goto_5

    :pswitch_5
    iget-object v6, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->z:Landroid/view/View;

    goto :goto_5

    :pswitch_6
    iget-object v6, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->w:Landroid/view/View;

    goto :goto_5

    :pswitch_7
    iget-object v6, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->t:Landroid/view/View;

    :goto_5
    invoke-virtual {v6, v5}, Landroid/view/View;->setSelected(Z)V

    :cond_6
    :goto_6
    add-int/lit8 v4, v4, 0x1

    goto/16 :goto_0

    :cond_7
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->t:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->w:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->z:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->C:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    :cond_8
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch

    :pswitch_data_1
    .packed-switch 0x0
        :pswitch_7
        :pswitch_6
        :pswitch_5
        :pswitch_4
    .end packed-switch
.end method

.method private ab()V
    .locals 9

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->o:Landroid/widget/TextView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->k()S

    move-result v0

    const/4 v2, 0x4

    if-eq v0, v2, :cond_9

    packed-switch v0, :pswitch_data_0

    return-void

    :pswitch_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->L()Ljava/lang/CharSequence;

    move-result-object v0

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    iget-object v2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->n:Landroid/widget/TextView;

    invoke-virtual {v2, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->F()Ljava/util/List;

    move-result-object v0

    if-eqz v0, :cond_1

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v2

    if-nez v2, :cond_0

    goto :goto_1

    :cond_0
    iget-object v2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->o:Landroid/widget/TextView;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v0, " "

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v0, 0x7f0f0566

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v0

    sget-object v4, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v0, v4}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->o:Landroid/widget/TextView;

    invoke-virtual {v0}, Landroid/widget/TextView;->getVisibility()I

    move-result v0

    if-eqz v0, :cond_d

    :goto_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->o:Landroid/widget/TextView;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    return-void

    :cond_1
    :goto_1
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->o:Landroid/widget/TextView;

    const v2, 0x7f0f0466

    invoke-static {v2}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->o:Landroid/widget/TextView;

    invoke-virtual {v0}, Landroid/widget/TextView;->getVisibility()I

    move-result v0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->o:Landroid/widget/TextView;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    :cond_2
    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {v2}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2, v1}, Lchat/ola/vn/network/OlaNetworkService;->g(Ljava/lang/String;S)V

    return-void

    :pswitch_1
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->p()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->o:Landroid/widget/TextView;

    const v2, 0x7f0f051e

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setText(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->o:Landroid/widget/TextView;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    goto :goto_2

    :cond_3
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->o:Landroid/widget/TextView;

    const/16 v2, 0x8

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->o:Landroid/widget/TextView;

    const-string v2, ""

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :goto_2
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->L()Ljava/lang/CharSequence;

    move-result-object v0

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    iget-object v2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->n:Landroid/widget/TextView;

    invoke-virtual {v2, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->k()S

    move-result v0

    if-nez v0, :cond_7

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    iget-object v0, v0, Lchat/ola/vn/message/f;->K:Ljava/lang/Long;

    if-eqz v0, :cond_6

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    iget-wide v4, v0, Lchat/ola/vn/message/f;->L:J

    const/4 v0, 0x0

    sub-long v6, v2, v4

    const-wide/32 v2, 0x493e0

    cmp-long v0, v6, v2

    if-ltz v0, :cond_4

    goto/16 :goto_5

    :cond_4
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    iget-object v0, v0, Lchat/ola/vn/message/f;->K:Ljava/lang/Long;

    if-eqz v0, :cond_8

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    iget-object v0, v0, Lchat/ola/vn/message/f;->K:Ljava/lang/Long;

    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide v2

    const-wide/16 v4, 0x0

    cmp-long v0, v2, v4

    if-ltz v0, :cond_8

    const-string v0, ""

    iget-object v2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {v2}, Lchat/ola/vn/message/f;->h()S

    move-result v2

    packed-switch v2, :pswitch_data_1

    goto :goto_4

    :pswitch_2
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, " "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v2, 0x7f0f0590

    invoke-virtual {p0, v2}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object v2

    :goto_3
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_4

    :pswitch_3
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, " "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v2, 0x7f0f058a

    invoke-virtual {p0, v2}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object v2

    goto :goto_3

    :pswitch_4
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, " "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v2, 0x7f0f058b

    invoke-virtual {p0, v2}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object v2

    goto :goto_3

    :pswitch_5
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, " "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v2, 0x7f0f058f

    invoke-virtual {p0, v2}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object v2

    goto :goto_3

    :pswitch_6
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, " "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v2, 0x7f0f058d

    invoke-virtual {p0, v2}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object v2

    goto :goto_3

    :goto_4
    iget-object v2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->o:Landroid/widget/TextView;

    invoke-virtual {v2}, Landroid/widget/TextView;->getVisibility()I

    move-result v2

    if-eqz v2, :cond_5

    iget-object v2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->o:Landroid/widget/TextView;

    invoke-virtual {v2, v1}, Landroid/widget/TextView;->setVisibility(I)V

    :cond_5
    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->o:Landroid/widget/TextView;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const v3, 0x7f0f0409

    invoke-virtual {p0, v3}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v3, " "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    iget-object v5, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    iget-object v5, v5, Lchat/ola/vn/message/f;->K:Ljava/lang/Long;

    invoke-virtual {v5}, Ljava/lang/Long;->longValue()J

    move-result-wide v5

    const/4 v7, 0x0

    sub-long v7, v3, v5

    invoke-static {}, Lchat/ola/vn/b;->d()Lchat/ola/vn/b;

    move-result-object v3

    invoke-virtual {v3}, Lchat/ola/vn/b;->c()[Ljava/lang/String;

    move-result-object v3

    invoke-static {}, Lchat/ola/vn/b;->d()Lchat/ola/vn/b;

    move-result-object v4

    invoke-virtual {v4}, Lchat/ola/vn/b;->a()[Ljava/lang/String;

    move-result-object v4

    invoke-static {}, Lchat/ola/vn/b;->d()Lchat/ola/vn/b;

    move-result-object v5

    invoke-virtual {v5}, Lchat/ola/vn/b;->b()[Ljava/lang/String;

    move-result-object v5

    invoke-static {v7, v8, v3, v4, v5}, Lcom/mg/ola/common/d/i;->a(J[Ljava/lang/String;[Ljava/lang/String;[Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_6

    :cond_6
    :goto_5
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    iput-wide v1, v0, Lchat/ola/vn/message/f;->L:J

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {v2}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v2

    new-instance v3, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$28;

    invoke-direct {v3, p0, v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$28;-><init>(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;Lchat/ola/vn/message/f;)V

    invoke-virtual {v1, v2, v3}, Lchat/ola/vn/network/OlaNetworkService;->b(Ljava/lang/String;Lchat/ola/vn/p/d;)V

    goto :goto_6

    :cond_7
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->o:Landroid/widget/TextView;

    iget-object v2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {v2}, Lchat/ola/vn/message/f;->d()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->o:Landroid/widget/TextView;

    invoke-virtual {v0}, Landroid/widget/TextView;->getVisibility()I

    move-result v0

    if-eqz v0, :cond_8

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->o:Landroid/widget/TextView;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_8
    :goto_6
    :try_start_1
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    iget-object v0, v0, Lchat/ola/vn/message/f;->T:Lchat/ola/vn/message/d;

    if-nez v0, :cond_d

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {v2}, Lchat/ola/vn/message/f;->k()S

    move-result v2

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/network/OlaNetworkService;->x(Ljava/lang/String;S)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    return-void

    :cond_9
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->b()Ljava/lang/String;

    move-result-object v0

    iget-object v2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->n:Landroid/widget/TextView;

    invoke-virtual {v2, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    sget-object v0, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/f;->i()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v2

    if-eqz v0, :cond_c

    if-nez v2, :cond_a

    goto :goto_8

    :cond_a
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->o:Landroid/widget/TextView;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const/16 v4, 0xc8

    if-lt v2, v4, :cond_b

    const-string v2, "200+"

    goto :goto_7

    :cond_b
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, ""

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    :goto_7
    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, " "

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v2, 0x7f0f0442

    invoke-static {v2}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v2

    sget-object v4, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v2, v4}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    goto :goto_9

    :cond_c
    :goto_8
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->o:Landroid/widget/TextView;

    const v2, 0x7f0f046b

    invoke-static {v2}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v2

    :goto_9
    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->o:Landroid/widget/TextView;

    invoke-virtual {v0}, Landroid/widget/TextView;->getVisibility()I

    move-result v0

    if-eqz v0, :cond_d

    goto/16 :goto_0

    :catch_1
    :cond_d
    return-void

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

.method private ac()Lchat/ola/vn/message/d;
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    if-nez v0, :cond_0

    const/4 v0, 0x0

    return-object v0

    :cond_0
    new-instance v0, Lchat/ola/vn/message/d;

    invoke-direct {v0}, Lchat/ola/vn/message/d;-><init>()V

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/message/d;->d(Ljava/lang/String;)V

    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/message/d;->e(Ljava/lang/String;)V

    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

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

.method private ad()V
    .locals 2
    .annotation build Landroid/annotation/TargetApi;
        value = 0xd
    .end annotation

    :try_start_0
    const-string v0, "window"

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

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

.method private ae()V
    .locals 4

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->ab:Landroid/widget/ImageButton;

    const v1, 0x7f080112

    invoke-virtual {v0, v1}, Landroid/widget/ImageButton;->setImageResource(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->ab:Landroid/widget/ImageButton;

    const/4 v2, 0x0

    invoke-virtual {v0, v2}, Landroid/widget/ImageButton;->setSelected(Z)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->ac:Landroid/widget/ImageButton;

    invoke-virtual {v0, v2}, Landroid/widget/ImageButton;->setSelected(Z)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->ad:Landroid/widget/ImageButton;

    invoke-virtual {v0, v2}, Landroid/widget/ImageButton;->setSelected(Z)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->ae:Landroid/widget/ImageButton;

    invoke-virtual {v0, v2}, Landroid/widget/ImageButton;->setSelected(Z)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->af:Landroid/widget/ImageButton;

    invoke-virtual {v0, v2}, Landroid/widget/ImageButton;->setSelected(Z)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->ag:Landroid/widget/ImageButton;

    invoke-virtual {v0, v2}, Landroid/widget/ImageButton;->setSelected(Z)V

    iget v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->aj:I

    const/4 v3, 0x1

    packed-switch v0, :pswitch_data_0

    return-void

    :pswitch_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->ag:Landroid/widget/ImageButton;

    goto :goto_0

    :pswitch_1
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->af:Landroid/widget/ImageButton;

    goto :goto_0

    :pswitch_2
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->ae:Landroid/widget/ImageButton;

    goto :goto_0

    :pswitch_3
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->ad:Landroid/widget/ImageButton;

    goto :goto_0

    :pswitch_4
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->ac:Landroid/widget/ImageButton;

    :goto_0
    invoke-virtual {v0, v3}, Landroid/widget/ImageButton;->setSelected(Z)V

    return-void

    :pswitch_5
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->ab:Landroid/widget/ImageButton;

    goto :goto_1

    :pswitch_6
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->ab:Landroid/widget/ImageButton;

    const v1, 0x7f080143

    :goto_1
    invoke-virtual {v0, v1}, Landroid/widget/ImageButton;->setImageResource(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->ab:Landroid/widget/ImageButton;

    invoke-virtual {v0, v2}, Landroid/widget/ImageButton;->setSelected(Z)V

    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private af()V
    .locals 2

    iget v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->ai:I

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->K:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getHeight()I

    move-result v0

    sget v1, Lchat/ola/vn/activity/OlaChatViewActivity;->g:I

    sub-int/2addr v0, v1

    iput v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->ai:I

    :cond_0
    new-instance v0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$16;

    invoke-direct {v0, p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$16;-><init>(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method private ag()V
    .locals 1

    new-instance v0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$17;

    invoke-direct {v0, p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$17;-><init>(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method private ah()V
    .locals 3

    :try_start_0
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x17

    if-lt v0, v1, :cond_0

    const-string v0, "android.permission.CAMERA"

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->checkSelfPermission(Ljava/lang/String;)I

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "android.permission.CAMERA"

    aput-object v2, v0, v1

    const/16 v1, 0x69

    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->requestPermissions([Ljava/lang/String;I)V

    return-void

    :cond_0
    invoke-direct {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->ai()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method private ai()V
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

    iput-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->am:Ljava/io/File;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->am:Ljava/io/File;

    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->am:Ljava/io/File;

    invoke-virtual {v1}, Ljava/io/File;->delete()Z

    :cond_0
    const-string v1, "output"

    iget-object v2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->am:Ljava/io/File;

    invoke-static {v2}, Landroid/net/Uri;->fromFile(Ljava/io/File;)Landroid/net/Uri;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Parcelable;)Landroid/content/Intent;

    const/4 v1, 0x2

    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->startActivityForResult(Landroid/content/Intent;I)V

    return-void
.end method

.method private aj()V
    .locals 4

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->ak:Lchat/ola/vn/i/c;

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/i/c;

    invoke-direct {v0, p0}, Lchat/ola/vn/i/c;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->ak:Lchat/ola/vn/i/c;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->ak:Lchat/ola/vn/i/c;

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

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->ac()Lchat/ola/vn/message/d;

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

    invoke-direct {p0, v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->b(Lchat/ola/vn/message/d;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->k()S

    move-result v0

    if-ne v0, v3, :cond_1

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

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

    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

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
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->ak:Lchat/ola/vn/i/c;

    const-wide/16 v1, 0x7530

    const/4 v3, 0x0

    invoke-virtual {v0, v1, v2, v3}, Lchat/ola/vn/i/c;->a(JLjava/lang/Runnable;)V

    const-wide/16 v0, 0x3a98

    new-instance v2, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$20;

    invoke-direct {v2, p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$20;-><init>(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;)V

    invoke-static {p0, v0, v1, v2}, Lchat/ola/vn/n/b;->b(Landroid/content/Context;JLchat/ola/vn/n/b$b;)V

    return-void
.end method

.method private ak()Z
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

    new-instance v3, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$21;

    invoke-direct {v3, p0, v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$21;-><init>(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;Ljava/util/List;)V

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

.method public static b(Landroid/content/Context;)Landroid/graphics/Bitmap;
    .locals 2

    sget-object v0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->g:Landroid/graphics/Bitmap;

    if-nez v0, :cond_0

    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const v1, 0x7f0806a5

    invoke-static {v0, v1}, Landroid/graphics/BitmapFactory;->decodeResource(Landroid/content/res/Resources;I)Landroid/graphics/Bitmap;

    move-result-object v0

    sput-object v0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->g:Landroid/graphics/Bitmap;

    sget-object v0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->g:Landroid/graphics/Bitmap;

    invoke-static {p0, v0}, Lchat/ola/vn/balloon/b;->a(Landroid/content/Context;Landroid/graphics/Bitmap;)Landroid/graphics/Bitmap;

    move-result-object p0

    sput-object p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->g:Landroid/graphics/Bitmap;

    :cond_0
    sget-object p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->g:Landroid/graphics/Bitmap;

    return-object p0
.end method

.method static synthetic b(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;)Landroid/widget/ListView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->l:Landroid/widget/ListView;

    return-object p0
.end method

.method private b(Lchat/ola/vn/message/d;)V
    .locals 2

    const/4 v0, 0x1

    if-eqz p1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {v1, p1}, Lchat/ola/vn/message/f;->a(Lchat/ola/vn/message/d;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {p1, v0}, Lchat/ola/vn/message/f;->d(Z)V

    :cond_0
    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->d(Z)V

    return-void
.end method

.method private b(Ljava/lang/CharSequence;)V
    .locals 2

    iget-boolean v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->al:Z

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    iput-boolean v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->al:Z

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
    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->R:Landroid/widget/ImageButton;

    invoke-virtual {p1, v0}, Landroid/widget/ImageButton;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->Q:Landroid/widget/Button;

    invoke-virtual {p1, v1}, Landroid/widget/Button;->setVisibility(I)V

    return-void

    :cond_2
    :goto_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->R:Landroid/widget/ImageButton;

    invoke-virtual {p1, v1}, Landroid/widget/ImageButton;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->Q:Landroid/widget/Button;

    invoke-virtual {p1, v0}, Landroid/widget/Button;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->R:Landroid/widget/ImageButton;

    invoke-virtual {p1, v1}, Landroid/widget/ImageButton;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->Q:Landroid/widget/Button;

    invoke-virtual {p1, v0}, Landroid/widget/Button;->setVisibility(I)V

    return-void
.end method

.method static synthetic c(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;)Lchat/ola/vn/b/o;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->G:Lchat/ola/vn/b/o;

    return-object p0
.end method

.method private d(I)V
    .locals 4

    sget-object v0, Lchat/ola/vn/OlaApplication;->c:Lchat/ola/vn/balloon/OlaBalloonService;

    invoke-virtual {v0}, Lchat/ola/vn/balloon/OlaBalloonService;->f()Ljava/util/List;

    move-result-object v0

    add-int/lit8 v1, p1, -0x1

    const/4 v2, 0x0

    const/4 v3, 0x0

    :try_start_0
    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/balloon/e;

    iget-object v0, v0, Lchat/ola/vn/balloon/e;->s:Lchat/ola/vn/message/f;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-object v0, v2

    const/4 p1, 0x0

    :goto_0
    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->r:Landroid/view/View;

    invoke-virtual {v1, v3}, Landroid/view/View;->setSelected(Z)V

    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->t:Landroid/view/View;

    invoke-virtual {v1, v3}, Landroid/view/View;->setSelected(Z)V

    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->w:Landroid/view/View;

    invoke-virtual {v1, v3}, Landroid/view/View;->setSelected(Z)V

    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->z:Landroid/view/View;

    invoke-virtual {v1, v3}, Landroid/view/View;->setSelected(Z)V

    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->C:Landroid/view/View;

    invoke-virtual {v1, v3}, Landroid/view/View;->setSelected(Z)V

    const/4 v1, 0x1

    packed-switch p1, :pswitch_data_0

    goto :goto_1

    :pswitch_0
    iget-object v2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->C:Landroid/view/View;

    goto :goto_1

    :pswitch_1
    iget-object v2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->z:Landroid/view/View;

    goto :goto_1

    :pswitch_2
    iget-object v2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->w:Landroid/view/View;

    goto :goto_1

    :pswitch_3
    iget-object v2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->t:Landroid/view/View;

    goto :goto_1

    :pswitch_4
    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->n:Landroid/widget/TextView;

    const v0, 0x7f0f0490

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->o:Landroid/widget/TextView;

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    invoke-direct {p0, v3}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->h(Z)V

    iput v3, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->aj:I

    invoke-direct {p0, v3}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->e(Z)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->r:Landroid/view/View;

    invoke-virtual {p1, v1}, Landroid/view/View;->setSelected(Z)V

    :try_start_1
    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->l:Landroid/widget/ListView;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->H:Lchat/ola/vn/b/r;

    invoke-virtual {p1, v0}, Landroid/widget/ListView;->setAdapter(Landroid/widget/ListAdapter;)V

    sget p1, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->j:I

    sget v0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->i:I

    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->l:Landroid/widget/ListView;

    new-instance v2, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$23;

    invoke-direct {v2, p0, p1, v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$23;-><init>(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;II)V

    invoke-virtual {v1, v2}, Landroid/widget/ListView;->post(Ljava/lang/Runnable;)Z
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    return-void

    :goto_1
    invoke-direct {p0, v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->h(Lchat/ola/vn/message/f;)V

    if-eqz v2, :cond_1

    invoke-virtual {v2}, Landroid/view/View;->getVisibility()I

    move-result p1

    if-eqz p1, :cond_0

    invoke-virtual {v2, v3}, Landroid/view/View;->setVisibility(I)V

    :cond_0
    invoke-virtual {v2, v1}, Landroid/view/View;->setSelected(Z)V

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->ab()V

    invoke-direct {p0, v1}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->e(Z)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->l:Landroid/widget/ListView;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->G:Lchat/ola/vn/b/o;

    invoke-virtual {p1, v0}, Landroid/widget/ListView;->setAdapter(Landroid/widget/ListAdapter;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    iget p1, p1, Lchat/ola/vn/message/f;->D:I

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    iget v0, v0, Lchat/ola/vn/message/f;->E:I

    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->l:Landroid/widget/ListView;

    new-instance v2, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$24;

    invoke-direct {v2, p0, p1, v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$24;-><init>(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;II)V

    invoke-virtual {v1, v2}, Landroid/widget/ListView;->post(Ljava/lang/Runnable;)Z

    :cond_1
    return-void

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method static synthetic d(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->X()V

    return-void
.end method

.method static synthetic e(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->U()V

    return-void
.end method

.method private e(Z)V
    .locals 1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->p:Landroid/view/View;

    const/4 v0, 0x0

    :goto_0
    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->p:Landroid/view/View;

    const/16 v0, 0x8

    goto :goto_0

    return-void
.end method

.method static synthetic f(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;)Landroid/view/View;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->K:Landroid/view/View;

    return-object p0
.end method

.method private f(Z)V
    .locals 9

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->L:Lcom/mg/ola/a/a/b/c;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->L:Lcom/mg/ola/a/a/b/c;

    invoke-virtual {v0}, Lcom/mg/ola/a/a/b/c;->b()V

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->K:Landroid/view/View;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/mg/ola/a/a/c/b;->b(Landroid/view/View;F)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->K:Landroid/view/View;

    invoke-static {v0, v1}, Lcom/mg/ola/a/a/c/b;->c(Landroid/view/View;F)V

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const v1, 0x7f0700f8

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v0

    new-instance v1, Landroid/graphics/Rect;

    sget v2, Lchat/ola/vn/e;->c:I

    sget v3, Lchat/ola/vn/e;->d:I

    const/4 v4, 0x0

    invoke-direct {v1, v4, v0, v2, v3}, Landroid/graphics/Rect;-><init>(IIII)V

    new-instance v0, Landroid/graphics/Rect;

    invoke-direct {v0}, Landroid/graphics/Rect;-><init>()V

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->W()Landroid/view/View;

    move-result-object v2

    invoke-virtual {v2, v0}, Landroid/view/View;->getGlobalVisibleRect(Landroid/graphics/Rect;)Z

    invoke-static {p0}, Lchat/ola/vn/util/n;->a(Landroid/content/Context;)I

    move-result v2

    neg-int v2, v2

    invoke-virtual {v0, v4, v2}, Landroid/graphics/Rect;->offset(II)V

    invoke-virtual {v1, v4, v2}, Landroid/graphics/Rect;->offset(II)V

    invoke-virtual {v0}, Landroid/graphics/Rect;->height()I

    move-result v2

    int-to-float v2, v2

    invoke-virtual {v1}, Landroid/graphics/Rect;->height()I

    move-result v3

    int-to-float v3, v3

    div-float/2addr v2, v3

    new-instance v3, Lcom/mg/ola/a/a/b/c;

    invoke-direct {v3}, Lcom/mg/ola/a/a/b/c;-><init>()V

    iget-object v5, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->K:Landroid/view/View;

    const-string v6, "translationX"

    const/4 v7, 0x2

    new-array v8, v7, [F

    iget v1, v1, Landroid/graphics/Rect;->left:I

    int-to-float v1, v1

    aput v1, v8, v4

    iget v0, v0, Landroid/graphics/Rect;->left:I

    int-to-float v0, v0

    const/4 v1, 0x1

    aput v0, v8, v1

    invoke-static {v5, v6, v8}, Lcom/mg/ola/a/a/b/j;->a(Ljava/lang/Object;Ljava/lang/String;[F)Lcom/mg/ola/a/a/b/j;

    move-result-object v0

    iget-object v5, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->K:Landroid/view/View;

    const-string v6, "scaleX"

    new-array v8, v1, [F

    aput v2, v8, v4

    invoke-static {v5, v6, v8}, Lcom/mg/ola/a/a/b/j;->a(Ljava/lang/Object;Ljava/lang/String;[F)Lcom/mg/ola/a/a/b/j;

    move-result-object v5

    iget-object v6, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->K:Landroid/view/View;

    const-string v8, "scaleY"

    new-array v1, v1, [F

    aput v2, v1, v4

    invoke-static {v6, v8, v1}, Lcom/mg/ola/a/a/b/j;->a(Ljava/lang/Object;Ljava/lang/String;[F)Lcom/mg/ola/a/a/b/j;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->K:Landroid/view/View;

    const-string v4, "alpha"

    new-array v6, v7, [F

    fill-array-data v6, :array_0

    invoke-static {v2, v4, v6}, Lcom/mg/ola/a/a/b/j;->a(Ljava/lang/Object;Ljava/lang/String;[F)Lcom/mg/ola/a/a/b/j;

    move-result-object v2

    iget-object v4, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->q:Landroid/view/View;

    const-string v6, "alpha"

    new-array v7, v7, [F

    fill-array-data v7, :array_1

    invoke-static {v4, v6, v7}, Lcom/mg/ola/a/a/b/j;->a(Ljava/lang/Object;Ljava/lang/String;[F)Lcom/mg/ola/a/a/b/j;

    move-result-object v4

    invoke-virtual {v3, v5}, Lcom/mg/ola/a/a/b/c;->a(Lcom/mg/ola/a/a/b/a;)Lcom/mg/ola/a/a/b/c$b;

    move-result-object v5

    invoke-virtual {v5, v1}, Lcom/mg/ola/a/a/b/c$b;->a(Lcom/mg/ola/a/a/b/a;)Lcom/mg/ola/a/a/b/c$b;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/mg/ola/a/a/b/c$b;->a(Lcom/mg/ola/a/a/b/a;)Lcom/mg/ola/a/a/b/c$b;

    move-result-object v0

    invoke-virtual {v0, v2}, Lcom/mg/ola/a/a/b/c$b;->a(Lcom/mg/ola/a/a/b/a;)Lcom/mg/ola/a/a/b/c$b;

    move-result-object v0

    invoke-virtual {v0, v4}, Lcom/mg/ola/a/a/b/c$b;->a(Lcom/mg/ola/a/a/b/a;)Lcom/mg/ola/a/a/b/c$b;

    iget v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->M:I

    int-to-long v0, v0

    invoke-virtual {v3, v0, v1}, Lcom/mg/ola/a/a/b/c;->b(J)Lcom/mg/ola/a/a/b/c;

    new-instance v0, Landroid/view/animation/DecelerateInterpolator;

    invoke-direct {v0}, Landroid/view/animation/DecelerateInterpolator;-><init>()V

    invoke-virtual {v3, v0}, Lcom/mg/ola/a/a/b/c;->a(Landroid/view/animation/Interpolator;)V

    new-instance v0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$27;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$27;-><init>(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;Z)V

    invoke-virtual {v3, v0}, Lcom/mg/ola/a/a/b/c;->a(Lcom/mg/ola/a/a/b/a$a;)V

    invoke-virtual {v3}, Lcom/mg/ola/a/a/b/c;->a()V

    iput-object v3, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->L:Lcom/mg/ola/a/a/b/c;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    :try_start_1
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->K:Landroid/view/View;

    const/4 v1, 0x4

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    if-eqz p1, :cond_1

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->Y()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    :cond_1
    return-void

    nop

    :array_0
    .array-data 4
        0x3f800000    # 1.0f
        0x0
    .end array-data

    :array_1
    .array-data 4
        0x3f800000    # 1.0f
        0x3dcccccd    # 0.1f
    .end array-data
.end method

.method static synthetic g(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->Y()V

    return-void
.end method

.method private g(Z)V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->h(Z)V

    if-eqz p1, :cond_0

    const/4 p1, 0x1

    invoke-direct {p0, p1}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->f(Z)V

    iput-boolean p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->e:Z

    return-void

    :cond_0
    invoke-direct {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->Y()V

    return-void
.end method

.method static synthetic h(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;)Lchat/ola/vn/message/f;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    return-object p0
.end method

.method private h(Lchat/ola/vn/message/f;)V
    .locals 6

    if-nez p1, :cond_0

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->finish()V

    return-void

    :catch_0
    move-exception p1

    goto/16 :goto_3

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

    new-instance v2, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$3;

    invoke-direct {v2, p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$3;-><init>(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;)V

    invoke-static {v2}, Lchat/ola/vn/entry/c/f;->a(Lchat/ola/vn/entry/c/e;)S

    move-result v2

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/network/OlaNetworkService;->p(Ljava/lang/String;S)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    :cond_2
    :try_start_2
    iput-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->G:Lchat/ola/vn/b/o;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {p1, v0}, Lchat/ola/vn/b/o;->a(Lchat/ola/vn/message/f;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->G:Lchat/ola/vn/b/o;

    invoke-virtual {p1}, Lchat/ola/vn/b/o;->notifyDataSetChanged()V

    sget-object p1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {p1}, Lchat/ola/vn/message/g;->t()V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Lchat/ola/vn/message/f;->a(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->A()V

    invoke-static {}, Lchat/ola/vn/h;->g()Z

    move-result p1

    const/4 v1, 0x2

    const/4 v2, 0x1

    if-eqz p1, :cond_5

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    iget-byte p1, p1, Lchat/ola/vn/message/f;->V:B

    if-nez p1, :cond_5

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_5

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->k()S

    move-result p1
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    const/4 v3, 0x0

    if-ne p1, v1, :cond_3

    :try_start_3
    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v4, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {v4}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v4

    new-instance v5, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$4;

    invoke-direct {v5, p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$4;-><init>(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;)V

    invoke-static {v5}, Lchat/ola/vn/entry/c/f;->a(Lchat/ola/vn/entry/c/e;)S

    move-result v5

    invoke-virtual {p1, v4, v3, v5}, Lchat/ola/vn/network/OlaNetworkService;->h(Ljava/lang/String;Ljava/lang/String;S)Z

    move-result p1

    if-eqz p1, :cond_5

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    iput-byte v2, p1, Lchat/ola/vn/message/f;->V:B

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    iput-object v3, p1, Lchat/ola/vn/message/f;->O:Ljava/lang/String;

    :goto_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    iput-boolean v2, p1, Lchat/ola/vn/message/f;->Q:Z
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_2

    goto :goto_1

    :cond_3
    :try_start_4
    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->k()S

    move-result p1
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_0

    if-nez p1, :cond_4

    :try_start_5
    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v4, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {v4}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v4

    new-instance v5, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$5;

    invoke-direct {v5, p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$5;-><init>(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;)V

    invoke-static {v5}, Lchat/ola/vn/entry/c/f;->a(Lchat/ola/vn/entry/c/e;)S

    move-result v5

    invoke-virtual {p1, v4, v3, v5}, Lchat/ola/vn/network/OlaNetworkService;->i(Ljava/lang/String;Ljava/lang/String;S)Z

    move-result p1

    if-eqz p1, :cond_5

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    iput-byte v2, p1, Lchat/ola/vn/message/f;->V:B

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    iput-object v3, p1, Lchat/ola/vn/message/f;->O:Ljava/lang/String;
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_2

    goto :goto_0

    :cond_4
    :try_start_6
    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    iput-byte v1, p1, Lchat/ola/vn/message/f;->V:B

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    iput-object v3, p1, Lchat/ola/vn/message/f;->O:Ljava/lang/String;

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    iput-boolean v0, p1, Lchat/ola/vn/message/f;->Q:Z

    :catch_2
    :cond_5
    :goto_1
    invoke-direct {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->Z()V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->k()S

    move-result p1

    if-eqz p1, :cond_8

    if-eq p1, v1, :cond_7

    const/4 v1, 0x4

    if-eq p1, v1, :cond_6

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->m:Landroid/widget/EditText;

    const v0, 0x7f0f06bb

    invoke-virtual {p1, v0}, Landroid/widget/EditText;->setHint(I)V

    return-void

    :cond_6
    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->m:Landroid/widget/EditText;

    const v1, 0x7f0f06bd

    new-array v2, v2, [Ljava/lang/Object;

    iget-object v3, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {v3}, Lchat/ola/vn/message/f;->b()Ljava/lang/String;

    move-result-object v3

    aput-object v3, v2, v0

    invoke-virtual {p0, v1, v2}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    :goto_2
    invoke-virtual {p1, v0}, Landroid/widget/EditText;->setHint(Ljava/lang/CharSequence;)V

    return-void

    :cond_7
    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->m:Landroid/widget/EditText;

    const v1, 0x7f0f06bc

    new-array v2, v2, [Ljava/lang/Object;

    iget-object v3, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {v3}, Lchat/ola/vn/message/f;->L()Ljava/lang/CharSequence;

    move-result-object v3

    aput-object v3, v2, v0

    invoke-virtual {p0, v1, v2}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_2

    :cond_8
    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->m:Landroid/widget/EditText;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const v1, 0x7f0f06be

    invoke-virtual {p0, v1}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, " "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_0

    goto :goto_2

    :goto_3
    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method private h(Z)V
    .locals 1
    .annotation build Landroid/annotation/TargetApi;
        value = 0xc
    .end annotation

    :try_start_0
    new-instance v0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$14;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$14;-><init>(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;Z)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic i(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;)Landroid/widget/TextView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->o:Landroid/widget/TextView;

    return-object p0
.end method

.method private i(Z)V
    .locals 2

    if-eqz p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->S:Landroid/widget/FrameLayout;

    invoke-virtual {p1}, Landroid/widget/FrameLayout;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object p1

    iget v0, p1, Landroid/view/ViewGroup$LayoutParams;->height:I

    sget v1, Lchat/ola/vn/activity/OlaChatViewActivity;->g:I

    if-eq v0, v1, :cond_0

    sget v0, Lchat/ola/vn/activity/OlaChatViewActivity;->g:I

    iput v0, p1, Landroid/view/ViewGroup$LayoutParams;->height:I

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->S:Landroid/widget/FrameLayout;

    invoke-virtual {v0, p1}, Landroid/widget/FrameLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->S:Landroid/widget/FrameLayout;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/widget/FrameLayout;->setVisibility(I)V

    return-void

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->S:Landroid/widget/FrameLayout;

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/widget/FrameLayout;->setVisibility(I)V

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->S:Landroid/widget/FrameLayout;

    invoke-virtual {p1}, Landroid/widget/FrameLayout;->removeAllViews()V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->Z:Lchat/ola/vn/view/d;

    if-eqz p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->Z:Lchat/ola/vn/view/d;

    invoke-virtual {p1}, Lchat/ola/vn/view/d;->a()V

    :cond_2
    const/4 p1, 0x0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->Z:Lchat/ola/vn/view/d;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic j(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->Z()V

    return-void
.end method

.method private j(Z)V
    .locals 5

    :try_start_0
    invoke-direct {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->ae()V

    iget v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->aj:I

    const/16 v1, 0x8

    const/4 v2, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x1

    packed-switch v0, :pswitch_data_0

    goto/16 :goto_5

    :pswitch_0
    iput-object v2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->V:Lchat/ola/vn/view/d;

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->ah:Landroid/view/View;

    invoke-virtual {p1, v1}, Landroid/view/View;->setVisibility(I)V

    invoke-direct {p0, v4}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->i(Z)V

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->af()V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->Y:Lchat/ola/vn/view/f;

    if-nez p1, :cond_0

    new-instance p1, Lchat/ola/vn/view/f;

    invoke-direct {p1, p0}, Lchat/ola/vn/view/f;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->Y:Lchat/ola/vn/view/f;

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->Y:Lchat/ola/vn/view/f;

    invoke-virtual {p1, p0}, Lchat/ola/vn/view/f;->setOnMoreActionClickedListener(Lchat/ola/vn/view/f$a;)V

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->Y:Lchat/ola/vn/view/f;

    if-eqz p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->k()S

    move-result p1

    const/4 v0, 0x2

    if-ne p1, v0, :cond_1

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->Y:Lchat/ola/vn/view/f;

    invoke-virtual {p1, v3}, Lchat/ola/vn/view/f;->setTransferKenButtonVisibility(Z)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->Y:Lchat/ola/vn/view/f;

    invoke-virtual {p1, v3}, Lchat/ola/vn/view/f;->setTradingVipButtonVisibility(Z)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->Y:Lchat/ola/vn/view/f;

    invoke-virtual {p1, v3}, Lchat/ola/vn/view/f;->setSendVipDayButtonVisibility(Z)V

    goto :goto_0

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->Y:Lchat/ola/vn/view/f;

    invoke-virtual {p1, v4}, Lchat/ola/vn/view/f;->setTransferKenButtonVisibility(Z)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->Y:Lchat/ola/vn/view/f;

    invoke-virtual {p1, v4}, Lchat/ola/vn/view/f;->setTradingVipButtonVisibility(Z)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->Y:Lchat/ola/vn/view/f;

    invoke-virtual {p1, v4}, Lchat/ola/vn/view/f;->setSendVipDayButtonVisibility(Z)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_2

    :cond_2
    :goto_0
    :try_start_1
    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->Z:Lchat/ola/vn/view/d;

    if-eqz p1, :cond_3

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->Z:Lchat/ola/vn/view/d;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->Y:Lchat/ola/vn/view/f;

    if-eq p1, v0, :cond_11

    :cond_3
    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->S:Landroid/widget/FrameLayout;

    invoke-virtual {p1}, Landroid/widget/FrameLayout;->removeAllViews()V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->S:Landroid/widget/FrameLayout;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->Y:Lchat/ola/vn/view/f;

    invoke-virtual {p1, v0}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->Y:Lchat/ola/vn/view/f;

    :goto_1
    iput-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->Z:Lchat/ola/vn/view/d;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto/16 :goto_5

    :pswitch_1
    :try_start_2
    iput-object v2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->V:Lchat/ola/vn/view/d;

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->ah:Landroid/view/View;

    invoke-virtual {p1, v1}, Landroid/view/View;->setVisibility(I)V

    invoke-direct {p0, v4}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->i(Z)V

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->af()V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->X:Lchat/ola/vn/view/j;

    if-nez p1, :cond_4

    new-instance p1, Lchat/ola/vn/view/j;

    invoke-direct {p1, p0}, Lchat/ola/vn/view/j;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->X:Lchat/ola/vn/view/j;

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->X:Lchat/ola/vn/view/j;

    invoke-virtual {p1, p0}, Lchat/ola/vn/view/j;->setOnVoiceRecordListener(Lchat/ola/vn/view/j$a;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    :cond_4
    :try_start_3
    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->Z:Lchat/ola/vn/view/d;

    if-eqz p1, :cond_5

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->Z:Lchat/ola/vn/view/d;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->X:Lchat/ola/vn/view/j;

    if-eq p1, v0, :cond_11

    :cond_5
    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->S:Landroid/widget/FrameLayout;

    invoke-virtual {p1}, Landroid/widget/FrameLayout;->removeAllViews()V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->S:Landroid/widget/FrameLayout;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->X:Lchat/ola/vn/view/j;

    invoke-virtual {p1, v0}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->X:Lchat/ola/vn/view/j;
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_0

    goto :goto_1

    :pswitch_2
    :try_start_4
    iput-object v2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->V:Lchat/ola/vn/view/d;

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->ah:Landroid/view/View;

    invoke-virtual {p1, v1}, Landroid/view/View;->setVisibility(I)V

    invoke-direct {p0, v4}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->i(Z)V

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->af()V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->W:Lchat/ola/vn/view/g;

    if-nez p1, :cond_6

    new-instance p1, Lchat/ola/vn/view/g;

    invoke-direct {p1, p0}, Lchat/ola/vn/view/g;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->W:Lchat/ola/vn/view/g;

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->W:Lchat/ola/vn/view/g;

    invoke-virtual {p1, v3}, Lchat/ola/vn/view/g;->setAllowVideo(Z)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->W:Lchat/ola/vn/view/g;

    invoke-virtual {p1, p0}, Lchat/ola/vn/view/g;->setOlaPhotoListener(Lchat/ola/vn/view/g$e;)V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_2

    :cond_6
    :try_start_5
    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->Z:Lchat/ola/vn/view/d;

    if-eqz p1, :cond_7

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->Z:Lchat/ola/vn/view/d;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->W:Lchat/ola/vn/view/g;

    if-eq p1, v0, :cond_11

    :cond_7
    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->S:Landroid/widget/FrameLayout;

    invoke-virtual {p1}, Landroid/widget/FrameLayout;->removeAllViews()V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->S:Landroid/widget/FrameLayout;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->W:Lchat/ola/vn/view/g;

    invoke-virtual {p1, v0}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->W:Lchat/ola/vn/view/g;
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_0

    goto :goto_1

    :pswitch_3
    :try_start_6
    iput-object v2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->V:Lchat/ola/vn/view/d;

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->ah:Landroid/view/View;

    invoke-virtual {p1, v1}, Landroid/view/View;->setVisibility(I)V

    invoke-direct {p0, v4}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->i(Z)V

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->af()V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->U:Lchat/ola/vn/view/i;

    if-nez p1, :cond_8

    new-instance p1, Lchat/ola/vn/view/i;

    invoke-direct {p1, p0}, Lchat/ola/vn/view/i;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->U:Lchat/ola/vn/view/i;

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->U:Lchat/ola/vn/view/i;

    invoke-virtual {p1, p0}, Lchat/ola/vn/view/i;->setOnStickerClickedListener(Lchat/ola/vn/view/i$e;)V
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_2

    :cond_8
    :try_start_7
    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->Z:Lchat/ola/vn/view/d;

    if-eqz p1, :cond_9

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->Z:Lchat/ola/vn/view/d;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->U:Lchat/ola/vn/view/i;

    if-eq p1, v0, :cond_11

    :cond_9
    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->S:Landroid/widget/FrameLayout;

    invoke-virtual {p1}, Landroid/widget/FrameLayout;->removeAllViews()V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->S:Landroid/widget/FrameLayout;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->U:Lchat/ola/vn/view/i;

    invoke-virtual {p1, v0}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->U:Lchat/ola/vn/view/i;
    :try_end_7
    .catch Ljava/lang/Throwable; {:try_start_7 .. :try_end_7} :catch_0

    goto/16 :goto_1

    :pswitch_4
    :try_start_8
    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->ah:Landroid/view/View;

    invoke-virtual {p1, v1}, Landroid/view/View;->setVisibility(I)V

    invoke-direct {p0, v4}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->i(Z)V

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->af()V

    invoke-static {}, Lcom/mg/ola/common/d/g;->f()Z

    move-result p1

    if-eqz p1, :cond_11

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->V:Lchat/ola/vn/view/d;

    if-nez p1, :cond_a

    new-instance p1, Lchat/ola/vn/view/e;

    invoke-direct {p1, p0}, Lchat/ola/vn/view/e;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->V:Lchat/ola/vn/view/d;

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->V:Lchat/ola/vn/view/d;

    check-cast p1, Lchat/ola/vn/view/e;

    invoke-virtual {p1, p0}, Lchat/ola/vn/view/e;->setOlaCameraListener(Lchat/ola/vn/view/e$a;)V
    :try_end_8
    .catch Ljava/lang/Throwable; {:try_start_8 .. :try_end_8} :catch_2

    :cond_a
    :try_start_9
    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->Z:Lchat/ola/vn/view/d;

    if-eqz p1, :cond_b

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->Z:Lchat/ola/vn/view/d;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->V:Lchat/ola/vn/view/d;

    if-eq p1, v0, :cond_11

    :cond_b
    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->S:Landroid/widget/FrameLayout;

    invoke-virtual {p1}, Landroid/widget/FrameLayout;->removeAllViews()V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->S:Landroid/widget/FrameLayout;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->V:Lchat/ola/vn/view/d;

    invoke-virtual {p1, v0}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->V:Lchat/ola/vn/view/d;
    :try_end_9
    .catch Ljava/lang/Throwable; {:try_start_9 .. :try_end_9} :catch_0

    goto/16 :goto_1

    :pswitch_5
    :try_start_a
    iput-object v2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->V:Lchat/ola/vn/view/d;

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->ah:Landroid/view/View;

    invoke-virtual {p1}, Landroid/view/View;->getVisibility()I

    move-result p1

    if-eqz p1, :cond_c

    const/4 p1, 0x1

    goto :goto_2

    :cond_c
    const/4 p1, 0x0

    :goto_2
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->ah:Landroid/view/View;

    invoke-virtual {v0, v3}, Landroid/view/View;->setVisibility(I)V

    invoke-direct {p0, v4}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->i(Z)V

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->af()V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->T:Lchat/ola/vn/view/h;

    if-nez v0, :cond_d

    new-instance v0, Lchat/ola/vn/view/h;

    invoke-direct {v0, p0}, Lchat/ola/vn/view/h;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->T:Lchat/ola/vn/view/h;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->T:Lchat/ola/vn/view/h;

    invoke-virtual {v0, p0}, Lchat/ola/vn/view/h;->setOlaSmileyListener(Lchat/ola/vn/view/h$b;)V
    :try_end_a
    .catch Ljava/lang/Throwable; {:try_start_a .. :try_end_a} :catch_2

    :cond_d
    :try_start_b
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->Z:Lchat/ola/vn/view/d;

    if-eqz v0, :cond_e

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->Z:Lchat/ola/vn/view/d;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->T:Lchat/ola/vn/view/h;

    if-eq v0, v1, :cond_12

    :cond_e
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->S:Landroid/widget/FrameLayout;

    invoke-virtual {v0}, Landroid/widget/FrameLayout;->removeAllViews()V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->S:Landroid/widget/FrameLayout;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->T:Lchat/ola/vn/view/h;

    invoke-virtual {v0, v1}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->T:Lchat/ola/vn/view/h;

    iput-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->Z:Lchat/ola/vn/view/d;
    :try_end_b
    .catch Ljava/lang/Throwable; {:try_start_b .. :try_end_b} :catch_1

    goto :goto_6

    :pswitch_6
    :try_start_c
    iput-object v2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->V:Lchat/ola/vn/view/d;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->ah:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getVisibility()I

    move-result v0

    if-eqz v0, :cond_f

    goto :goto_3

    :cond_f
    const/4 v4, 0x0

    :goto_3
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->ah:Landroid/view/View;

    invoke-virtual {v0, v3}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->S:Landroid/widget/FrameLayout;

    invoke-virtual {v0}, Landroid/widget/FrameLayout;->removeAllViews()V

    invoke-direct {p0, v3}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->i(Z)V

    if-eqz p1, :cond_10

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->af()V

    goto :goto_4

    :cond_10
    invoke-direct {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->ag()V

    :goto_4
    move p1, v4

    goto :goto_6

    :catch_0
    :cond_11
    :goto_5
    const/4 p1, 0x0

    :catch_1
    :cond_12
    :goto_6
    if-eqz p1, :cond_13

    new-instance p1, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$15;

    invoke-direct {p1, p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$15;-><init>(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;)V

    invoke-static {p1}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V
    :try_end_c
    .catch Ljava/lang/Throwable; {:try_start_c .. :try_end_c} :catch_2

    :catch_2
    :cond_13
    return-void

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method static synthetic k(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;)Landroid/widget/Button;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->Q:Landroid/widget/Button;

    return-object p0
.end method

.method static synthetic l(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;)Landroid/widget/ImageButton;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->R:Landroid/widget/ImageButton;

    return-object p0
.end method

.method static synthetic m(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;)I
    .locals 0

    iget p0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->ai:I

    return p0
.end method

.method private m(Ljava/lang/String;)V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    if-nez v0, :cond_0

    return-void

    :cond_0
    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz v0, :cond_1

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->ac()Lchat/ola/vn/message/d;

    move-result-object v0

    const/4 v1, 0x2

    invoke-static {v0, v1, p1}, Lchat/ola/vn/message/e;->a(Lchat/ola/vn/message/d;BLjava/lang/String;)Lchat/ola/vn/message/aa;

    move-result-object v0

    invoke-direct {p0, v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->b(Lchat/ola/vn/message/d;)V

    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    new-instance v2, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;

    invoke-direct {v2, p0, v0, p1, v1}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$7;-><init>(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;Lchat/ola/vn/message/aa;Ljava/lang/String;Lchat/ola/vn/message/f;)V

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

.method static synthetic n(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;)Lchat/ola/vn/i/c;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->ak:Lchat/ola/vn/i/c;

    return-object p0
.end method

.method private n(Ljava/lang/String;)V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->m:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->m:Landroid/widget/EditText;

    invoke-virtual {v1}, Landroid/widget/EditText;->getSelectionStart()I

    move-result v1

    if-ltz v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->m:Landroid/widget/EditText;

    invoke-virtual {v1}, Landroid/widget/EditText;->getSelectionStart()I

    move-result v1

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v1, p1}, Ljava/lang/StringBuilder;->insert(ILjava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->m:Landroid/widget/EditText;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {p0, v2}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->o(Ljava/lang/String;)Ljava/lang/CharSequence;

    move-result-object v2

    invoke-virtual {v0, v2}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->m:Landroid/widget/EditText;

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v2

    add-int/2addr v1, v2

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setSelection(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->m:Landroid/widget/EditText;

    invoke-virtual {v0, p1}, Landroid/widget/EditText;->append(Ljava/lang/CharSequence;)V

    return-void
.end method

.method static synthetic o(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;)Lchat/ola/vn/message/d;
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->ac()Lchat/ola/vn/message/d;

    move-result-object p0

    return-object p0
.end method

.method private o(Ljava/lang/String;)Ljava/lang/CharSequence;
    .locals 0

    invoke-static {p1}, Lchat/ola/vn/util/i;->c(Ljava/lang/String;)Ljava/lang/CharSequence;

    move-result-object p1

    return-object p1
.end method


# virtual methods
.method public C()V
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    if-eqz v0, :cond_0

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {v2}, Lchat/ola/vn/message/f;->k()S

    move-result v2

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/message/g;->d(Ljava/lang/String;S)Lchat/ola/vn/message/f;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-direct {p0, v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->h(Lchat/ola/vn/message/f;)V

    :cond_0
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

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->ah()V

    const/4 v0, 0x0

    iput v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->aj:I

    invoke-direct {p0, v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->j(Z)V

    const/4 v0, 0x1

    return v0
.end method

.method public J()Z
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->S:Landroid/widget/FrameLayout;

    invoke-virtual {v0}, Landroid/widget/FrameLayout;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    const/4 v1, -0x1

    iput v1, v0, Landroid/view/ViewGroup$LayoutParams;->height:I

    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->S:Landroid/widget/FrameLayout;

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
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->S:Landroid/widget/FrameLayout;

    invoke-virtual {v0}, Landroid/widget/FrameLayout;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    iget v1, v0, Landroid/view/ViewGroup$LayoutParams;->height:I

    sget v2, Lchat/ola/vn/activity/OlaChatViewActivity;->g:I

    if-eq v1, v2, :cond_0

    sget v1, Lchat/ola/vn/activity/OlaChatViewActivity;->g:I

    iput v1, v0, Landroid/view/ViewGroup$LayoutParams;->height:I

    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->S:Landroid/widget/FrameLayout;

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
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->m:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->m:Landroid/widget/EditText;

    invoke-virtual {v1}, Landroid/widget/EditText;->getSelectionStart()I

    move-result v1

    if-ltz v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->m:Landroid/widget/EditText;

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

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->m:Landroid/widget/EditText;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->m:Landroid/widget/EditText;

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
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "NewApi"
        }
    .end annotation

    invoke-static {p0}, Lchat/ola/vn/n/b;->b(Landroid/content/Context;)Z

    move-result v0

    if-nez v0, :cond_0

    const/16 v0, 0x65

    invoke-static {p0, v0}, Lchat/ola/vn/n/b;->a(Landroid/app/Activity;I)V

    return-void

    :cond_0
    invoke-direct {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->aj()V

    return-void
.end method

.method public O()V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, v0}, Lchat/ola/vn/transferken/OlaTransferKenActivity;->a(Landroid/content/Context;Ljava/lang/String;)V

    return-void
.end method

.method public P()V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, v0}, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->a(Landroid/content/Context;Ljava/lang/String;)V

    return-void
.end method

.method public Q()V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, v0}, Lchat/ola/vn/activity/BuyVipActivity;->c(Landroid/content/Context;Ljava/lang/String;)V

    return-void
.end method

.method protected a()V
    .locals 2

    const/4 v0, 0x1

    iput-boolean v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->P:Z

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v0, p0}, Lchat/ola/vn/message/g;->a(Lchat/ola/vn/p/f;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->K:Landroid/view/View;

    const/4 v1, 0x4

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->K:Landroid/view/View;

    new-instance v1, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$25;

    invoke-direct {v1, p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$25;-><init>(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;)V

    invoke-virtual {v0, v1}, Landroid/view/View;->post(Ljava/lang/Runnable;)Z

    :try_start_0
    sget-object v0, Lchat/ola/vn/OlaApplication;->c:Lchat/ola/vn/balloon/OlaBalloonService;

    invoke-virtual {v0}, Lchat/ola/vn/balloon/OlaBalloonService;->a()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    invoke-direct {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->V()Z

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

    invoke-direct {p0, p1, v2, v2}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->a(Ljava/lang/String;IZ)V

    return-void

    :cond_0
    invoke-virtual {p1}, Lchat/ola/vn/entity/w;->c()I

    move-result v0

    if-lez v0, :cond_1

    const/4 v0, 0x0

    invoke-virtual {p1}, Lchat/ola/vn/entity/w;->c()I

    move-result p1

    invoke-direct {p0, v0, p1, v2}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->a(Ljava/lang/String;IZ)V
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

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object p1

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_2
    const p1, 0x7f0f0465

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object p1

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const p1, 0x7f0f069f

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object p1

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->u()B

    move-result p1

    if-eq p1, v2, :cond_3

    const p1, 0x7f0f0439

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object p1

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_3
    :pswitch_1
    new-instance p1, Lchat/ola/vn/i/m;

    invoke-direct {p1, p0}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    invoke-virtual {p1, v0}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance v2, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$13;

    invoke-direct {v2, p0, v0, v1}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$13;-><init>(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;Ljava/util/List;Lchat/ola/vn/message/f;)V

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

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->G:Lchat/ola/vn/b/o;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->G:Lchat/ola/vn/b/o;

    invoke-virtual {p1}, Lchat/ola/vn/b/o;->notifyDataSetChanged()V

    :cond_0
    return-void
.end method

.method public a(Lchat/ola/vn/message/f;)V
    .locals 1

    :try_start_0
    iput-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    if-nez p1, :cond_0

    return-void

    :cond_0
    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Lchat/ola/vn/message/f;->a(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->A()V

    invoke-direct {p0, p1}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->h(Lchat/ola/vn/message/f;)V

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->Z()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(Lchat/ola/vn/message/f;ILjava/lang/String;Ljava/util/List;)V
    .locals 0
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

    if-lez p2, :cond_2

    :try_start_0
    iget-object p4, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {p1, p4}, Lchat/ola/vn/message/f;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_2

    invoke-static {p3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_0

    const/4 p1, 0x0

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->d(Z)V

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->l:Landroid/widget/ListView;

    invoke-virtual {p1}, Landroid/widget/ListView;->getFirstVisiblePosition()I

    move-result p1

    add-int/2addr p1, p2

    iget-object p2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->G:Lchat/ola/vn/b/o;

    if-eqz p2, :cond_1

    iget-object p2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->G:Lchat/ola/vn/b/o;

    invoke-virtual {p2}, Lchat/ola/vn/b/o;->notifyDataSetChanged()V

    :cond_1
    iget-object p2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->l:Landroid/widget/ListView;

    invoke-virtual {p2, p1}, Landroid/widget/ListView;->setSelection(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_2
    return-void
.end method

.method public a(Lchat/ola/vn/message/f;Lchat/ola/vn/message/d;)V
    .locals 0

    iget-object p2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    if-eqz p2, :cond_0

    iget-object p2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {p2}, Lchat/ola/vn/message/f;->y()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->y()Ljava/lang/String;

    move-result-object p1

    invoke-static {p2, p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->G:Lchat/ola/vn/b/o;

    invoke-virtual {p1}, Lchat/ola/vn/b/o;->notifyDataSetChanged()V

    :cond_0
    invoke-direct {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->aa()V

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

    iget-object p2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {p1, p2}, Lchat/ola/vn/message/f;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->G:Lchat/ola/vn/b/o;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->G:Lchat/ola/vn/b/o;

    invoke-virtual {p1}, Lchat/ola/vn/b/o;->notifyDataSetChanged()V

    const/4 p1, 0x0

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->d(Z)V

    :cond_0
    invoke-direct {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->aa()V

    return-void
.end method

.method public a(ZI)V
    .locals 3

    const/4 v0, 0x0

    if-eqz p1, :cond_1

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->ad()V

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
    iput p2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->ai:I

    iput v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->aj:I

    goto :goto_0

    :cond_1
    sget p2, Lchat/ola/vn/activity/OlaChatViewActivity;->g:I

    if-nez p2, :cond_2

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->getResources()Landroid/content/res/Resources;

    move-result-object p2

    const v1, 0x7f07012a

    invoke-virtual {p2, v1}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result p2

    sput p2, Lchat/ola/vn/activity/OlaChatViewActivity;->g:I

    :cond_2
    :goto_0
    invoke-direct {p0, p1}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->j(Z)V

    iget p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->aj:I

    if-nez p1, :cond_3

    invoke-direct {p0, v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->i(Z)V

    :cond_3
    return-void
.end method

.method public a(Lchat/ola/vn/message/d;Landroid/view/View;)Z
    .locals 5

    new-instance p2, Ljava/util/ArrayList;

    invoke-direct {p2}, Ljava/util/ArrayList;-><init>()V

    iget-boolean v0, p1, Lchat/ola/vn/message/d;->w:Z

    if-nez v0, :cond_0

    iget-object v0, p1, Lchat/ola/vn/message/d;->p:Ljava/lang/Long;

    if-eqz v0, :cond_0

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iget-object v2, p1, Lchat/ola/vn/message/d;->p:Ljava/lang/Long;

    invoke-virtual {v2}, Ljava/lang/Long;->longValue()J

    move-result-wide v2

    cmp-long v4, v0, v2

    if-gez v4, :cond_0

    const v0, 0x7f0f05f4

    goto :goto_0

    :cond_0
    iget-boolean v0, p1, Lchat/ola/vn/message/d;->x:Z

    if-nez v0, :cond_1

    const v0, 0x7f0f043d

    :goto_0
    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-interface {p2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_1
    invoke-virtual {p1}, Lchat/ola/vn/message/d;->e()B

    move-result v0

    const/4 v1, 0x1

    if-eq v0, v1, :cond_2

    invoke-virtual {p1}, Lchat/ola/vn/message/d;->e()B

    move-result v0

    if-eqz v0, :cond_2

    invoke-virtual {p1}, Lchat/ola/vn/message/d;->x()Z

    move-result v0

    if-eqz v0, :cond_3

    :cond_2
    const v0, 0x7f0f0491

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-interface {p2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_3
    invoke-virtual {p1}, Lchat/ola/vn/message/d;->e()B

    move-result v0

    if-eq v0, v1, :cond_4

    invoke-virtual {p1}, Lchat/ola/vn/message/d;->e()B

    move-result v0

    if-nez v0, :cond_5

    :cond_4
    const v0, 0x7f0f00fa

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-interface {p2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_5
    const v0, 0x7f0f04a6

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-interface {p2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v0, Lchat/ola/vn/i/m;

    invoke-direct {v0, p0}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    invoke-virtual {v0, p2}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance v2, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$11;

    invoke-direct {v2, p0, p2, p1}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$11;-><init>(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;Ljava/util/List;Lchat/ola/vn/message/d;)V

    invoke-virtual {v0, v2}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {v0}, Lchat/ola/vn/i/m;->show()V

    return v1
.end method

.method public a_()V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->G:Lchat/ola/vn/b/o;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->G:Lchat/ola/vn/b/o;

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

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Lchat/ola/vn/message/p;->e(Ljava/lang/String;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

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

    invoke-direct {p0, v1}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->b(Lchat/ola/vn/message/d;)V

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    new-instance v2, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$18;

    invoke-direct {v2, p0, v1, p1, v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$18;-><init>(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;Lchat/ola/vn/message/p;Ljava/lang/String;Lchat/ola/vn/message/f;)V

    invoke-virtual {v1, v2}, Lchat/ola/vn/message/p;->a(Ljava/lang/Runnable;)V

    invoke-interface {v2}, Ljava/lang/Runnable;->run()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public afterTextChanged(Landroid/text/Editable;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->b(Ljava/lang/CharSequence;)V

    return-void
.end method

.method public b(Lchat/ola/vn/message/f;)V
    .locals 0

    return-void
.end method

.method public b(Lchat/ola/vn/message/f;Lchat/ola/vn/message/d;)V
    .locals 0

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->G:Lchat/ola/vn/b/o;

    invoke-virtual {p1}, Lchat/ola/vn/b/o;->notifyDataSetChanged()V

    return-void
.end method

.method public b(Ljava/lang/Short;I)V
    .locals 0

    return-void
.end method

.method public beforeTextChanged(Ljava/lang/CharSequence;III)V
    .locals 0

    return-void
.end method

.method public c(I)V
    .locals 0

    return-void
.end method

.method public c(Lchat/ola/vn/message/f;)V
    .locals 0

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
    .locals 0

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

    invoke-direct {p0, p1, v1, v1}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->a(Ljava/lang/String;IZ)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    :try_start_1
    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    if-eqz p1, :cond_2

    sget-object p1, Lchat/ola/vn/OlaApplication;->c:Lchat/ola/vn/balloon/OlaBalloonService;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {p1, v0}, Lchat/ola/vn/balloon/OlaBalloonService;->c(Lchat/ola/vn/message/f;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    :cond_2
    return-void
.end method

.method public d(Z)V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    const/4 v1, -0x1

    iput v1, v0, Lchat/ola/vn/message/f;->D:I

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    const/4 v1, 0x0

    iput v1, v0, Lchat/ola/vn/message/f;->E:I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->l:Landroid/widget/ListView;

    new-instance v1, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$2;

    invoke-direct {v1, p0, p1}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$2;-><init>(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;Z)V

    invoke-virtual {v0, v1}, Landroid/widget/ListView;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method public e(Lchat/ola/vn/message/f;)V
    .locals 0

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

.method protected e()Z
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public f(Lchat/ola/vn/message/f;)V
    .locals 0

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

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Lchat/ola/vn/message/p;->e(Ljava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->k()S

    move-result p1

    invoke-virtual {v1, p1}, Lchat/ola/vn/message/p;->c(S)V

    const/4 p1, 0x4

    invoke-virtual {v1, p1}, Lchat/ola/vn/message/p;->b(B)V

    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1, v0}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    invoke-virtual {v1, p1}, Lchat/ola/vn/message/p;->b(Ljava/util/List;)V

    if-eqz v1, :cond_1

    invoke-direct {p0, v1}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->b(Lchat/ola/vn/message/d;)V

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    new-instance v2, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$19;

    invoke-direct {v2, p0, p1, v1, v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$19;-><init>(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;Ljava/util/List;Lchat/ola/vn/message/p;Lchat/ola/vn/message/f;)V

    invoke-virtual {v1, v2}, Lchat/ola/vn/message/p;->a(Ljava/lang/Runnable;)V

    invoke-interface {v2}, Ljava/lang/Runnable;->run()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_2
    :try_start_1
    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    if-eqz p1, :cond_3

    sget-object p1, Lchat/ola/vn/OlaApplication;->c:Lchat/ola/vn/balloon/OlaBalloonService;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {p1, v0}, Lchat/ola/vn/balloon/OlaBalloonService;->c(Lchat/ola/vn/message/f;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    :cond_3
    return-void
.end method

.method public finish()V
    .locals 1

    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->g(Z)V

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

    invoke-direct {p0, p1}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->n(Ljava/lang/String;)V

    return-void
.end method

.method public g(Ljava/lang/String;S)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->k()S

    move-result v0

    if-ne v0, p2, :cond_0

    iget-object p2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {p2}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_0

    invoke-static {p0}, Lchat/ola/vn/m/e;->b(Landroid/content/Context;)V

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->finish()V
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
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

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

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->a_(Ljava/lang/String;)V

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

    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    if-eqz v1, :cond_2

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {v2}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

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

    invoke-direct {p0, v1}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->b(Lchat/ola/vn/message/d;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->k()S

    move-result p1

    if-eqz p1, :cond_1

    if-eq p1, v5, :cond_0

    return-void

    :cond_0
    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v1, v0, p2}, Lchat/ola/vn/network/OlaNetworkService;->b(Ljava/lang/String;[BS)V

    return-void

    :cond_1
    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

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
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;)V"
        }
    .end annotation

    if-eqz p1, :cond_1

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_1

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    :goto_0
    array-length v2, v0

    if-ge v1, v2, :cond_0

    invoke-interface {p1, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/message/f;

    invoke-virtual {v2}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v2

    aput-object v2, v0, v1

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_0
    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v1, v0}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;[Ljava/lang/String;)V

    :cond_1
    return-void
.end method

.method public i(Ljava/lang/String;)V
    .locals 0

    return-void
.end method

.method public i_()Ljava/lang/String;
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->J:Ljava/lang/String;

    if-nez v0, :cond_0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "chat.ola.vn.activity.BalloonChatViewActivity"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->J:Ljava/lang/String;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->J:Ljava/lang/String;

    return-object v0
.end method

.method public j(Ljava/lang/String;)V
    .locals 5

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->k()S

    move-result v0

    const/4 v1, 0x4

    const/4 v2, 0x2

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->k()S

    move-result v0

    if-eq v0, v2, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->k()S

    move-result v0

    if-eq v0, v1, :cond_0

    return-void

    :cond_0
    new-instance v0, Lchat/ola/vn/message/d;

    invoke-direct {v0}, Lchat/ola/vn/message/d;-><init>()V

    new-instance v3, Lchat/ola/vn/message/p;

    invoke-direct {v3, v0, v2}, Lchat/ola/vn/message/p;-><init>(Lchat/ola/vn/message/d;B)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v0}, Lchat/ola/vn/message/p;->e(Ljava/lang/String;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

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

    invoke-direct {p0, v3}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->b(Lchat/ola/vn/message/d;)V

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->k()S

    move-result v0

    if-nez v0, :cond_2

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v3}, Lchat/ola/vn/message/p;->p()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, p1, v2}, Lchat/ola/vn/network/OlaNetworkService;->c(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->k()S

    move-result v0

    if-ne v0, v2, :cond_3

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v3}, Lchat/ola/vn/message/p;->p()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, p1, v2}, Lchat/ola/vn/network/OlaNetworkService;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void

    :cond_3
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->k()S

    move-result v0

    if-ne v0, v1, :cond_4

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

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

    invoke-direct {p0, v0, p1, v1, v4}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->a(Lchat/ola/vn/message/f;Ljava/lang/String;ILjava/lang/String;)V

    invoke-virtual {v3, v2}, Lchat/ola/vn/message/p;->b(B)V

    :cond_4
    return-void
.end method

.method public k(Ljava/lang/String;)V
    .locals 5

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->k()S

    move-result v0

    const/4 v1, 0x4

    const/4 v2, 0x2

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->k()S

    move-result v0

    if-eq v0, v2, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->k()S

    move-result v0

    if-eq v0, v1, :cond_0

    return-void

    :cond_0
    new-instance v0, Lchat/ola/vn/message/d;

    invoke-direct {v0}, Lchat/ola/vn/message/d;-><init>()V

    new-instance v3, Lchat/ola/vn/message/p;

    invoke-direct {v3, v0, v2}, Lchat/ola/vn/message/p;-><init>(Lchat/ola/vn/message/d;B)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v0}, Lchat/ola/vn/message/p;->e(Ljava/lang/String;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

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

    invoke-direct {p0, v3}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->b(Lchat/ola/vn/message/d;)V

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->k()S

    move-result v0

    if-nez v0, :cond_2

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v3}, Lchat/ola/vn/message/p;->p()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, p1, v2}, Lchat/ola/vn/network/OlaNetworkService;->c(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->k()S

    move-result v0

    if-ne v0, v2, :cond_3

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v3}, Lchat/ola/vn/message/p;->p()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, p1, v2}, Lchat/ola/vn/network/OlaNetworkService;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void

    :cond_3
    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->k()S

    move-result v0

    if-ne v0, v1, :cond_4

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

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

    invoke-direct {p0, v0, p1, v1, v4}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->a(Lchat/ola/vn/message/f;Ljava/lang/String;ILjava/lang/String;)V

    invoke-virtual {v3, v2}, Lchat/ola/vn/message/p;->b(B)V

    :cond_4
    return-void
.end method

.method public l(Ljava/lang/String;)V
    .locals 0

    :try_start_0
    invoke-direct {p0, p1}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->m(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onBackPressed()V
    .locals 1

    iget v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->aj:I

    packed-switch v0, :pswitch_data_0

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->finish()V

    return-void

    :pswitch_0
    const/4 v0, 0x0

    iput v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->aj:I

    invoke-direct {p0, v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->j(Z)V

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
    .locals 5

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const/4 v0, 0x2

    const/4 v1, 0x3

    const/4 v2, 0x4

    const/4 v3, 0x1

    packed-switch p1, :pswitch_data_0

    const/4 v4, 0x0

    sparse-switch p1, :sswitch_data_0

    return-void

    :sswitch_0
    invoke-direct {p0, v4}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->h(Z)V

    const/4 p1, 0x5

    iput p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->aj:I

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->k:Lcom/mg/ola/common/widget/SoftKeyLinearLayout;

    invoke-virtual {p1}, Lcom/mg/ola/common/widget/SoftKeyLinearLayout;->a()Z

    move-result p1

    if-nez p1, :cond_8

    :goto_0
    invoke-direct {p0, v4}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->j(Z)V

    return-void

    :sswitch_1
    iput-boolean v3, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->al:Z

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->m:Landroid/widget/EditText;

    invoke-virtual {p1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1, v4, v3}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->a(Ljava/lang/String;IZ)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    const p1, 0x7f01001d

    :try_start_1
    invoke-static {p0, p1}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object p1

    const-wide/16 v0, 0xc8

    invoke-virtual {p1, v0, v1}, Landroid/view/animation/Animation;->setDuration(J)V

    new-instance v0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$8;

    invoke-direct {v0, p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$8;-><init>(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;)V

    invoke-virtual {p1, v0}, Landroid/view/animation/Animation;->setAnimationListener(Landroid/view/animation/Animation$AnimationListener;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->Q:Landroid/widget/Button;

    invoke-virtual {v0, p1}, Landroid/widget/Button;->startAnimation(Landroid/view/animation/Animation;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    return-void

    :sswitch_2
    :try_start_2
    invoke-direct {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->ak()Z

    return-void

    :sswitch_3
    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->m:Landroid/widget/EditText;

    invoke-virtual {p1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    invoke-direct {p0, p1, v4, v3}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->a(Ljava/lang/String;IZ)V

    return-void

    :cond_0
    invoke-direct {p0, v4}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->h(Z)V

    const/4 p1, 0x6

    iput p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->aj:I

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->k:Lcom/mg/ola/common/widget/SoftKeyLinearLayout;

    invoke-virtual {p1}, Lcom/mg/ola/common/widget/SoftKeyLinearLayout;->a()Z

    move-result p1

    if-nez p1, :cond_8

    goto :goto_0

    :sswitch_4
    invoke-direct {p0, v4}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->h(Z)V

    iput v2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->aj:I

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->k:Lcom/mg/ola/common/widget/SoftKeyLinearLayout;

    invoke-virtual {p1}, Lcom/mg/ola/common/widget/SoftKeyLinearLayout;->a()Z

    move-result p1

    if-nez p1, :cond_8

    goto :goto_0

    :sswitch_5
    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    if-eqz p1, :cond_8

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-static {p0, p1, v0}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Landroid/content/Context;Lchat/ola/vn/network/OlaNetworkService;Lchat/ola/vn/message/f;)V

    invoke-direct {p0, v4}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->g(Z)V

    return-void

    :sswitch_6
    const-string p1, "(y)"

    invoke-direct {p0, p1, v4, v4}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->a(Ljava/lang/String;IZ)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    const p1, 0x7f010057

    :try_start_3
    invoke-static {p0, p1}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object p1

    const-wide/16 v0, 0x96

    invoke-virtual {p1, v0, v1}, Landroid/view/animation/Animation;->setDuration(J)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->R:Landroid/widget/ImageButton;

    invoke-virtual {v0, p1}, Landroid/widget/ImageButton;->startAnimation(Landroid/view/animation/Animation;)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_1

    return-void

    :sswitch_7
    :try_start_4
    invoke-direct {p0, v4}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->h(Z)V

    iput v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->aj:I

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->k:Lcom/mg/ola/common/widget/SoftKeyLinearLayout;

    invoke-virtual {p1}, Lcom/mg/ola/common/widget/SoftKeyLinearLayout;->a()Z

    move-result p1

    if-nez p1, :cond_8

    goto/16 :goto_0

    :sswitch_8
    invoke-direct {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->T()I

    move-result p1

    if-nez p1, :cond_1

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->finish()V

    return-void

    :cond_1
    invoke-direct {p0, v4}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->d(I)V

    return-void

    :sswitch_9
    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->finish()V

    return-void

    :sswitch_a
    iget p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->aj:I

    if-nez p1, :cond_2

    invoke-direct {p0, v4}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->h(Z)V

    iput v3, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->aj:I

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->k:Lcom/mg/ola/common/widget/SoftKeyLinearLayout;

    invoke-virtual {p1}, Lcom/mg/ola/common/widget/SoftKeyLinearLayout;->a()Z

    move-result p1

    if-nez p1, :cond_8

    goto/16 :goto_0

    :cond_2
    invoke-direct {p0, v3}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->h(Z)V

    iput v4, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->aj:I

    return-void

    :sswitch_b
    invoke-static {}, Lcom/mg/ola/common/d/g;->f()Z

    move-result p1

    if-eqz p1, :cond_3

    invoke-direct {p0, v4}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->h(Z)V

    iput v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->aj:I

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->k:Lcom/mg/ola/common/widget/SoftKeyLinearLayout;

    invoke-virtual {p1}, Lcom/mg/ola/common/widget/SoftKeyLinearLayout;->a()Z

    move-result p1

    if-nez p1, :cond_8

    goto/16 :goto_0

    :cond_3
    const p1, 0x7f0f036b

    invoke-static {p0, p1}, Lchat/ola/vn/util/j;->d(Landroid/content/Context;I)V

    return-void

    :pswitch_0
    invoke-direct {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->T()I

    move-result p1

    if-ne p1, v2, :cond_4

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->finish()V

    return-void

    :cond_4
    invoke-direct {p0, v2}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->d(I)V

    return-void

    :pswitch_1
    invoke-direct {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->T()I

    move-result p1

    if-ne p1, v1, :cond_5

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->finish()V

    return-void

    :cond_5
    invoke-direct {p0, v1}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->d(I)V

    return-void

    :pswitch_2
    invoke-direct {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->T()I

    move-result p1

    if-ne p1, v0, :cond_6

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->finish()V

    return-void

    :cond_6
    invoke-direct {p0, v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->d(I)V

    return-void

    :pswitch_3
    invoke-direct {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->T()I

    move-result p1

    if-ne p1, v3, :cond_7

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->finish()V

    return-void

    :cond_7
    invoke-direct {p0, v3}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->d(I)V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :catch_1
    :cond_8
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x7f0901c3
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch

    :sswitch_data_0
    .sparse-switch
        0x7f090143 -> :sswitch_b
        0x7f09015c -> :sswitch_a
        0x7f09015e -> :sswitch_9
        0x7f0901c8 -> :sswitch_8
        0x7f0902c8 -> :sswitch_7
        0x7f0902d3 -> :sswitch_6
        0x7f0902da -> :sswitch_5
        0x7f090310 -> :sswitch_4
        0x7f090360 -> :sswitch_3
        0x7f0903fb -> :sswitch_2
        0x7f090466 -> :sswitch_1
        0x7f090600 -> :sswitch_0
    .end sparse-switch
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 3
    .annotation build Landroid/annotation/TargetApi;
        value = 0xe
    .end annotation

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->getWindow()Landroid/view/Window;

    move-result-object p1

    invoke-static {}, Lcom/mg/ola/common/d/g;->f()Z

    move-result v0

    if-eqz v0, :cond_0

    const/high16 v0, 0x3f000000    # 0.5f

    invoke-virtual {p1, v0}, Landroid/view/Window;->setDimAmount(F)V

    :cond_0
    const/4 v0, 0x2

    invoke-virtual {p1, v0}, Landroid/view/Window;->addFlags(I)V

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/view/Window;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    sget-object p1, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->N:Landroid/view/animation/Animation;

    const-wide/16 v1, 0x64

    if-nez p1, :cond_1

    const p1, 0x7f01004b

    invoke-static {p0, p1}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object p1

    sput-object p1, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->N:Landroid/view/animation/Animation;

    sget-object p1, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->N:Landroid/view/animation/Animation;

    invoke-virtual {p1, v1, v2}, Landroid/view/animation/Animation;->setDuration(J)V

    :cond_1
    sget-object p1, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->O:Landroid/view/animation/Animation;

    if-nez p1, :cond_2

    const p1, 0x7f01004f

    invoke-static {p0, p1}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object p1

    sput-object p1, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->O:Landroid/view/animation/Animation;

    sget-object p1, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->O:Landroid/view/animation/Animation;

    invoke-virtual {p1, v1, v2}, Landroid/view/animation/Animation;->setDuration(J)V

    :cond_2
    invoke-direct {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->R()V

    new-instance p1, Lchat/ola/vn/b/r;

    invoke-direct {p1, p0}, Lchat/ola/vn/b/r;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->H:Lchat/ola/vn/b/r;

    new-instance p1, Lchat/ola/vn/b/o;

    invoke-direct {p1, p0, v0}, Lchat/ola/vn/b/o;-><init>(Landroid/content/Context;Lchat/ola/vn/message/f;)V

    iput-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->G:Lchat/ola/vn/b/o;

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->G:Lchat/ola/vn/b/o;

    new-instance v0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$1;

    invoke-direct {v0, p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$1;-><init>(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;)V

    invoke-virtual {p1, v0}, Lchat/ola/vn/b/o;->a(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->l:Landroid/widget/ListView;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->G:Lchat/ola/vn/b/o;

    invoke-virtual {p1, v0}, Landroid/widget/ListView;->setAdapter(Landroid/widget/ListAdapter;)V

    return-void
.end method

.method public onItemClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)V
    .locals 4
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
    invoke-direct {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->T()I

    move-result p1

    if-nez p1, :cond_6

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->H:Lchat/ola/vn/b/r;

    invoke-virtual {p1, p3}, Lchat/ola/vn/b/r;->a(I)Lchat/ola/vn/message/f;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->k()S

    move-result p2

    const/4 p3, 0x5

    if-ne p2, p3, :cond_0

    move-object p2, p1

    check-cast p2, Lchat/ola/vn/message/u;

    invoke-virtual {p2, p0}, Lchat/ola/vn/message/u;->a(Landroid/content/Context;)Z

    move-result p2

    if-eqz p2, :cond_6

    sget-object p2, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {p2, p1}, Lchat/ola/vn/message/g;->b(Lchat/ola/vn/message/f;)Lchat/ola/vn/message/f;

    return-void

    :cond_0
    invoke-virtual {p1}, Lchat/ola/vn/message/f;->k()S

    move-result p2

    const/4 p3, 0x6

    if-ne p2, p3, :cond_1

    return-void

    :cond_1
    invoke-virtual {p1}, Lchat/ola/vn/message/f;->k()S

    move-result p2

    const/4 p3, 0x7

    if-ne p2, p3, :cond_2

    invoke-static {p0}, Lchat/ola/vn/message/OlaOtherPeopleListActivity;->a(Landroid/content/Context;)V

    return-void

    :cond_2
    sget-object p2, Lchat/ola/vn/OlaApplication;->c:Lchat/ola/vn/balloon/OlaBalloonService;

    invoke-virtual {p2}, Lchat/ola/vn/balloon/OlaBalloonService;->f()Ljava/util/List;

    move-result-object p2

    if-eqz p2, :cond_6

    invoke-interface {p2}, Ljava/util/List;->size()I

    move-result p3

    if-lez p3, :cond_6

    invoke-interface {p2}, Ljava/util/List;->size()I

    move-result p3

    const/4 p4, 0x0

    const/4 p5, 0x0

    :goto_0
    const/4 v0, 0x4

    const/4 v1, 0x1

    if-ge p5, v0, :cond_4

    if-ge p5, p3, :cond_4

    invoke-interface {p2, p5}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/balloon/e;

    iget-object v0, v0, Lchat/ola/vn/balloon/e;->s:Lchat/ola/vn/message/f;

    invoke-virtual {p1, v0}, Lchat/ola/vn/message/f;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_3

    add-int/2addr p5, v1

    invoke-direct {p0, p5}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->d(I)V

    return-void

    :cond_3
    add-int/lit8 p5, p5, 0x1

    goto :goto_0

    :cond_4
    if-lt p3, v0, :cond_5

    sub-int/2addr p3, v1

    invoke-interface {p2, p3}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    :cond_5
    new-instance p3, Lchat/ola/vn/balloon/e;

    sget-object p5, Lchat/ola/vn/OlaApplication;->c:Lchat/ola/vn/balloon/OlaBalloonService;

    invoke-direct {p3, p5}, Lchat/ola/vn/balloon/e;-><init>(Lchat/ola/vn/balloon/OlaBalloonService;)V

    sget-object p5, Lchat/ola/vn/OlaApplication;->c:Lchat/ola/vn/balloon/OlaBalloonService;

    iget-object p5, p5, Lchat/ola/vn/balloon/OlaBalloonService;->a:Lchat/ola/vn/balloon/d;

    invoke-virtual {p3, p5}, Lchat/ola/vn/balloon/e;->setBalloonTerminator(Lchat/ola/vn/balloon/d;)V

    iget-object p5, p3, Lchat/ola/vn/balloon/e;->b:Landroid/view/WindowManager$LayoutParams;

    invoke-virtual {p3}, Lchat/ola/vn/balloon/e;->getWindowWidth()I

    move-result v0

    invoke-virtual {p3}, Lchat/ola/vn/balloon/e;->getBalloonWidth()I

    move-result v2

    sub-int/2addr v0, v2

    iput v0, p5, Landroid/view/WindowManager$LayoutParams;->x:I

    new-instance p5, Ljava/util/Random;

    invoke-direct {p5}, Ljava/util/Random;-><init>()V

    const/16 v0, 0x3c

    invoke-virtual {p5, v0}, Ljava/util/Random;->nextInt(I)I

    move-result p5

    add-int/lit8 p5, p5, -0x1e

    iget-object v0, p3, Lchat/ola/vn/balloon/e;->b:Landroid/view/WindowManager$LayoutParams;

    invoke-virtual {p3}, Lchat/ola/vn/balloon/e;->getWindowHeight()I

    move-result v2

    div-int/lit8 v2, v2, 0x3

    invoke-virtual {p3}, Lchat/ola/vn/balloon/e;->getBalloonHeight()I

    move-result v3

    div-int/lit8 v3, v3, 0x2

    add-int/2addr v3, p5

    sub-int/2addr v2, v3

    iput v2, v0, Landroid/view/WindowManager$LayoutParams;->y:I

    iget-object p5, p3, Lchat/ola/vn/balloon/e;->b:Landroid/view/WindowManager$LayoutParams;

    iget p5, p5, Landroid/view/WindowManager$LayoutParams;->x:I

    invoke-virtual {p3, p5}, Lchat/ola/vn/balloon/e;->setBackupX(I)V

    iget-object p5, p3, Lchat/ola/vn/balloon/e;->b:Landroid/view/WindowManager$LayoutParams;

    iget p5, p5, Landroid/view/WindowManager$LayoutParams;->y:I

    invoke-virtual {p3, p5}, Lchat/ola/vn/balloon/e;->setBackupY(I)V

    invoke-virtual {p3, p4}, Lchat/ola/vn/balloon/e;->setVisibility(I)V

    const/4 p5, 0x0

    invoke-virtual {p1, p5}, Lchat/ola/vn/message/f;->a(Ljava/lang/Long;)V

    invoke-virtual {p3, p1}, Lchat/ola/vn/balloon/e;->setContact(Lchat/ola/vn/message/f;)V

    invoke-interface {p2, p4, p3}, Ljava/util/List;->add(ILjava/lang/Object;)V

    invoke-direct {p0, v1}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->d(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_6
    return-void
.end method

.method public onItemLongClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)Z
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/widget/AdapterView<",
            "*>;",
            "Landroid/view/View;",
            "IJ)Z"
        }
    .end annotation

    :try_start_0
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    if-eqz p1, :cond_0

    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    instance-of p1, p1, Lchat/ola/vn/entry/b/b;

    if-eqz p1, :cond_0

    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entry/b/b;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->l:Landroid/widget/ListView;

    invoke-virtual {p2, p3}, Landroid/widget/ListView;->getItemAtPosition(I)Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Lchat/ola/vn/message/d;

    invoke-virtual {p1}, Lchat/ola/vn/entry/b/b;->b()Landroid/view/View;

    move-result-object p1

    invoke-virtual {p0, p2, p1}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->a(Lchat/ola/vn/message/d;Landroid/view/View;)Z

    move-result p1

    return p1

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->l:Landroid/widget/ListView;

    invoke-virtual {p1, p3}, Landroid/widget/ListView;->getItemAtPosition(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/message/d;

    invoke-virtual {p0, p1, p2}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->a(Lchat/ola/vn/message/d;Landroid/view/View;)Z

    move-result p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return p1

    :catch_0
    const/4 p1, 0x0

    return p1
.end method

.method public onLongClick(Landroid/view/View;)Z
    .locals 5

    const/4 v0, 0x0

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const v1, 0x7f090143

    const/4 v2, 0x1

    if-eq p1, v1, :cond_1

    const v1, 0x7f0902d3

    if-eq p1, v1, :cond_0

    return v0

    :cond_0
    const-string p1, "(Y)"

    invoke-direct {p0, p1, v0, v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->a(Ljava/lang/String;IZ)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    const p1, 0x7f010057

    :try_start_1
    invoke-static {p0, p1}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object p1

    const-wide/16 v3, 0x96

    invoke-virtual {p1, v3, v4}, Landroid/view/animation/Animation;->setDuration(J)V

    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->R:Landroid/widget/ImageButton;

    invoke-virtual {v1, p1}, Landroid/widget/ImageButton;->startAnimation(Landroid/view/animation/Animation;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    return v2

    :cond_1
    :try_start_2
    invoke-direct {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->ah()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    return v2

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :catch_1
    return v0
.end method

.method public onMessageItemButtonClick(Landroid/view/View;)V
    .locals 5

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v1

    const/4 v2, 0x0

    sparse-switch v1, :sswitch_data_0

    return-void

    :sswitch_0
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/message/d;

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->a(Lchat/ola/vn/message/d;)V

    return-void

    :sswitch_1
    check-cast v0, Lchat/ola/vn/message/d;

    move-object p1, v0

    check-cast p1, Lchat/ola/vn/message/k;

    invoke-virtual {v0}, Lchat/ola/vn/message/d;->d()B

    move-result v1

    const/4 v3, 0x1

    if-ne v1, v3, :cond_0

    invoke-virtual {v0}, Lchat/ola/vn/message/d;->i()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_0
    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v0

    :goto_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "geo:"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Lchat/ola/vn/message/k;->C()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v3, ","

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Lchat/ola/vn/message/k;->a()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v3, "?q="

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Lchat/ola/vn/message/k;->C()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v3, ","

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Lchat/ola/vn/message/k;->a()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, "(@"

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, ")"

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.intent.action.VIEW"

    invoke-static {p1}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object p1

    invoke-direct {v0, v1, p1}, Landroid/content/Intent;-><init>(Ljava/lang/String;Landroid/net/Uri;)V

    invoke-virtual {p0, v0, v2}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->startActivityForResult(Landroid/content/Intent;I)V

    return-void

    :sswitch_2
    check-cast v0, Lchat/ola/vn/message/d;

    invoke-virtual {v0}, Lchat/ola/vn/message/d;->v()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_1

    invoke-virtual {v0}, Lchat/ola/vn/message/d;->c()Ljava/lang/String;

    move-result-object p1

    invoke-static {p0, p1}, Lchat/ola/vn/util/b;->a(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :cond_1
    invoke-virtual {v0}, Lchat/ola/vn/message/d;->c()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_2

    invoke-virtual {v0}, Lchat/ola/vn/message/d;->c()Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, v0, p1}, Lchat/ola/vn/util/b;->a(Landroid/content/Context;Ljava/lang/String;Landroid/view/View;)V

    return-void

    :sswitch_3
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/message/d;

    if-eqz p1, :cond_2

    invoke-virtual {p1}, Lchat/ola/vn/message/d;->i()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->j(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0, p1}, Lchat/ola/vn/network/OlaNetworkService;->d(Ljava/lang/String;)V

    return-void

    :sswitch_4
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/message/d;

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    iget-object v3, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {v3}, Lchat/ola/vn/message/f;->k()S

    move-result v3

    invoke-virtual {p1}, Lchat/ola/vn/message/d;->p()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v0, v1, v3, v4}, Lchat/ola/vn/network/OlaNetworkService;->d(Ljava/lang/String;SLjava/lang/String;)V

    iput-boolean v2, p1, Lchat/ola/vn/message/d;->x:Z

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->G:Lchat/ola/vn/b/o;

    invoke-virtual {p1}, Lchat/ola/vn/b/o;->notifyDataSetChanged()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_2
    return-void

    :sswitch_data_0
    .sparse-switch
        0x7f090092 -> :sswitch_4
        0x7f0900df -> :sswitch_3
        0x7f090295 -> :sswitch_2
        0x7f09033e -> :sswitch_2
        0x7f090354 -> :sswitch_1
        0x7f090355 -> :sswitch_0
    .end sparse-switch
.end method

.method protected onPause()V
    .locals 1

    invoke-super {p0}, Lchat/ola/vn/c;->onPause()V

    :try_start_0
    iget-boolean v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->P:Z

    invoke-direct {p0, v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->f(Z)V

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v0, p0}, Lchat/ola/vn/message/g;->b(Lchat/ola/vn/p/f;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onRequestPermissionsResult(I[Ljava/lang/String;[I)V
    .locals 1

    const/4 p2, 0x0

    const/16 v0, 0x67

    if-ne p1, v0, :cond_0

    aget p1, p3, p2

    if-nez p1, :cond_1

    invoke-direct {p0, p2}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->h(Z)V

    const/4 p1, 0x4

    iput p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->aj:I

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->k:Lcom/mg/ola/common/widget/SoftKeyLinearLayout;

    invoke-virtual {p1}, Lcom/mg/ola/common/widget/SoftKeyLinearLayout;->a()Z

    move-result p1

    if-nez p1, :cond_1

    invoke-direct {p0, p2}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->j(Z)V

    return-void

    :cond_0
    const/16 v0, 0x65

    if-ne p1, v0, :cond_1

    aget p1, p3, p2

    if-nez p1, :cond_1

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->aj()V

    :cond_1
    return-void
.end method

.method protected onRestoreInstanceState(Landroid/os/Bundle;)V
    .locals 3

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onRestoreInstanceState(Landroid/os/Bundle;)V

    if-eqz p1, :cond_0

    const-string v0, "_conv_id"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "_conv_type"

    invoke-virtual {p1, v1}, Landroid/os/Bundle;->getShort(Ljava/lang/String;)S

    move-result p1

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    sget-object v1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    const/4 v2, 0x1

    invoke-virtual {v1, v0, p1, v2}, Lchat/ola/vn/message/g;->b(Ljava/lang/String;SZ)Lchat/ola/vn/message/f;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    sget-object p1, Lchat/ola/vn/OlaApplication;->c:Lchat/ola/vn/balloon/OlaBalloonService;

    invoke-virtual {p1}, Lchat/ola/vn/balloon/OlaBalloonService;->f()Ljava/util/List;

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->a(Lchat/ola/vn/message/f;)V

    :cond_0
    return-void
.end method

.method protected onSaveInstanceState(Landroid/os/Bundle;)V
    .locals 2

    if-eqz p1, :cond_0

    :try_start_0
    const-string v0, "_conv_id"

    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "_conv_type"

    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->k()S

    move-result v1

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putShort(Ljava/lang/String;S)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    invoke-super {p0, p1}, Lchat/ola/vn/c;->onSaveInstanceState(Landroid/os/Bundle;)V

    return-void
.end method

.method public onScroll(Landroid/widget/AbsListView;III)V
    .locals 2

    :try_start_0
    invoke-direct {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->T()I

    move-result v0

    const/4 v1, 0x0

    if-nez v0, :cond_1

    invoke-virtual {p1, v1}, Landroid/widget/AbsListView;->getChildAt(I)Landroid/view/View;

    move-result-object p1

    if-nez p1, :cond_0

    goto :goto_0

    :cond_0
    invoke-virtual {p1}, Landroid/view/View;->getTop()I

    move-result v1

    :goto_0
    sput v1, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->i:I

    sput p2, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->j:I

    return-void

    :cond_1
    if-lez v0, :cond_4

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    if-eqz v0, :cond_4

    add-int/2addr p3, p2

    if-lt p3, p4, :cond_2

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    const/4 p2, -0x1

    iput p2, p1, Lchat/ola/vn/message/f;->D:I

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    iput p2, p1, Lchat/ola/vn/message/f;->E:I

    return-void

    :cond_2
    iget-object p3, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    iput p2, p3, Lchat/ola/vn/message/f;->D:I

    invoke-virtual {p1, v1}, Landroid/widget/AbsListView;->getChildAt(I)Landroid/view/View;

    move-result-object p1

    iget-object p2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    if-nez p1, :cond_3

    goto :goto_1

    :cond_3
    invoke-virtual {p1}, Landroid/view/View;->getTop()I

    move-result v1

    :goto_1
    iput v1, p2, Lchat/ola/vn/message/f;->E:I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_4
    return-void
.end method

.method public onScrollStateChanged(Landroid/widget/AbsListView;I)V
    .locals 3

    if-eqz p2, :cond_0

    return-void

    :cond_0
    :try_start_0
    invoke-direct {p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->T()I

    move-result p1

    if-gtz p1, :cond_1

    return-void

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->l:Landroid/widget/ListView;

    const/4 p2, 0x0

    invoke-virtual {p1, p2}, Landroid/widget/ListView;->getChildAt(I)Landroid/view/View;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    if-nez p1, :cond_2

    goto :goto_0

    :cond_2
    invoke-virtual {p1}, Landroid/view/View;->getTop()I

    move-result p2

    :goto_0
    iput p2, v0, Lchat/ola/vn/message/f;->E:I

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    iget p1, p1, Lchat/ola/vn/message/f;->D:I

    const/4 p2, 0x2

    const/4 v0, 0x1

    if-ltz p1, :cond_3

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->l:Landroid/widget/ListView;

    invoke-virtual {p1, v0}, Landroid/widget/ListView;->setTranscriptMode(I)V

    goto :goto_1

    :cond_3
    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->l:Landroid/widget/ListView;

    invoke-virtual {p1, p2}, Landroid/widget/ListView;->setTranscriptMode(I)V

    :goto_1
    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->l:Landroid/widget/ListView;

    invoke-virtual {p1}, Landroid/widget/ListView;->getFirstVisiblePosition()I

    move-result p1

    if-gt p1, p2, :cond_5

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    iget-boolean p1, p1, Lchat/ola/vn/message/f;->Q:Z

    if-eqz p1, :cond_5

    invoke-static {}, Lchat/ola/vn/h;->g()Z

    move-result p1

    if-eqz p1, :cond_5

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->T()Ljava/lang/String;

    move-result-object p1

    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->k()S

    move-result v1

    if-ne v1, p2, :cond_4

    iget-object p2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    iget-object p2, p2, Lchat/ola/vn/message/f;->O:Ljava/lang/String;

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-nez p2, :cond_5

    sget-object p2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$9;

    invoke-direct {v2, p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$9;-><init>(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;)V

    invoke-static {v2}, Lchat/ola/vn/entry/c/f;->a(Lchat/ola/vn/entry/c/e;)S

    move-result v2

    invoke-virtual {p2, v1, p1, v2}, Lchat/ola/vn/network/OlaNetworkService;->h(Ljava/lang/String;Ljava/lang/String;S)Z

    move-result p2

    if-eqz p2, :cond_5

    iget-object p2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    iput-object p1, p2, Lchat/ola/vn/message/f;->O:Ljava/lang/String;

    :goto_2
    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    iput-boolean v0, p1, Lchat/ola/vn/message/f;->Q:Z

    return-void

    :cond_4
    const-string p2, "null"

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-nez p2, :cond_5

    iget-object p2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    iget-object p2, p2, Lchat/ola/vn/message/f;->O:Ljava/lang/String;

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-nez p2, :cond_5

    sget-object p2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$10;

    invoke-direct {v2, p0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity$10;-><init>(Lchat/ola/vn/activity/OlaBalloonChatViewActivity;)V

    invoke-static {v2}, Lchat/ola/vn/entry/c/f;->a(Lchat/ola/vn/entry/c/e;)S

    move-result v2

    invoke-virtual {p2, v1, p1, v2}, Lchat/ola/vn/network/OlaNetworkService;->i(Ljava/lang/String;Ljava/lang/String;S)Z

    move-result p2

    if-eqz p2, :cond_5

    iget-object p2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    iput-object p1, p2, Lchat/ola/vn/message/f;->O:Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_2

    :catch_0
    :cond_5
    return-void
.end method

.method public onTextChanged(Ljava/lang/CharSequence;III)V
    .locals 2

    if-lez p4, :cond_1

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    if-eqz p1, :cond_1

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz p1, :cond_1

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide p1

    iget-wide p3, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->I:J

    sub-long v0, p1, p3

    const-wide/16 p1, 0x5dc

    cmp-long p3, v0, p1

    if-ltz p3, :cond_1

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide p1

    iput-wide p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->I:J

    iget-object p1, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->k()S

    move-result p1

    const/4 p2, 0x2

    if-ne p1, p2, :cond_0

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {p2}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Lchat/ola/vn/network/OlaNetworkService;->f(Ljava/lang/String;)V

    return-void

    :cond_0
    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->F:Lchat/ola/vn/message/f;

    invoke-virtual {p2}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Lchat/ola/vn/network/OlaNetworkService;->g(Ljava/lang/String;)V

    :cond_1
    return-void
.end method

.method public onTouch(Landroid/view/View;Landroid/view/MotionEvent;)Z
    .locals 1
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "ClickableViewAccessibility"
        }
    .end annotation

    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const p2, 0x7f090313

    const/4 v0, 0x0

    if-eq p1, p2, :cond_1

    const p2, 0x7f090564

    if-eq p1, p2, :cond_0

    return v0

    :cond_0
    const/4 p1, 0x1

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->d(Z)V

    return v0

    :cond_1
    invoke-direct {p0, v0}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->h(Z)V

    return v0
.end method

.method public z()Landroid/widget/FrameLayout;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->h:Landroid/widget/FrameLayout;

    return-object v0
.end method
