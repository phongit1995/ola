.class public Lchat/ola/vn/view/OlaTypingSuggestedText;
.super Lcom/mg/ola/common/widget/d;


# instance fields
.field private a:C

.field private b:C

.field private c:I

.field private d:I

.field private e:Lcom/mg/ola/common/widget/b;

.field private f:Landroid/widget/BaseAdapter;

.field private g:Z

.field private h:Lchat/ola/vn/view/OlaQuickTypingSuggestedText$b;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1

    invoke-direct {p0, p1}, Lcom/mg/ola/common/widget/d;-><init>(Landroid/content/Context;)V

    const/16 v0, 0x40

    iput-char v0, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->a:C

    const/16 v0, 0x23

    iput-char v0, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->b:C

    const/4 v0, -0x1

    iput v0, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->c:I

    const/4 v0, 0x0

    iput v0, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->d:I

    const/4 v0, 0x1

    iput-boolean v0, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->g:Z

    invoke-direct {p0, p1}, Lchat/ola/vn/view/OlaTypingSuggestedText;->a(Landroid/content/Context;)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lcom/mg/ola/common/widget/d;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    const/16 p2, 0x40

    iput-char p2, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->a:C

    const/16 p2, 0x23

    iput-char p2, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->b:C

    const/4 p2, -0x1

    iput p2, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->c:I

    const/4 p2, 0x0

    iput p2, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->d:I

    const/4 p2, 0x1

    iput-boolean p2, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->g:Z

    invoke-direct {p0, p1}, Lchat/ola/vn/view/OlaTypingSuggestedText;->a(Landroid/content/Context;)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Lcom/mg/ola/common/widget/d;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    const/16 p2, 0x40

    iput-char p2, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->a:C

    const/16 p2, 0x23

    iput-char p2, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->b:C

    const/4 p2, -0x1

    iput p2, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->c:I

    const/4 p2, 0x0

    iput p2, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->d:I

    const/4 p2, 0x1

    iput-boolean p2, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->g:Z

    invoke-direct {p0, p1}, Lchat/ola/vn/view/OlaTypingSuggestedText;->a(Landroid/content/Context;)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/view/OlaTypingSuggestedText;)I
    .locals 0

    iget p0, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->c:I

    return p0
.end method

.method static synthetic a(Lchat/ola/vn/view/OlaTypingSuggestedText;I)I
    .locals 0

    iput p1, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->c:I

    return p1
.end method

.method private a()V
    .locals 1

    iget-boolean v0, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->g:Z

    if-eqz v0, :cond_0

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->e:Lcom/mg/ola/common/widget/b;

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/b;->f()Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->e:Lcom/mg/ola/common/widget/b;

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/b;->a()Landroid/widget/ListAdapter;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->e:Lcom/mg/ola/common/widget/b;

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/b;->b()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method private a(Landroid/content/Context;)V
    .locals 4

    new-instance v0, Lcom/mg/ola/common/widget/b;

    invoke-direct {v0, p1}, Lcom/mg/ola/common/widget/b;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->e:Lcom/mg/ola/common/widget/b;

    iget-object p1, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->e:Lcom/mg/ola/common/widget/b;

    const/4 v0, 0x1

    invoke-virtual {p1, v0}, Lcom/mg/ola/common/widget/b;->i(I)V

    iget-object p1, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->e:Lcom/mg/ola/common/widget/b;

    const/4 v1, 0x0

    invoke-virtual {p1, v1}, Lcom/mg/ola/common/widget/b;->b(I)V

    iget-object p1, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->e:Lcom/mg/ola/common/widget/b;

    const/16 v2, 0x10

    invoke-virtual {p1, v2}, Lcom/mg/ola/common/widget/b;->c(I)V

    iget-object p1, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->e:Lcom/mg/ola/common/widget/b;

    invoke-virtual {p1, p0}, Lcom/mg/ola/common/widget/b;->a(Landroid/view/View;)V

    iget-object p1, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->e:Lcom/mg/ola/common/widget/b;

    invoke-virtual {p1, v0}, Lcom/mg/ola/common/widget/b;->d(Z)V

    iget-object p1, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->e:Lcom/mg/ola/common/widget/b;

    new-instance v2, Landroid/graphics/drawable/ColorDrawable;

    sget v3, Lchat/ola/vn/f;->w:I

    invoke-direct {v2, v3}, Landroid/graphics/drawable/ColorDrawable;-><init>(I)V

    invoke-virtual {p1, v2}, Lcom/mg/ola/common/widget/b;->a(Landroid/graphics/drawable/Drawable;)V

    iget-object p1, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->e:Lcom/mg/ola/common/widget/b;

    invoke-virtual {p1, v0}, Lcom/mg/ola/common/widget/b;->g(I)V

    iget-object p1, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->e:Lcom/mg/ola/common/widget/b;

    invoke-virtual {p1, v1}, Lcom/mg/ola/common/widget/b;->b(Z)V

    iget-object p1, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->e:Lcom/mg/ola/common/widget/b;

    const v0, 0x7f08005e

    invoke-virtual {p1, v0}, Lcom/mg/ola/common/widget/b;->d(I)V

    iget-object p1, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->e:Lcom/mg/ola/common/widget/b;

    invoke-virtual {p1, v1}, Lcom/mg/ola/common/widget/b;->a(Z)V

    iget-object p1, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->e:Lcom/mg/ola/common/widget/b;

    const/4 v0, 0x5

    invoke-virtual {p1, v0}, Lcom/mg/ola/common/widget/b;->a(I)V

    iget-object p1, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->e:Lcom/mg/ola/common/widget/b;

    new-instance v0, Lchat/ola/vn/view/OlaTypingSuggestedText$1;

    invoke-direct {v0, p0}, Lchat/ola/vn/view/OlaTypingSuggestedText$1;-><init>(Lchat/ola/vn/view/OlaTypingSuggestedText;)V

    invoke-virtual {p1, v0}, Lcom/mg/ola/common/widget/b;->a(Landroid/widget/PopupWindow$OnDismissListener;)V

    iget-object p1, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->e:Lcom/mg/ola/common/widget/b;

    new-instance v0, Lchat/ola/vn/view/OlaTypingSuggestedText$2;

    invoke-direct {v0, p0}, Lchat/ola/vn/view/OlaTypingSuggestedText$2;-><init>(Lchat/ola/vn/view/OlaTypingSuggestedText;)V

    invoke-virtual {p1, v0}, Lcom/mg/ola/common/widget/b;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    return-void
.end method

.method private a(Ljava/lang/CharSequence;)V
    .locals 2

    iget v0, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->c:I

    invoke-virtual {p0, v0}, Lchat/ola/vn/view/OlaTypingSuggestedText;->a(I)I

    move-result v0

    invoke-direct {p0, v0}, Lchat/ola/vn/view/OlaTypingSuggestedText;->b(I)V

    invoke-direct {p0}, Lchat/ola/vn/view/OlaTypingSuggestedText;->a()V

    iget v0, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->c:I

    iget v1, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->d:I

    invoke-virtual {p0, p1, v0, v1}, Lchat/ola/vn/view/OlaTypingSuggestedText;->a(Ljava/lang/CharSequence;II)V

    return-void
.end method

.method static synthetic b(Lchat/ola/vn/view/OlaTypingSuggestedText;)I
    .locals 0

    iget p0, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->d:I

    return p0
.end method

.method private b(I)V
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->e:Lcom/mg/ola/common/widget/b;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lcom/mg/ola/common/widget/b;->b(I)V

    iget-object v0, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->e:Lcom/mg/ola/common/widget/b;

    invoke-virtual {p0}, Lchat/ola/vn/view/OlaTypingSuggestedText;->getLineHeight()I

    move-result v1

    invoke-virtual {p0}, Lchat/ola/vn/view/OlaTypingSuggestedText;->getHeight()I

    move-result v2

    sub-int/2addr v2, p1

    sub-int/2addr v1, v2

    invoke-virtual {v0, v1}, Lcom/mg/ola/common/widget/b;->e(I)V

    return-void
.end method

.method private b()Z
    .locals 2

    iget-boolean v0, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->g:Z

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    const/4 v0, -0x1

    iput v0, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->c:I

    iput v1, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->d:I

    iget-object v0, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->e:Lcom/mg/ola/common/widget/b;

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/b;->f()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->e:Lcom/mg/ola/common/widget/b;

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/b;->d()V

    const/4 v0, 0x1

    return v0

    :cond_0
    return v1
.end method

.method static synthetic c(Lchat/ola/vn/view/OlaTypingSuggestedText;)Z
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/view/OlaTypingSuggestedText;->b()Z

    move-result p0

    return p0
.end method

.method static synthetic d(Lchat/ola/vn/view/OlaTypingSuggestedText;)Lchat/ola/vn/view/OlaQuickTypingSuggestedText$b;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->h:Lchat/ola/vn/view/OlaQuickTypingSuggestedText$b;

    return-object p0
.end method

.method static synthetic e(Lchat/ola/vn/view/OlaTypingSuggestedText;)Lcom/mg/ola/common/widget/b;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->e:Lcom/mg/ola/common/widget/b;

    return-object p0
.end method


# virtual methods
.method public a(I)I
    .locals 3

    invoke-virtual {p0}, Lchat/ola/vn/view/OlaTypingSuggestedText;->getLayout()Landroid/text/Layout;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroid/text/Layout;->getLineForOffset(I)I

    move-result p1

    invoke-virtual {p0}, Lchat/ola/vn/view/OlaTypingSuggestedText;->getLineHeight()I

    move-result v0

    invoke-virtual {p0}, Lchat/ola/vn/view/OlaTypingSuggestedText;->getTop()I

    move-result v1

    invoke-virtual {p0}, Lchat/ola/vn/view/OlaTypingSuggestedText;->getPaddingTop()I

    move-result v2

    add-int/2addr v1, v2

    mul-int v0, v0, p1

    add-int/2addr v1, v0

    return v1
.end method

.method public a(Ljava/lang/CharSequence;II)V
    .locals 1

    iget-boolean v0, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->g:Z

    if-eqz v0, :cond_0

    invoke-interface {p1}, Ljava/lang/CharSequence;->length()I

    move-result v0

    if-le v0, p2, :cond_0

    add-int/2addr p3, p2

    invoke-interface {p1, p2, p3}, Ljava/lang/CharSequence;->subSequence(II)Ljava/lang/CharSequence;

    move-result-object p1

    iget-object p2, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->f:Landroid/widget/BaseAdapter;

    instance-of p2, p2, Landroid/widget/Filterable;

    if-eqz p2, :cond_0

    iget-object p2, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->f:Landroid/widget/BaseAdapter;

    check-cast p2, Landroid/widget/Filterable;

    invoke-interface {p2}, Landroid/widget/Filterable;->getFilter()Landroid/widget/Filter;

    move-result-object p2

    invoke-virtual {p2, p1}, Landroid/widget/Filter;->filter(Ljava/lang/CharSequence;)V

    :cond_0
    return-void
.end method

.method public getCursorX()F
    .locals 2

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/view/OlaTypingSuggestedText;->getSelectionStart()I

    move-result v0

    invoke-virtual {p0}, Lchat/ola/vn/view/OlaTypingSuggestedText;->getLayout()Landroid/text/Layout;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/text/Layout;->getPrimaryHorizontal(I)F

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    :catch_0
    const/4 v0, 0x0

    return v0
.end method

.method public getCursorY()F
    .locals 3

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/view/OlaTypingSuggestedText;->getSelectionStart()I

    move-result v0

    invoke-virtual {p0}, Lchat/ola/vn/view/OlaTypingSuggestedText;->getLayout()Landroid/text/Layout;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/text/Layout;->getLineForOffset(I)I

    move-result v0

    invoke-virtual {v1, v0}, Landroid/text/Layout;->getLineBaseline(I)I

    move-result v2

    invoke-virtual {v1, v0}, Landroid/text/Layout;->getLineAscent(I)I

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    add-int/2addr v2, v0

    int-to-float v0, v2

    return v0

    :catch_0
    const/4 v0, 0x0

    return v0
.end method

.method public getOnSuggestionSelectListener()Lchat/ola/vn/view/OlaQuickTypingSuggestedText$b;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->h:Lchat/ola/vn/view/OlaQuickTypingSuggestedText$b;

    return-object v0
.end method

.method public onKeyDown(ILandroid/view/KeyEvent;)Z
    .locals 1

    iget-boolean v0, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->g:Z

    if-eqz v0, :cond_1

    const/4 v0, 0x4

    if-eq p1, v0, :cond_0

    const/16 v0, 0x42

    if-eq p1, v0, :cond_0

    goto :goto_0

    :cond_0
    invoke-direct {p0}, Lchat/ola/vn/view/OlaTypingSuggestedText;->b()Z

    move-result v0

    if-eqz v0, :cond_1

    const/4 p1, 0x1

    return p1

    :cond_1
    :goto_0
    invoke-super {p0, p1, p2}, Lcom/mg/ola/common/widget/d;->onKeyDown(ILandroid/view/KeyEvent;)Z

    move-result p1

    return p1
.end method

.method protected onLayout(ZIIII)V
    .locals 0

    invoke-super/range {p0 .. p5}, Lcom/mg/ola/common/widget/d;->onLayout(ZIIII)V

    iget-boolean p1, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->g:Z

    if-eqz p1, :cond_0

    :try_start_0
    iget p1, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->c:I

    invoke-virtual {p0, p1}, Lchat/ola/vn/view/OlaTypingSuggestedText;->a(I)I

    move-result p1

    invoke-direct {p0, p1}, Lchat/ola/vn/view/OlaTypingSuggestedText;->b(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method protected onTextChanged(Ljava/lang/CharSequence;III)V
    .locals 5

    invoke-super {p0, p1, p2, p3, p4}, Lcom/mg/ola/common/widget/d;->onTextChanged(Ljava/lang/CharSequence;III)V

    const-string p2, ""

    :try_start_0
    invoke-interface {p1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-object p1, p2

    :goto_0
    invoke-virtual {p0}, Lchat/ola/vn/view/OlaTypingSuggestedText;->getSelectionStart()I

    move-result p2

    :try_start_1
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result p3
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    if-ge p2, p3, :cond_0

    add-int/lit8 p2, p2, -0x1

    :catch_1
    :cond_0
    iget-boolean p3, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->g:Z

    if-eqz p3, :cond_9

    :try_start_2
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result p3

    if-nez p3, :cond_1

    invoke-direct {p0}, Lchat/ola/vn/view/OlaTypingSuggestedText;->b()Z

    return-void

    :cond_1
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result p3

    const/4 p4, 0x1

    if-lt p2, p3, :cond_2

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result p2

    sub-int/2addr p2, p4

    :cond_2
    invoke-virtual {p1, p2}, Ljava/lang/String;->charAt(I)C

    move-result p3
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_3

    add-int/lit8 v0, p2, -0x1

    const/16 v1, 0xd

    :try_start_3
    invoke-virtual {p1, v0}, Ljava/lang/String;->charAt(I)C

    move-result v0
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_2

    goto :goto_1

    :catch_2
    const/16 v0, 0xd

    :goto_1
    :try_start_4
    iget v2, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->c:I

    const/16 v3, 0x20

    const/16 v4, 0xa

    if-gez v2, :cond_5

    iget-char v2, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->a:C

    if-eq p3, v2, :cond_3

    iget-char v2, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->b:C

    if-ne p3, v2, :cond_9

    :cond_3
    if-eq v0, v4, :cond_4

    if-eq v0, v1, :cond_4

    if-ne v0, v3, :cond_9

    :cond_4
    iput p2, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->c:I

    iput p4, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->d:I

    invoke-direct {p0, p1}, Lchat/ola/vn/view/OlaTypingSuggestedText;->a(Ljava/lang/CharSequence;)V

    return-void

    :cond_5
    iget v0, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->c:I

    if-lt p2, v0, :cond_8

    iget v0, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->c:I

    sub-int/2addr p2, v0

    add-int/2addr p2, p4

    iput p2, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->d:I

    iget p2, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->d:I

    if-le p2, p4, :cond_7

    iget-char p2, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->a:C

    if-eq p3, p2, :cond_6

    iget-char p2, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->b:C

    if-eq p3, p2, :cond_6

    if-eq p3, v3, :cond_6

    if-eq p3, v4, :cond_6

    if-ne p3, v1, :cond_7

    :cond_6
    invoke-direct {p0}, Lchat/ola/vn/view/OlaTypingSuggestedText;->b()Z

    return-void

    :cond_7
    invoke-direct {p0, p1}, Lchat/ola/vn/view/OlaTypingSuggestedText;->a(Ljava/lang/CharSequence;)V

    return-void

    :cond_8
    invoke-direct {p0}, Lchat/ola/vn/view/OlaTypingSuggestedText;->b()Z
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_3

    :catch_3
    :cond_9
    return-void
.end method

.method public onTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 1
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "ClickableViewAccessibility"
        }
    .end annotation

    iget-boolean v0, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->g:Z

    if-eqz v0, :cond_0

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getAction()I

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->e:Lcom/mg/ola/common/widget/b;

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/b;->f()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->e:Lcom/mg/ola/common/widget/b;

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/b;->d()V

    :cond_0
    invoke-super {p0, p1}, Lcom/mg/ola/common/widget/d;->onTouchEvent(Landroid/view/MotionEvent;)Z

    move-result p1

    return p1
.end method

.method public setAdapter(Landroid/widget/BaseAdapter;)V
    .locals 1

    iput-object p1, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->f:Landroid/widget/BaseAdapter;

    iget-object v0, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->e:Lcom/mg/ola/common/widget/b;

    invoke-virtual {v0, p1}, Lcom/mg/ola/common/widget/b;->a(Landroid/widget/ListAdapter;)V

    return-void
.end method

.method public setAllowedSuggestion(Z)V
    .locals 0

    iput-boolean p1, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->g:Z

    return-void
.end method

.method public setContentFilterAdapter(Landroid/widget/BaseAdapter;)V
    .locals 1

    iput-object p1, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->f:Landroid/widget/BaseAdapter;

    iget-object p1, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->e:Lcom/mg/ola/common/widget/b;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Lcom/mg/ola/common/widget/b;->a(Landroid/widget/ListAdapter;)V

    return-void
.end method

.method public setOnSuggestionSelectListener(Lchat/ola/vn/view/OlaQuickTypingSuggestedText$b;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->h:Lchat/ola/vn/view/OlaQuickTypingSuggestedText$b;

    return-void
.end method

.method public setPopupMaxHeight(I)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/view/OlaTypingSuggestedText;->e:Lcom/mg/ola/common/widget/b;

    invoke-virtual {v0, p1}, Lcom/mg/ola/common/widget/b;->h(I)V

    return-void
.end method
