.class public abstract Lit/sephiroth/android/library/widget/a;
.super Landroid/view/ViewGroup;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lit/sephiroth/android/library/widget/a$f;,
        Lit/sephiroth/android/library/widget/a$b;,
        Lit/sephiroth/android/library/widget/a$a;,
        Lit/sephiroth/android/library/widget/a$e;,
        Lit/sephiroth/android/library/widget/a$d;,
        Lit/sephiroth/android/library/widget/a$c;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "<T::",
        "Landroid/widget/Adapter;",
        ">",
        "Landroid/view/ViewGroup;"
    }
.end annotation


# instance fields
.field protected V:I
    .annotation runtime Landroid/view/ViewDebug$ExportedProperty;
        category = "scrolling"
    .end annotation
.end field

.field protected W:I

.field private a:I

.field protected aa:I

.field protected ab:J

.field protected ac:J

.field protected ad:Z

.field ae:I

.field protected af:Z

.field ag:Lit/sephiroth/android/library/widget/a$e;

.field ah:Lit/sephiroth/android/library/widget/a$c;

.field ai:Lit/sephiroth/android/library/widget/a$d;

.field public aj:Z

.field protected ak:I
    .annotation runtime Landroid/view/ViewDebug$ExportedProperty;
        category = "list"
    .end annotation
.end field

.field protected al:J

.field protected am:I
    .annotation runtime Landroid/view/ViewDebug$ExportedProperty;
        category = "list"
    .end annotation
.end field

.field protected an:J

.field protected ao:I
    .annotation runtime Landroid/view/ViewDebug$ExportedProperty;
        category = "list"
    .end annotation
.end field

.field protected ap:I

.field aq:Landroid/view/accessibility/AccessibilityManager;

.field protected ar:I

.field protected as:J

.field protected at:Z

.field private b:Landroid/view/View;

.field private c:Z

.field private d:Z

.field private e:Lit/sephiroth/android/library/widget/a$f;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lit/sephiroth/android/library/widget/a<",
            "TT;>.f;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 3

    invoke-direct {p0, p1}, Landroid/view/ViewGroup;-><init>(Landroid/content/Context;)V

    const/4 p1, 0x0

    iput p1, p0, Lit/sephiroth/android/library/widget/a;->V:I

    const-wide/high16 v0, -0x8000000000000000L

    iput-wide v0, p0, Lit/sephiroth/android/library/widget/a;->ab:J

    iput-boolean p1, p0, Lit/sephiroth/android/library/widget/a;->ad:Z

    iput-boolean p1, p0, Lit/sephiroth/android/library/widget/a;->af:Z

    const/4 v2, -0x1

    iput v2, p0, Lit/sephiroth/android/library/widget/a;->ak:I

    iput-wide v0, p0, Lit/sephiroth/android/library/widget/a;->al:J

    iput v2, p0, Lit/sephiroth/android/library/widget/a;->am:I

    iput-wide v0, p0, Lit/sephiroth/android/library/widget/a;->an:J

    iput v2, p0, Lit/sephiroth/android/library/widget/a;->ar:I

    iput-wide v0, p0, Lit/sephiroth/android/library/widget/a;->as:J

    iput-boolean p1, p0, Lit/sephiroth/android/library/widget/a;->at:Z

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 2

    invoke-direct {p0, p1, p2}, Landroid/view/ViewGroup;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    const/4 p1, 0x0

    iput p1, p0, Lit/sephiroth/android/library/widget/a;->V:I

    const-wide/high16 v0, -0x8000000000000000L

    iput-wide v0, p0, Lit/sephiroth/android/library/widget/a;->ab:J

    iput-boolean p1, p0, Lit/sephiroth/android/library/widget/a;->ad:Z

    iput-boolean p1, p0, Lit/sephiroth/android/library/widget/a;->af:Z

    const/4 p2, -0x1

    iput p2, p0, Lit/sephiroth/android/library/widget/a;->ak:I

    iput-wide v0, p0, Lit/sephiroth/android/library/widget/a;->al:J

    iput p2, p0, Lit/sephiroth/android/library/widget/a;->am:I

    iput-wide v0, p0, Lit/sephiroth/android/library/widget/a;->an:J

    iput p2, p0, Lit/sephiroth/android/library/widget/a;->ar:I

    iput-wide v0, p0, Lit/sephiroth/android/library/widget/a;->as:J

    iput-boolean p1, p0, Lit/sephiroth/android/library/widget/a;->at:Z

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 1
    .annotation build Landroid/annotation/TargetApi;
        value = 0x10
    .end annotation

    invoke-direct {p0, p1, p2, p3}, Landroid/view/ViewGroup;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    const/4 p1, 0x0

    iput p1, p0, Lit/sephiroth/android/library/widget/a;->V:I

    const-wide/high16 p2, -0x8000000000000000L

    iput-wide p2, p0, Lit/sephiroth/android/library/widget/a;->ab:J

    iput-boolean p1, p0, Lit/sephiroth/android/library/widget/a;->ad:Z

    iput-boolean p1, p0, Lit/sephiroth/android/library/widget/a;->af:Z

    const/4 v0, -0x1

    iput v0, p0, Lit/sephiroth/android/library/widget/a;->ak:I

    iput-wide p2, p0, Lit/sephiroth/android/library/widget/a;->al:J

    iput v0, p0, Lit/sephiroth/android/library/widget/a;->am:I

    iput-wide p2, p0, Lit/sephiroth/android/library/widget/a;->an:J

    iput v0, p0, Lit/sephiroth/android/library/widget/a;->ar:I

    iput-wide p2, p0, Lit/sephiroth/android/library/widget/a;->as:J

    iput-boolean p1, p0, Lit/sephiroth/android/library/widget/a;->at:Z

    sget p1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 p2, 0x10

    if-lt p1, p2, :cond_0

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/a;->getImportantForAccessibility()I

    move-result p1

    if-nez p1, :cond_0

    const/4 p1, 0x1

    invoke-virtual {p0, p1}, Lit/sephiroth/android/library/widget/a;->setImportantForAccessibility(I)V

    :cond_0
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/a;->isInEditMode()Z

    move-result p1

    if-nez p1, :cond_1

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/a;->getContext()Landroid/content/Context;

    move-result-object p1

    const-string p2, "accessibility"

    invoke-virtual {p1, p2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/view/accessibility/AccessibilityManager;

    iput-object p1, p0, Lit/sephiroth/android/library/widget/a;->aq:Landroid/view/accessibility/AccessibilityManager;

    :cond_1
    return-void
.end method

.method static synthetic a(Lit/sephiroth/android/library/widget/a;)Landroid/os/Parcelable;
    .locals 0

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/a;->onSaveInstanceState()Landroid/os/Parcelable;

    move-result-object p0

    return-object p0
.end method

.method private a()V
    .locals 7

    iget-object v0, p0, Lit/sephiroth/android/library/widget/a;->ag:Lit/sephiroth/android/library/widget/a$e;

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/a;->getSelectedItemPosition()I

    move-result v4

    if-ltz v4, :cond_1

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/a;->getSelectedView()Landroid/view/View;

    move-result-object v3

    iget-object v1, p0, Lit/sephiroth/android/library/widget/a;->ag:Lit/sephiroth/android/library/widget/a$e;

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/a;->getAdapter()Landroid/widget/Adapter;

    move-result-object v0

    invoke-interface {v0, v4}, Landroid/widget/Adapter;->getItemId(I)J

    move-result-wide v5

    move-object v2, p0

    invoke-interface/range {v1 .. v6}, Lit/sephiroth/android/library/widget/a$e;->a(Lit/sephiroth/android/library/widget/a;Landroid/view/View;IJ)V

    return-void

    :cond_1
    iget-object v0, p0, Lit/sephiroth/android/library/widget/a;->ag:Lit/sephiroth/android/library/widget/a$e;

    invoke-interface {v0, p0}, Lit/sephiroth/android/library/widget/a$e;->a(Lit/sephiroth/android/library/widget/a;)V

    return-void
.end method

.method static synthetic a(Lit/sephiroth/android/library/widget/a;Landroid/os/Parcelable;)V
    .locals 0

    invoke-virtual {p0, p1}, Lit/sephiroth/android/library/widget/a;->onRestoreInstanceState(Landroid/os/Parcelable;)V

    return-void
.end method

.method private a(Z)V
    .locals 6
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "WrongCall"
        }
    .end annotation

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/a;->r()Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    const/4 p1, 0x0

    :cond_0
    const/16 v0, 0x8

    if-eqz p1, :cond_2

    iget-object p1, p0, Lit/sephiroth/android/library/widget/a;->b:Landroid/view/View;

    if-eqz p1, :cond_1

    iget-object p1, p0, Lit/sephiroth/android/library/widget/a;->b:Landroid/view/View;

    invoke-virtual {p1, v1}, Landroid/view/View;->setVisibility(I)V

    invoke-virtual {p0, v0}, Lit/sephiroth/android/library/widget/a;->setVisibility(I)V

    goto :goto_0

    :cond_1
    invoke-virtual {p0, v1}, Lit/sephiroth/android/library/widget/a;->setVisibility(I)V

    :goto_0
    iget-boolean p1, p0, Lit/sephiroth/android/library/widget/a;->aj:Z

    if-eqz p1, :cond_4

    const/4 v1, 0x0

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/a;->getLeft()I

    move-result v2

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/a;->getTop()I

    move-result v3

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/a;->getRight()I

    move-result v4

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/a;->getBottom()I

    move-result v5

    move-object v0, p0

    invoke-virtual/range {v0 .. v5}, Lit/sephiroth/android/library/widget/a;->onLayout(ZIIII)V

    return-void

    :cond_2
    iget-object p1, p0, Lit/sephiroth/android/library/widget/a;->b:Landroid/view/View;

    if-eqz p1, :cond_3

    iget-object p1, p0, Lit/sephiroth/android/library/widget/a;->b:Landroid/view/View;

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    :cond_3
    invoke-virtual {p0, v1}, Lit/sephiroth/android/library/widget/a;->setVisibility(I)V

    :cond_4
    return-void
.end method

.method private b()V
    .locals 1

    iget-object v0, p0, Lit/sephiroth/android/library/widget/a;->aq:Landroid/view/accessibility/AccessibilityManager;

    invoke-virtual {v0}, Landroid/view/accessibility/AccessibilityManager;->isEnabled()Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/a;->getSelectedItemPosition()I

    move-result v0

    if-ltz v0, :cond_1

    const/4 v0, 0x4

    invoke-virtual {p0, v0}, Lit/sephiroth/android/library/widget/a;->sendAccessibilityEvent(I)V

    :cond_1
    return-void
.end method

.method static synthetic b(Lit/sephiroth/android/library/widget/a;)V
    .locals 0

    invoke-direct {p0}, Lit/sephiroth/android/library/widget/a;->a()V

    return-void
.end method

.method static synthetic c(Lit/sephiroth/android/library/widget/a;)V
    .locals 0

    invoke-direct {p0}, Lit/sephiroth/android/library/widget/a;->b()V

    return-void
.end method

.method private c()Z
    .locals 4

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/a;->getAdapter()Landroid/widget/Adapter;

    move-result-object v0

    const/4 v1, 0x0

    if-eqz v0, :cond_1

    invoke-interface {v0}, Landroid/widget/Adapter;->getCount()I

    move-result v0

    const/4 v2, 0x1

    if-lez v0, :cond_1

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/a;->getFirstVisiblePosition()I

    move-result v3

    if-gtz v3, :cond_0

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/a;->getLastVisiblePosition()I

    move-result v3

    sub-int/2addr v0, v2

    if-ge v3, v0, :cond_1

    :cond_0
    const/4 v1, 0x1

    :cond_1
    return v1
.end method


# virtual methods
.method public a(Landroid/view/View;)I
    .locals 4

    :goto_0
    const/4 v0, -0x1

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object v1

    check-cast v1, Landroid/view/View;

    invoke-virtual {v1, p0}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v2
    :try_end_0
    .catch Ljava/lang/ClassCastException; {:try_start_0 .. :try_end_0} :catch_0

    if-nez v2, :cond_0

    move-object p1, v1

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/a;->getChildCount()I

    move-result v1

    const/4 v2, 0x0

    :goto_1
    if-ge v2, v1, :cond_2

    invoke-virtual {p0, v2}, Lit/sephiroth/android/library/widget/a;->getChildAt(I)Landroid/view/View;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_1

    iget p1, p0, Lit/sephiroth/android/library/widget/a;->V:I

    add-int/2addr p1, v2

    return p1

    :cond_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    :catch_0
    :cond_2
    return v0
.end method

.method public a(Landroid/view/View;IJ)Z
    .locals 7

    iget-object v0, p0, Lit/sephiroth/android/library/widget/a;->ah:Lit/sephiroth/android/library/widget/a$c;

    const/4 v1, 0x0

    if-eqz v0, :cond_1

    invoke-virtual {p0, v1}, Lit/sephiroth/android/library/widget/a;->playSoundEffect(I)V

    const/4 v0, 0x1

    if-eqz p1, :cond_0

    invoke-virtual {p1, v0}, Landroid/view/View;->sendAccessibilityEvent(I)V

    :cond_0
    iget-object v1, p0, Lit/sephiroth/android/library/widget/a;->ah:Lit/sephiroth/android/library/widget/a$c;

    move-object v2, p0

    move-object v3, p1

    move v4, p2

    move-wide v5, p3

    invoke-interface/range {v1 .. v6}, Lit/sephiroth/android/library/widget/a$c;->a(Lit/sephiroth/android/library/widget/a;Landroid/view/View;IJ)V

    return v0

    :cond_1
    return v1
.end method

.method public addView(Landroid/view/View;)V
    .locals 1

    new-instance p1, Ljava/lang/UnsupportedOperationException;

    const-string v0, "addView(View) is not supported in AdapterView"

    invoke-direct {p1, v0}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public addView(Landroid/view/View;I)V
    .locals 0

    new-instance p1, Ljava/lang/UnsupportedOperationException;

    const-string p2, "addView(View, int) is not supported in AdapterView"

    invoke-direct {p1, p2}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public addView(Landroid/view/View;ILandroid/view/ViewGroup$LayoutParams;)V
    .locals 0

    new-instance p1, Ljava/lang/UnsupportedOperationException;

    const-string p2, "addView(View, int, LayoutParams) is not supported in AdapterView"

    invoke-direct {p1, p2}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
    .locals 0

    new-instance p1, Ljava/lang/UnsupportedOperationException;

    const-string p2, "addView(View, LayoutParams) is not supported in AdapterView"

    invoke-direct {p1, p2}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method protected b(IZ)I
    .locals 0

    return p1
.end method

.method protected canAnimate()Z
    .locals 1

    invoke-super {p0}, Landroid/view/ViewGroup;->canAnimate()Z

    move-result v0

    if-eqz v0, :cond_0

    iget v0, p0, Lit/sephiroth/android/library/widget/a;->ao:I

    if-lez v0, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method public dispatchPopulateAccessibilityEvent(Landroid/view/accessibility/AccessibilityEvent;)Z
    .locals 2

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/a;->getSelectedView()Landroid/view/View;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Landroid/view/View;->getVisibility()I

    move-result v1

    if-nez v1, :cond_0

    invoke-virtual {v0, p1}, Landroid/view/View;->dispatchPopulateAccessibilityEvent(Landroid/view/accessibility/AccessibilityEvent;)Z

    move-result p1

    if-eqz p1, :cond_0

    const/4 p1, 0x1

    return p1

    :cond_0
    const/4 p1, 0x0

    return p1
.end method

.method protected dispatchRestoreInstanceState(Landroid/util/SparseArray;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/util/SparseArray<",
            "Landroid/os/Parcelable;",
            ">;)V"
        }
    .end annotation

    invoke-virtual {p0, p1}, Lit/sephiroth/android/library/widget/a;->dispatchThawSelfOnly(Landroid/util/SparseArray;)V

    return-void
.end method

.method protected dispatchSaveInstanceState(Landroid/util/SparseArray;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/util/SparseArray<",
            "Landroid/os/Parcelable;",
            ">;)V"
        }
    .end annotation

    invoke-virtual {p0, p1}, Lit/sephiroth/android/library/widget/a;->dispatchFreezeSelfOnly(Landroid/util/SparseArray;)V

    return-void
.end method

.method public g(I)J
    .locals 2

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/a;->getAdapter()Landroid/widget/Adapter;

    move-result-object v0

    if-eqz v0, :cond_1

    if-gez p1, :cond_0

    goto :goto_0

    :cond_0
    invoke-interface {v0, p1}, Landroid/widget/Adapter;->getItemId(I)J

    move-result-wide v0

    return-wide v0

    :cond_1
    :goto_0
    const-wide/high16 v0, -0x8000000000000000L

    return-wide v0
.end method

.method public abstract getAdapter()Landroid/widget/Adapter;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()TT;"
        }
    .end annotation
.end method

.method public getCount()I
    .locals 1
    .annotation runtime Landroid/view/ViewDebug$CapturedViewProperty;
    .end annotation

    iget v0, p0, Lit/sephiroth/android/library/widget/a;->ao:I

    return v0
.end method

.method public getEmptyView()Landroid/view/View;
    .locals 1

    iget-object v0, p0, Lit/sephiroth/android/library/widget/a;->b:Landroid/view/View;

    return-object v0
.end method

.method public getFirstVisiblePosition()I
    .locals 1

    iget v0, p0, Lit/sephiroth/android/library/widget/a;->V:I

    return v0
.end method

.method public getLastVisiblePosition()I
    .locals 2

    iget v0, p0, Lit/sephiroth/android/library/widget/a;->V:I

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/a;->getChildCount()I

    move-result v1

    add-int/2addr v0, v1

    add-int/lit8 v0, v0, -0x1

    return v0
.end method

.method public final getOnItemClickListener()Lit/sephiroth/android/library/widget/a$c;
    .locals 1

    iget-object v0, p0, Lit/sephiroth/android/library/widget/a;->ah:Lit/sephiroth/android/library/widget/a$c;

    return-object v0
.end method

.method public final getOnItemLongClickListener()Lit/sephiroth/android/library/widget/a$d;
    .locals 1

    iget-object v0, p0, Lit/sephiroth/android/library/widget/a;->ai:Lit/sephiroth/android/library/widget/a$d;

    return-object v0
.end method

.method public final getOnItemSelectedListener()Lit/sephiroth/android/library/widget/a$e;
    .locals 1

    iget-object v0, p0, Lit/sephiroth/android/library/widget/a;->ag:Lit/sephiroth/android/library/widget/a$e;

    return-object v0
.end method

.method public getSelectedItem()Ljava/lang/Object;
    .locals 3

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/a;->getAdapter()Landroid/widget/Adapter;

    move-result-object v0

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/a;->getSelectedItemPosition()I

    move-result v1

    if-eqz v0, :cond_0

    invoke-interface {v0}, Landroid/widget/Adapter;->getCount()I

    move-result v2

    if-lez v2, :cond_0

    if-ltz v1, :cond_0

    invoke-interface {v0, v1}, Landroid/widget/Adapter;->getItem(I)Ljava/lang/Object;

    move-result-object v0

    return-object v0

    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public getSelectedItemId()J
    .locals 2
    .annotation runtime Landroid/view/ViewDebug$CapturedViewProperty;
    .end annotation

    iget-wide v0, p0, Lit/sephiroth/android/library/widget/a;->al:J

    return-wide v0
.end method

.method public getSelectedItemPosition()I
    .locals 1
    .annotation runtime Landroid/view/ViewDebug$CapturedViewProperty;
    .end annotation

    iget v0, p0, Lit/sephiroth/android/library/widget/a;->ak:I

    return v0
.end method

.method public abstract getSelectedView()Landroid/view/View;
.end method

.method protected onDetachedFromWindow()V
    .locals 1

    invoke-super {p0}, Landroid/view/ViewGroup;->onDetachedFromWindow()V

    iget-object v0, p0, Lit/sephiroth/android/library/widget/a;->e:Lit/sephiroth/android/library/widget/a$f;

    invoke-virtual {p0, v0}, Lit/sephiroth/android/library/widget/a;->removeCallbacks(Ljava/lang/Runnable;)Z

    return-void
.end method

.method public onInitializeAccessibilityEvent(Landroid/view/accessibility/AccessibilityEvent;)V
    .locals 1
    .annotation build Landroid/annotation/TargetApi;
        value = 0xe
    .end annotation

    invoke-super {p0, p1}, Landroid/view/ViewGroup;->onInitializeAccessibilityEvent(Landroid/view/accessibility/AccessibilityEvent;)V

    const-class v0, Lit/sephiroth/android/library/widget/a;

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/view/accessibility/AccessibilityEvent;->setClassName(Ljava/lang/CharSequence;)V

    invoke-direct {p0}, Lit/sephiroth/android/library/widget/a;->c()Z

    move-result v0

    invoke-virtual {p1, v0}, Landroid/view/accessibility/AccessibilityEvent;->setScrollable(Z)V

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/a;->getSelectedView()Landroid/view/View;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Landroid/view/View;->isEnabled()Z

    move-result v0

    invoke-virtual {p1, v0}, Landroid/view/accessibility/AccessibilityEvent;->setEnabled(Z)V

    :cond_0
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/a;->getSelectedItemPosition()I

    move-result v0

    invoke-virtual {p1, v0}, Landroid/view/accessibility/AccessibilityEvent;->setCurrentItemIndex(I)V

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/a;->getFirstVisiblePosition()I

    move-result v0

    invoke-virtual {p1, v0}, Landroid/view/accessibility/AccessibilityEvent;->setFromIndex(I)V

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/a;->getLastVisiblePosition()I

    move-result v0

    invoke-virtual {p1, v0}, Landroid/view/accessibility/AccessibilityEvent;->setToIndex(I)V

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/a;->getCount()I

    move-result v0

    invoke-virtual {p1, v0}, Landroid/view/accessibility/AccessibilityEvent;->setItemCount(I)V

    return-void
.end method

.method public onInitializeAccessibilityNodeInfo(Landroid/view/accessibility/AccessibilityNodeInfo;)V
    .locals 1
    .annotation build Landroid/annotation/TargetApi;
        value = 0xe
    .end annotation

    invoke-super {p0, p1}, Landroid/view/ViewGroup;->onInitializeAccessibilityNodeInfo(Landroid/view/accessibility/AccessibilityNodeInfo;)V

    const-class v0, Lit/sephiroth/android/library/widget/a;

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/view/accessibility/AccessibilityNodeInfo;->setClassName(Ljava/lang/CharSequence;)V

    invoke-direct {p0}, Lit/sephiroth/android/library/widget/a;->c()Z

    move-result v0

    invoke-virtual {p1, v0}, Landroid/view/accessibility/AccessibilityNodeInfo;->setScrollable(Z)V

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/a;->getSelectedView()Landroid/view/View;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Landroid/view/View;->isEnabled()Z

    move-result v0

    invoke-virtual {p1, v0}, Landroid/view/accessibility/AccessibilityNodeInfo;->setEnabled(Z)V

    :cond_0
    return-void
.end method

.method protected onLayout(ZIIII)V
    .locals 0

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/a;->getWidth()I

    move-result p1

    iput p1, p0, Lit/sephiroth/android/library/widget/a;->a:I

    return-void
.end method

.method public onRequestSendAccessibilityEvent(Landroid/view/View;Landroid/view/accessibility/AccessibilityEvent;)Z
    .locals 1
    .annotation build Landroid/annotation/TargetApi;
        value = 0xe
    .end annotation

    invoke-super {p0, p1, p2}, Landroid/view/ViewGroup;->onRequestSendAccessibilityEvent(Landroid/view/View;Landroid/view/accessibility/AccessibilityEvent;)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-static {}, Landroid/view/accessibility/AccessibilityEvent;->obtain()Landroid/view/accessibility/AccessibilityEvent;

    move-result-object v0

    invoke-virtual {p0, v0}, Lit/sephiroth/android/library/widget/a;->onInitializeAccessibilityEvent(Landroid/view/accessibility/AccessibilityEvent;)V

    invoke-virtual {p1, v0}, Landroid/view/View;->dispatchPopulateAccessibilityEvent(Landroid/view/accessibility/AccessibilityEvent;)Z

    invoke-virtual {p2, v0}, Landroid/view/accessibility/AccessibilityEvent;->appendRecord(Landroid/view/accessibility/AccessibilityRecord;)V

    const/4 p1, 0x1

    return p1

    :cond_0
    const/4 p1, 0x0

    return p1
.end method

.method q()V
    .locals 5

    iget v0, p0, Lit/sephiroth/android/library/widget/a;->ao:I

    const/4 v1, 0x1

    const/4 v2, 0x0

    if-lez v0, :cond_5

    iget-boolean v3, p0, Lit/sephiroth/android/library/widget/a;->ad:Z

    if-eqz v3, :cond_0

    iput-boolean v2, p0, Lit/sephiroth/android/library/widget/a;->ad:Z

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/a;->v()I

    move-result v3

    if-ltz v3, :cond_0

    invoke-virtual {p0, v3, v1}, Lit/sephiroth/android/library/widget/a;->b(IZ)I

    move-result v4

    if-ne v4, v3, :cond_0

    invoke-virtual {p0, v3}, Lit/sephiroth/android/library/widget/a;->setNextSelectedPositionInt(I)V

    const/4 v3, 0x1

    goto :goto_0

    :cond_0
    const/4 v3, 0x0

    :goto_0
    if-nez v3, :cond_4

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/a;->getSelectedItemPosition()I

    move-result v4

    if-lt v4, v0, :cond_1

    sub-int/2addr v0, v1

    goto :goto_1

    :cond_1
    move v0, v4

    :goto_1
    if-gez v0, :cond_2

    const/4 v0, 0x0

    :cond_2
    invoke-virtual {p0, v0, v1}, Lit/sephiroth/android/library/widget/a;->b(IZ)I

    move-result v4

    if-gez v4, :cond_3

    invoke-virtual {p0, v0, v2}, Lit/sephiroth/android/library/widget/a;->b(IZ)I

    move-result v4

    :cond_3
    if-ltz v4, :cond_4

    invoke-virtual {p0, v4}, Lit/sephiroth/android/library/widget/a;->setNextSelectedPositionInt(I)V

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/a;->u()V

    goto :goto_2

    :cond_4
    move v1, v3

    goto :goto_2

    :cond_5
    const/4 v1, 0x0

    :goto_2
    if-nez v1, :cond_6

    const/4 v0, -0x1

    iput v0, p0, Lit/sephiroth/android/library/widget/a;->am:I

    const-wide/high16 v3, -0x8000000000000000L

    iput-wide v3, p0, Lit/sephiroth/android/library/widget/a;->an:J

    iput v0, p0, Lit/sephiroth/android/library/widget/a;->ak:I

    iput-wide v3, p0, Lit/sephiroth/android/library/widget/a;->al:J

    iput-boolean v2, p0, Lit/sephiroth/android/library/widget/a;->ad:Z

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/a;->u()V

    :cond_6
    return-void
.end method

.method r()Z
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public removeAllViews()V
    .locals 2

    new-instance v0, Ljava/lang/UnsupportedOperationException;

    const-string v1, "removeAllViews() is not supported in AdapterView"

    invoke-direct {v0, v1}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public removeView(Landroid/view/View;)V
    .locals 1

    new-instance p1, Ljava/lang/UnsupportedOperationException;

    const-string v0, "removeView(View) is not supported in AdapterView"

    invoke-direct {p1, v0}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public removeViewAt(I)V
    .locals 1

    new-instance p1, Ljava/lang/UnsupportedOperationException;

    const-string v0, "removeViewAt(int) is not supported in AdapterView"

    invoke-direct {p1, v0}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method protected s()V
    .locals 5

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/a;->getAdapter()Landroid/widget/Adapter;

    move-result-object v0

    const/4 v1, 0x1

    const/4 v2, 0x0

    if-eqz v0, :cond_1

    invoke-interface {v0}, Landroid/widget/Adapter;->getCount()I

    move-result v3

    if-nez v3, :cond_0

    goto :goto_0

    :cond_0
    const/4 v3, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v3, 0x1

    :goto_1
    if-eqz v3, :cond_3

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/a;->r()Z

    move-result v3

    if-eqz v3, :cond_2

    goto :goto_2

    :cond_2
    const/4 v3, 0x0

    goto :goto_3

    :cond_3
    :goto_2
    const/4 v3, 0x1

    :goto_3
    if-eqz v3, :cond_4

    iget-boolean v4, p0, Lit/sephiroth/android/library/widget/a;->d:Z

    if-eqz v4, :cond_4

    const/4 v4, 0x1

    goto :goto_4

    :cond_4
    const/4 v4, 0x0

    :goto_4
    invoke-super {p0, v4}, Landroid/view/ViewGroup;->setFocusableInTouchMode(Z)V

    if-eqz v3, :cond_5

    iget-boolean v3, p0, Lit/sephiroth/android/library/widget/a;->c:Z

    if-eqz v3, :cond_5

    const/4 v3, 0x1

    goto :goto_5

    :cond_5
    const/4 v3, 0x0

    :goto_5
    invoke-super {p0, v3}, Landroid/view/ViewGroup;->setFocusable(Z)V

    iget-object v3, p0, Lit/sephiroth/android/library/widget/a;->b:Landroid/view/View;

    if-eqz v3, :cond_8

    if-eqz v0, :cond_7

    invoke-interface {v0}, Landroid/widget/Adapter;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_6

    goto :goto_6

    :cond_6
    const/4 v1, 0x0

    :cond_7
    :goto_6
    invoke-direct {p0, v1}, Lit/sephiroth/android/library/widget/a;->a(Z)V

    :cond_8
    return-void
.end method

.method public abstract setAdapter(Landroid/widget/Adapter;)V
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TT;)V"
        }
    .end annotation
.end method

.method public setEmptyView(Landroid/view/View;)V
    .locals 3
    .annotation build Landroid/annotation/TargetApi;
        value = 0x10
    .end annotation

    iput-object p1, p0, Lit/sephiroth/android/library/widget/a;->b:Landroid/view/View;

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/4 v1, 0x1

    const/16 v2, 0x10

    if-lt v0, v2, :cond_0

    if-eqz p1, :cond_0

    invoke-virtual {p1}, Landroid/view/View;->getImportantForAccessibility()I

    move-result v0

    if-nez v0, :cond_0

    invoke-virtual {p1, v1}, Landroid/view/View;->setImportantForAccessibility(I)V

    :cond_0
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/a;->getAdapter()Landroid/widget/Adapter;

    move-result-object p1

    if-eqz p1, :cond_2

    invoke-interface {p1}, Landroid/widget/Adapter;->isEmpty()Z

    move-result p1

    if-eqz p1, :cond_1

    goto :goto_0

    :cond_1
    const/4 v1, 0x0

    :cond_2
    :goto_0
    invoke-direct {p0, v1}, Lit/sephiroth/android/library/widget/a;->a(Z)V

    return-void
.end method

.method public setFocusable(Z)V
    .locals 3

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/a;->getAdapter()Landroid/widget/Adapter;

    move-result-object v0

    const/4 v1, 0x1

    const/4 v2, 0x0

    if-eqz v0, :cond_1

    invoke-interface {v0}, Landroid/widget/Adapter;->getCount()I

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v0, 0x1

    :goto_1
    iput-boolean p1, p0, Lit/sephiroth/android/library/widget/a;->c:Z

    if-nez p1, :cond_2

    iput-boolean v2, p0, Lit/sephiroth/android/library/widget/a;->d:Z

    :cond_2
    if-eqz p1, :cond_3

    if-eqz v0, :cond_4

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/a;->r()Z

    move-result p1

    if-eqz p1, :cond_3

    goto :goto_2

    :cond_3
    const/4 v1, 0x0

    :cond_4
    :goto_2
    invoke-super {p0, v1}, Landroid/view/ViewGroup;->setFocusable(Z)V

    return-void
.end method

.method public setFocusableInTouchMode(Z)V
    .locals 3

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/a;->getAdapter()Landroid/widget/Adapter;

    move-result-object v0

    const/4 v1, 0x0

    const/4 v2, 0x1

    if-eqz v0, :cond_1

    invoke-interface {v0}, Landroid/widget/Adapter;->getCount()I

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v0, 0x1

    :goto_1
    iput-boolean p1, p0, Lit/sephiroth/android/library/widget/a;->d:Z

    if-eqz p1, :cond_2

    iput-boolean v2, p0, Lit/sephiroth/android/library/widget/a;->c:Z

    :cond_2
    if-eqz p1, :cond_4

    if-eqz v0, :cond_3

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/a;->r()Z

    move-result p1

    if-eqz p1, :cond_4

    :cond_3
    const/4 v1, 0x1

    :cond_4
    invoke-super {p0, v1}, Landroid/view/ViewGroup;->setFocusableInTouchMode(Z)V

    return-void
.end method

.method protected setNextSelectedPositionInt(I)V
    .locals 2

    iput p1, p0, Lit/sephiroth/android/library/widget/a;->ak:I

    invoke-virtual {p0, p1}, Lit/sephiroth/android/library/widget/a;->g(I)J

    move-result-wide v0

    iput-wide v0, p0, Lit/sephiroth/android/library/widget/a;->al:J

    iget-boolean v0, p0, Lit/sephiroth/android/library/widget/a;->ad:Z

    if-eqz v0, :cond_0

    iget v0, p0, Lit/sephiroth/android/library/widget/a;->ae:I

    if-nez v0, :cond_0

    if-ltz p1, :cond_0

    iput p1, p0, Lit/sephiroth/android/library/widget/a;->aa:I

    iget-wide v0, p0, Lit/sephiroth/android/library/widget/a;->al:J

    iput-wide v0, p0, Lit/sephiroth/android/library/widget/a;->ab:J

    :cond_0
    return-void
.end method

.method public setOnClickListener(Landroid/view/View$OnClickListener;)V
    .locals 1

    new-instance p1, Ljava/lang/RuntimeException;

    const-string v0, "Don\'t call setOnClickListener for an AdapterView. You probably want setOnItemClickListener instead"

    invoke-direct {p1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public setOnItemClickListener(Lit/sephiroth/android/library/widget/a$c;)V
    .locals 0

    iput-object p1, p0, Lit/sephiroth/android/library/widget/a;->ah:Lit/sephiroth/android/library/widget/a$c;

    return-void
.end method

.method public setOnItemLongClickListener(Lit/sephiroth/android/library/widget/a$d;)V
    .locals 1

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/a;->isLongClickable()Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Lit/sephiroth/android/library/widget/a;->setLongClickable(Z)V

    :cond_0
    iput-object p1, p0, Lit/sephiroth/android/library/widget/a;->ai:Lit/sephiroth/android/library/widget/a$d;

    return-void
.end method

.method public setOnItemSelectedListener(Lit/sephiroth/android/library/widget/a$e;)V
    .locals 0

    iput-object p1, p0, Lit/sephiroth/android/library/widget/a;->ag:Lit/sephiroth/android/library/widget/a$e;

    return-void
.end method

.method protected setSelectedPositionInt(I)V
    .locals 2

    iput p1, p0, Lit/sephiroth/android/library/widget/a;->am:I

    invoke-virtual {p0, p1}, Lit/sephiroth/android/library/widget/a;->g(I)J

    move-result-wide v0

    iput-wide v0, p0, Lit/sephiroth/android/library/widget/a;->an:J

    return-void
.end method

.method public abstract setSelection(I)V
.end method

.method t()V
    .locals 2

    iget-object v0, p0, Lit/sephiroth/android/library/widget/a;->ag:Lit/sephiroth/android/library/widget/a$e;

    if-nez v0, :cond_0

    iget-object v0, p0, Lit/sephiroth/android/library/widget/a;->aq:Landroid/view/accessibility/AccessibilityManager;

    invoke-virtual {v0}, Landroid/view/accessibility/AccessibilityManager;->isEnabled()Z

    move-result v0

    if-eqz v0, :cond_4

    :cond_0
    iget-boolean v0, p0, Lit/sephiroth/android/library/widget/a;->af:Z

    if-nez v0, :cond_2

    iget-boolean v0, p0, Lit/sephiroth/android/library/widget/a;->at:Z

    if-eqz v0, :cond_1

    goto :goto_0

    :cond_1
    invoke-direct {p0}, Lit/sephiroth/android/library/widget/a;->a()V

    invoke-direct {p0}, Lit/sephiroth/android/library/widget/a;->b()V

    return-void

    :cond_2
    :goto_0
    iget-object v0, p0, Lit/sephiroth/android/library/widget/a;->e:Lit/sephiroth/android/library/widget/a$f;

    if-nez v0, :cond_3

    new-instance v0, Lit/sephiroth/android/library/widget/a$f;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, Lit/sephiroth/android/library/widget/a$f;-><init>(Lit/sephiroth/android/library/widget/a;Lit/sephiroth/android/library/widget/a$1;)V

    iput-object v0, p0, Lit/sephiroth/android/library/widget/a;->e:Lit/sephiroth/android/library/widget/a$f;

    :cond_3
    iget-object v0, p0, Lit/sephiroth/android/library/widget/a;->e:Lit/sephiroth/android/library/widget/a$f;

    invoke-virtual {p0, v0}, Lit/sephiroth/android/library/widget/a;->post(Ljava/lang/Runnable;)Z

    :cond_4
    return-void
.end method

.method protected u()V
    .locals 5

    iget v0, p0, Lit/sephiroth/android/library/widget/a;->am:I

    iget v1, p0, Lit/sephiroth/android/library/widget/a;->ar:I

    if-ne v0, v1, :cond_0

    iget-wide v0, p0, Lit/sephiroth/android/library/widget/a;->an:J

    iget-wide v2, p0, Lit/sephiroth/android/library/widget/a;->as:J

    cmp-long v4, v0, v2

    if-eqz v4, :cond_1

    :cond_0
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/a;->t()V

    iget v0, p0, Lit/sephiroth/android/library/widget/a;->am:I

    iput v0, p0, Lit/sephiroth/android/library/widget/a;->ar:I

    iget-wide v0, p0, Lit/sephiroth/android/library/widget/a;->an:J

    iput-wide v0, p0, Lit/sephiroth/android/library/widget/a;->as:J

    :cond_1
    return-void
.end method

.method v()I
    .locals 17

    move-object/from16 v0, p0

    iget v1, v0, Lit/sephiroth/android/library/widget/a;->ao:I

    const/4 v2, -0x1

    if-nez v1, :cond_0

    return v2

    :cond_0
    iget-wide v3, v0, Lit/sephiroth/android/library/widget/a;->ab:J

    iget v5, v0, Lit/sephiroth/android/library/widget/a;->aa:I

    const-wide/high16 v6, -0x8000000000000000L

    cmp-long v8, v3, v6

    if-nez v8, :cond_1

    return v2

    :cond_1
    const/4 v6, 0x0

    invoke-static {v6, v5}, Ljava/lang/Math;->max(II)I

    move-result v5

    const/4 v7, 0x1

    sub-int/2addr v1, v7

    invoke-static {v1, v5}, Ljava/lang/Math;->min(II)I

    move-result v5

    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v8

    const-wide/16 v10, 0x64

    add-long v12, v8, v10

    invoke-virtual/range {p0 .. p0}, Lit/sephiroth/android/library/widget/a;->getAdapter()Landroid/widget/Adapter;

    move-result-object v8

    if-nez v8, :cond_2

    return v2

    :cond_2
    move v9, v5

    move v10, v9

    :goto_0
    const/4 v11, 0x0

    :cond_3
    :goto_1
    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v14

    cmp-long v16, v14, v12

    if-gtz v16, :cond_b

    invoke-interface {v8, v5}, Landroid/widget/Adapter;->getItemId(I)J

    move-result-wide v14

    cmp-long v16, v14, v3

    if-nez v16, :cond_4

    return v5

    :cond_4
    if-ne v9, v1, :cond_5

    const/4 v14, 0x1

    goto :goto_2

    :cond_5
    const/4 v14, 0x0

    :goto_2
    if-nez v10, :cond_6

    const/4 v15, 0x1

    goto :goto_3

    :cond_6
    const/4 v15, 0x0

    :goto_3
    if-eqz v14, :cond_7

    if-eqz v15, :cond_7

    return v2

    :cond_7
    if-nez v15, :cond_a

    if-eqz v11, :cond_8

    if-nez v14, :cond_8

    goto :goto_4

    :cond_8
    if-nez v14, :cond_9

    if-nez v11, :cond_3

    if-nez v15, :cond_3

    :cond_9
    add-int/lit8 v10, v10, -0x1

    move v5, v10

    const/4 v11, 0x1

    goto :goto_1

    :cond_a
    :goto_4
    add-int/lit8 v9, v9, 0x1

    move v5, v9

    goto :goto_0

    :cond_b
    return v2
.end method

.method public w()V
    .locals 5

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/a;->getChildCount()I

    move-result v0

    if-lez v0, :cond_4

    const/4 v0, 0x1

    iput-boolean v0, p0, Lit/sephiroth/android/library/widget/a;->ad:Z

    iget v1, p0, Lit/sephiroth/android/library/widget/a;->a:I

    int-to-long v1, v1

    iput-wide v1, p0, Lit/sephiroth/android/library/widget/a;->ac:J

    iget v1, p0, Lit/sephiroth/android/library/widget/a;->am:I

    const/4 v2, 0x0

    if-ltz v1, :cond_1

    iget v0, p0, Lit/sephiroth/android/library/widget/a;->am:I

    iget v1, p0, Lit/sephiroth/android/library/widget/a;->V:I

    sub-int/2addr v0, v1

    invoke-virtual {p0, v0}, Lit/sephiroth/android/library/widget/a;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    iget-wide v3, p0, Lit/sephiroth/android/library/widget/a;->al:J

    iput-wide v3, p0, Lit/sephiroth/android/library/widget/a;->ab:J

    iget v1, p0, Lit/sephiroth/android/library/widget/a;->ak:I

    iput v1, p0, Lit/sephiroth/android/library/widget/a;->aa:I

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Landroid/view/View;->getLeft()I

    move-result v0

    iput v0, p0, Lit/sephiroth/android/library/widget/a;->W:I

    :cond_0
    iput v2, p0, Lit/sephiroth/android/library/widget/a;->ae:I

    return-void

    :cond_1
    invoke-virtual {p0, v2}, Lit/sephiroth/android/library/widget/a;->getChildAt(I)Landroid/view/View;

    move-result-object v1

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/a;->getAdapter()Landroid/widget/Adapter;

    move-result-object v2

    iget v3, p0, Lit/sephiroth/android/library/widget/a;->V:I

    if-ltz v3, :cond_2

    iget v3, p0, Lit/sephiroth/android/library/widget/a;->V:I

    invoke-interface {v2}, Landroid/widget/Adapter;->getCount()I

    move-result v4

    if-ge v3, v4, :cond_2

    iget v3, p0, Lit/sephiroth/android/library/widget/a;->V:I

    invoke-interface {v2, v3}, Landroid/widget/Adapter;->getItemId(I)J

    move-result-wide v2

    goto :goto_0

    :cond_2
    const-wide/16 v2, -0x1

    :goto_0
    iput-wide v2, p0, Lit/sephiroth/android/library/widget/a;->ab:J

    iget v2, p0, Lit/sephiroth/android/library/widget/a;->V:I

    iput v2, p0, Lit/sephiroth/android/library/widget/a;->aa:I

    if-eqz v1, :cond_3

    invoke-virtual {v1}, Landroid/view/View;->getLeft()I

    move-result v1

    iput v1, p0, Lit/sephiroth/android/library/widget/a;->W:I

    :cond_3
    iput v0, p0, Lit/sephiroth/android/library/widget/a;->ae:I

    :cond_4
    return-void
.end method
