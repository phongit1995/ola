.class public Lit/sephiroth/android/library/widget/EnhancedListView;
.super Landroid/widget/ListView;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lit/sephiroth/android/library/widget/EnhancedListView$a;,
        Lit/sephiroth/android/library/widget/EnhancedListView$e;,
        Lit/sephiroth/android/library/widget/EnhancedListView$d;,
        Lit/sephiroth/android/library/widget/EnhancedListView$f;,
        Lit/sephiroth/android/library/widget/EnhancedListView$b;,
        Lit/sephiroth/android/library/widget/EnhancedListView$c;,
        Lit/sephiroth/android/library/widget/EnhancedListView$SwipeDirection;,
        Lit/sephiroth/android/library/widget/EnhancedListView$UndoStyle;
    }
.end annotation


# instance fields
.field private A:F

.field private B:Landroid/widget/PopupWindow;

.field private C:I

.field private D:Landroid/os/Handler;

.field private E:Landroid/widget/Button;

.field private F:Landroid/view/View;

.field private a:F

.field private b:I

.field private c:I

.field private d:J

.field private final e:[Ljava/lang/Object;

.field private f:Z

.field private g:Lit/sephiroth/android/library/widget/EnhancedListView$b;

.field private h:Lit/sephiroth/android/library/widget/EnhancedListView$c;

.field private i:Lit/sephiroth/android/library/widget/EnhancedListView$UndoStyle;

.field private j:Z

.field private k:Lit/sephiroth/android/library/widget/EnhancedListView$SwipeDirection;

.field private l:J

.field private m:I

.field private n:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lit/sephiroth/android/library/widget/EnhancedListView$f;",
            ">;"
        }
    .end annotation
.end field

.field private o:Ljava/util/SortedSet;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/SortedSet<",
            "Lit/sephiroth/android/library/widget/EnhancedListView$d;",
            ">;"
        }
    .end annotation
.end field

.field private p:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Landroid/view/View;",
            ">;"
        }
    .end annotation
.end field

.field private q:I

.field private r:Z

.field private s:Z

.field private t:I

.field private u:Landroid/view/View;

.field private v:Landroid/view/View;

.field private w:Landroid/widget/TextView;

.field private x:Landroid/view/VelocityTracker;

.field private y:F

.field private z:I


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 3

    invoke-direct {p0, p1}, Landroid/widget/ListView;-><init>(Landroid/content/Context;)V

    const/4 v0, 0x0

    new-array v0, v0, [Ljava/lang/Object;

    iput-object v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->e:[Ljava/lang/Object;

    sget-object v0, Lit/sephiroth/android/library/widget/EnhancedListView$UndoStyle;->a:Lit/sephiroth/android/library/widget/EnhancedListView$UndoStyle;

    iput-object v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->i:Lit/sephiroth/android/library/widget/EnhancedListView$UndoStyle;

    const/4 v0, 0x1

    iput-boolean v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->j:Z

    sget-object v1, Lit/sephiroth/android/library/widget/EnhancedListView$SwipeDirection;->a:Lit/sephiroth/android/library/widget/EnhancedListView$SwipeDirection;

    iput-object v1, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->k:Lit/sephiroth/android/library/widget/EnhancedListView$SwipeDirection;

    const-wide/16 v1, 0x1388

    iput-wide v1, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->l:J

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    iput-object v1, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->n:Ljava/util/List;

    new-instance v1, Ljava/util/TreeSet;

    invoke-direct {v1}, Ljava/util/TreeSet;-><init>()V

    iput-object v1, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->o:Ljava/util/SortedSet;

    new-instance v1, Ljava/util/LinkedList;

    invoke-direct {v1}, Ljava/util/LinkedList;-><init>()V

    iput-object v1, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->p:Ljava/util/List;

    iput v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->t:I

    new-instance v0, Lit/sephiroth/android/library/widget/EnhancedListView$a;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, Lit/sephiroth/android/library/widget/EnhancedListView$a;-><init>(Lit/sephiroth/android/library/widget/EnhancedListView;Lit/sephiroth/android/library/widget/EnhancedListView$1;)V

    iput-object v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->D:Landroid/os/Handler;

    invoke-direct {p0, p1}, Lit/sephiroth/android/library/widget/EnhancedListView;->a(Landroid/content/Context;)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 2

    invoke-direct {p0, p1, p2}, Landroid/widget/ListView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    const/4 p2, 0x0

    new-array p2, p2, [Ljava/lang/Object;

    iput-object p2, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->e:[Ljava/lang/Object;

    sget-object p2, Lit/sephiroth/android/library/widget/EnhancedListView$UndoStyle;->a:Lit/sephiroth/android/library/widget/EnhancedListView$UndoStyle;

    iput-object p2, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->i:Lit/sephiroth/android/library/widget/EnhancedListView$UndoStyle;

    const/4 p2, 0x1

    iput-boolean p2, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->j:Z

    sget-object v0, Lit/sephiroth/android/library/widget/EnhancedListView$SwipeDirection;->a:Lit/sephiroth/android/library/widget/EnhancedListView$SwipeDirection;

    iput-object v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->k:Lit/sephiroth/android/library/widget/EnhancedListView$SwipeDirection;

    const-wide/16 v0, 0x1388

    iput-wide v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->l:J

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->n:Ljava/util/List;

    new-instance v0, Ljava/util/TreeSet;

    invoke-direct {v0}, Ljava/util/TreeSet;-><init>()V

    iput-object v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->o:Ljava/util/SortedSet;

    new-instance v0, Ljava/util/LinkedList;

    invoke-direct {v0}, Ljava/util/LinkedList;-><init>()V

    iput-object v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->p:Ljava/util/List;

    iput p2, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->t:I

    new-instance p2, Lit/sephiroth/android/library/widget/EnhancedListView$a;

    const/4 v0, 0x0

    invoke-direct {p2, p0, v0}, Lit/sephiroth/android/library/widget/EnhancedListView$a;-><init>(Lit/sephiroth/android/library/widget/EnhancedListView;Lit/sephiroth/android/library/widget/EnhancedListView$1;)V

    iput-object p2, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->D:Landroid/os/Handler;

    invoke-direct {p0, p1}, Lit/sephiroth/android/library/widget/EnhancedListView;->a(Landroid/content/Context;)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 2

    invoke-direct {p0, p1, p2, p3}, Landroid/widget/ListView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    const/4 p2, 0x0

    new-array p2, p2, [Ljava/lang/Object;

    iput-object p2, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->e:[Ljava/lang/Object;

    sget-object p2, Lit/sephiroth/android/library/widget/EnhancedListView$UndoStyle;->a:Lit/sephiroth/android/library/widget/EnhancedListView$UndoStyle;

    iput-object p2, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->i:Lit/sephiroth/android/library/widget/EnhancedListView$UndoStyle;

    const/4 p2, 0x1

    iput-boolean p2, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->j:Z

    sget-object p3, Lit/sephiroth/android/library/widget/EnhancedListView$SwipeDirection;->a:Lit/sephiroth/android/library/widget/EnhancedListView$SwipeDirection;

    iput-object p3, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->k:Lit/sephiroth/android/library/widget/EnhancedListView$SwipeDirection;

    const-wide/16 v0, 0x1388

    iput-wide v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->l:J

    new-instance p3, Ljava/util/ArrayList;

    invoke-direct {p3}, Ljava/util/ArrayList;-><init>()V

    iput-object p3, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->n:Ljava/util/List;

    new-instance p3, Ljava/util/TreeSet;

    invoke-direct {p3}, Ljava/util/TreeSet;-><init>()V

    iput-object p3, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->o:Ljava/util/SortedSet;

    new-instance p3, Ljava/util/LinkedList;

    invoke-direct {p3}, Ljava/util/LinkedList;-><init>()V

    iput-object p3, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->p:Ljava/util/List;

    iput p2, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->t:I

    new-instance p2, Lit/sephiroth/android/library/widget/EnhancedListView$a;

    const/4 p3, 0x0

    invoke-direct {p2, p0, p3}, Lit/sephiroth/android/library/widget/EnhancedListView$a;-><init>(Lit/sephiroth/android/library/widget/EnhancedListView;Lit/sephiroth/android/library/widget/EnhancedListView$1;)V

    iput-object p2, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->D:Landroid/os/Handler;

    invoke-direct {p0, p1}, Lit/sephiroth/android/library/widget/EnhancedListView;->a(Landroid/content/Context;)V

    return-void
.end method

.method static synthetic a(Lit/sephiroth/android/library/widget/EnhancedListView;)Ljava/util/List;
    .locals 0

    iget-object p0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->n:Ljava/util/List;

    return-object p0
.end method

.method private a(Landroid/content/Context;)V
    .locals 3

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/EnhancedListView;->isInEditMode()Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    invoke-static {p1}, Landroid/view/ViewConfiguration;->get(Landroid/content/Context;)Landroid/view/ViewConfiguration;

    move-result-object v0

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/EnhancedListView;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const v2, 0x7f07012f

    invoke-virtual {v1, v2}, Landroid/content/res/Resources;->getDimension(I)F

    move-result v1

    iput v1, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->a:F

    invoke-virtual {v0}, Landroid/view/ViewConfiguration;->getScaledMinimumFlingVelocity()I

    move-result v1

    iput v1, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->b:I

    invoke-virtual {v0}, Landroid/view/ViewConfiguration;->getScaledMaximumFlingVelocity()I

    move-result v0

    iput v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->c:I

    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p1

    const/high16 v0, 0x10e0000

    invoke-virtual {p1, v0}, Landroid/content/res/Resources;->getInteger(I)I

    move-result p1

    int-to-long v0, p1

    iput-wide v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->d:J

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/EnhancedListView;->getContext()Landroid/content/Context;

    move-result-object p1

    const-string v0, "layout_inflater"

    invoke-virtual {p1, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/view/LayoutInflater;

    const v0, 0x7f0b009f

    const/4 v1, 0x0

    invoke-virtual {p1, v0, v1}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->F:Landroid/view/View;

    iget-object p1, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->F:Landroid/view/View;

    const v0, 0x7f0905ba

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/Button;

    iput-object p1, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->E:Landroid/widget/Button;

    iget-object p1, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->E:Landroid/widget/Button;

    new-instance v0, Lit/sephiroth/android/library/widget/EnhancedListView$e;

    invoke-direct {v0, p0, v1}, Lit/sephiroth/android/library/widget/EnhancedListView$e;-><init>(Lit/sephiroth/android/library/widget/EnhancedListView;Lit/sephiroth/android/library/widget/EnhancedListView$1;)V

    invoke-virtual {p1, v0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->E:Landroid/widget/Button;

    new-instance v0, Lit/sephiroth/android/library/widget/EnhancedListView$1;

    invoke-direct {v0, p0}, Lit/sephiroth/android/library/widget/EnhancedListView$1;-><init>(Lit/sephiroth/android/library/widget/EnhancedListView;)V

    invoke-virtual {p1, v0}, Landroid/widget/Button;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V

    iget-object p1, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->F:Landroid/view/View;

    const v0, 0x7f0904bc

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->w:Landroid/widget/TextView;

    new-instance p1, Landroid/widget/PopupWindow;

    iget-object v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->F:Landroid/view/View;

    const/4 v1, 0x0

    const/4 v2, -0x2

    invoke-direct {p1, v0, v2, v2, v1}, Landroid/widget/PopupWindow;-><init>(Landroid/view/View;IIZ)V

    iput-object p1, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->B:Landroid/widget/PopupWindow;

    iget-object p1, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->B:Landroid/widget/PopupWindow;

    const v0, 0x7f10025d

    invoke-virtual {p1, v0}, Landroid/widget/PopupWindow;->setAnimationStyle(I)V

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/EnhancedListView;->getResources()Landroid/content/res/Resources;

    move-result-object p1

    invoke-virtual {p1}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object p1

    iget p1, p1, Landroid/util/DisplayMetrics;->density:F

    iput p1, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->A:F

    invoke-direct {p0}, Lit/sephiroth/android/library/widget/EnhancedListView;->e()Landroid/widget/AbsListView$OnScrollListener;

    move-result-object p1

    invoke-virtual {p0, p1}, Lit/sephiroth/android/library/widget/EnhancedListView;->setOnScrollListener(Landroid/widget/AbsListView$OnScrollListener;)V

    return-void
.end method

.method private a(Landroid/view/View;Landroid/view/View;I)V
    .locals 5

    invoke-virtual {p2}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    iget v1, v0, Landroid/view/ViewGroup$LayoutParams;->height:I

    invoke-virtual {p2}, Landroid/view/View;->getHeight()I

    move-result v2

    const/4 v3, 0x2

    new-array v3, v3, [I

    const/4 v4, 0x0

    aput v2, v3, v4

    const/4 v2, 0x1

    aput v2, v3, v2

    invoke-static {v3}, Lcom/mg/ola/a/a/b/n;->b([I)Lcom/mg/ola/a/a/b/n;

    move-result-object v2

    iget-wide v3, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->d:J

    invoke-virtual {v2, v3, v4}, Lcom/mg/ola/a/a/b/n;->c(J)Lcom/mg/ola/a/a/b/n;

    move-result-object v2

    new-instance v3, Lit/sephiroth/android/library/widget/EnhancedListView$3;

    invoke-direct {v3, p0, p1, v1}, Lit/sephiroth/android/library/widget/EnhancedListView$3;-><init>(Lit/sephiroth/android/library/widget/EnhancedListView;Landroid/view/View;I)V

    invoke-virtual {v2, v3}, Lcom/mg/ola/a/a/b/n;->a(Lcom/mg/ola/a/a/b/a$a;)V

    new-instance v1, Lit/sephiroth/android/library/widget/EnhancedListView$4;

    invoke-direct {v1, p0, v0, p2}, Lit/sephiroth/android/library/widget/EnhancedListView$4;-><init>(Lit/sephiroth/android/library/widget/EnhancedListView;Landroid/view/ViewGroup$LayoutParams;Landroid/view/View;)V

    invoke-virtual {v2, v1}, Lcom/mg/ola/a/a/b/n;->a(Lcom/mg/ola/a/a/b/n$b;)V

    iget-object v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->o:Ljava/util/SortedSet;

    new-instance v1, Lit/sephiroth/android/library/widget/EnhancedListView$d;

    invoke-direct {v1, p0, p3, p1, p2}, Lit/sephiroth/android/library/widget/EnhancedListView$d;-><init>(Lit/sephiroth/android/library/widget/EnhancedListView;ILandroid/view/View;Landroid/view/View;)V

    invoke-interface {v0, v1}, Ljava/util/SortedSet;->add(Ljava/lang/Object;)Z

    invoke-virtual {v2}, Lcom/mg/ola/a/a/b/n;->a()V

    return-void
.end method

.method private a(Landroid/view/View;Landroid/view/View;IZ)V
    .locals 2

    iget-object v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->e:[Ljava/lang/Object;

    monitor-enter v0

    :try_start_0
    iget-object v1, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->p:Ljava/util/List;

    invoke-interface {v1, p1}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    monitor-exit v0

    return-void

    :cond_0
    iget v1, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->q:I

    add-int/lit8 v1, v1, 0x1

    iput v1, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->q:I

    iget-object v1, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->p:Ljava/util/List;

    invoke-interface {v1, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    invoke-static {p1}, Lcom/mg/ola/a/a/c/c;->a(Landroid/view/View;)Lcom/mg/ola/a/a/c/c;

    move-result-object v0

    if-eqz p4, :cond_1

    iget p4, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->t:I

    :goto_0
    int-to-float p4, p4

    goto :goto_1

    :cond_1
    iget p4, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->t:I

    neg-int p4, p4

    goto :goto_0

    :goto_1
    invoke-virtual {v0, p4}, Lcom/mg/ola/a/a/c/c;->a(F)Lcom/mg/ola/a/a/c/c;

    move-result-object p4

    const/4 v0, 0x0

    invoke-virtual {p4, v0}, Lcom/mg/ola/a/a/c/c;->b(F)Lcom/mg/ola/a/a/c/c;

    move-result-object p4

    iget-wide v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->d:J

    invoke-virtual {p4, v0, v1}, Lcom/mg/ola/a/a/c/c;->a(J)Lcom/mg/ola/a/a/c/c;

    move-result-object p4

    new-instance v0, Lit/sephiroth/android/library/widget/EnhancedListView$2;

    invoke-direct {v0, p0, p1, p2, p3}, Lit/sephiroth/android/library/widget/EnhancedListView$2;-><init>(Lit/sephiroth/android/library/widget/EnhancedListView;Landroid/view/View;Landroid/view/View;I)V

    invoke-virtual {p4, v0}, Lcom/mg/ola/a/a/c/c;->a(Lcom/mg/ola/a/a/b/a$a;)Lcom/mg/ola/a/a/c/c;

    return-void

    :catchall_0
    move-exception p1

    :try_start_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p1
.end method

.method static synthetic a(Lit/sephiroth/android/library/widget/EnhancedListView;Landroid/view/View;Landroid/view/View;I)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Lit/sephiroth/android/library/widget/EnhancedListView;->a(Landroid/view/View;Landroid/view/View;I)V

    return-void
.end method

.method private a(F)Z
    .locals 5
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "NewApi"
        }
    .end annotation

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/4 v1, 0x1

    const/16 v2, 0x11

    if-lt v0, v2, :cond_0

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/EnhancedListView;->getLayoutDirection()I

    move-result v0

    if-ne v0, v1, :cond_0

    const/4 v0, -0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x1

    :goto_0
    sget-object v2, Lit/sephiroth/android/library/widget/EnhancedListView$6;->b:[I

    iget-object v3, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->k:Lit/sephiroth/android/library/widget/EnhancedListView$SwipeDirection;

    invoke-virtual {v3}, Lit/sephiroth/android/library/widget/EnhancedListView$SwipeDirection;->ordinal()I

    move-result v3

    aget v2, v2, v3

    const/4 v3, 0x0

    const/4 v4, 0x0

    packed-switch v2, :pswitch_data_0

    return v1

    :pswitch_0
    int-to-float v0, v0

    mul-float v0, v0, p1

    cmpl-float p1, v0, v4

    if-lez p1, :cond_1

    return v1

    :cond_1
    const/4 v1, 0x0

    return v1

    :pswitch_1
    int-to-float v0, v0

    mul-float v0, v0, p1

    cmpg-float p1, v0, v4

    if-gez p1, :cond_2

    return v1

    :cond_2
    const/4 v1, 0x0

    return v1

    :pswitch_data_0
    .packed-switch 0x2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method static synthetic a(Lit/sephiroth/android/library/widget/EnhancedListView;Z)Z
    .locals 0

    iput-boolean p1, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->r:Z

    return p1
.end method

.method static synthetic b(Lit/sephiroth/android/library/widget/EnhancedListView;)Lit/sephiroth/android/library/widget/EnhancedListView$UndoStyle;
    .locals 0

    iget-object p0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->i:Lit/sephiroth/android/library/widget/EnhancedListView$UndoStyle;

    return-object p0
.end method

.method static synthetic c(Lit/sephiroth/android/library/widget/EnhancedListView;)Landroid/widget/PopupWindow;
    .locals 0

    iget-object p0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->B:Landroid/widget/PopupWindow;

    return-object p0
.end method

.method private c()V
    .locals 5

    iget-object v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->n:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    const v1, 0x7f0f04b4

    const/4 v2, 0x1

    if-le v0, v2, :cond_0

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/EnhancedListView;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    iget-object v4, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->n:Ljava/util/List;

    invoke-interface {v4}, Ljava/util/List;->size()I

    move-result v4

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v2, v3

    invoke-virtual {v0, v1, v2}, Landroid/content/res/Resources;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->n:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-lt v0, v2, :cond_1

    iget-object v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->n:Ljava/util/List;

    iget-object v3, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->n:Ljava/util/List;

    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v3

    sub-int/2addr v3, v2

    invoke-interface {v0, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lit/sephiroth/android/library/widget/EnhancedListView$f;

    invoke-virtual {v0}, Lit/sephiroth/android/library/widget/EnhancedListView$f;->c()Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_2

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/EnhancedListView;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_1
    const/4 v0, 0x0

    :cond_2
    :goto_0
    iget-object v1, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->w:Landroid/widget/TextView;

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void
.end method

.method private d()V
    .locals 2

    iget-object v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->n:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    const/4 v1, 0x1

    if-le v0, v1, :cond_0

    iget-object v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->i:Lit/sephiroth/android/library/widget/EnhancedListView$UndoStyle;

    sget-object v1, Lit/sephiroth/android/library/widget/EnhancedListView$UndoStyle;->c:Lit/sephiroth/android/library/widget/EnhancedListView$UndoStyle;

    if-ne v0, v1, :cond_0

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/EnhancedListView;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const v1, 0x7f0f066b

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/EnhancedListView;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const v1, 0x7f0f066a

    :goto_0
    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->E:Landroid/widget/Button;

    invoke-virtual {v1, v0}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    return-void
.end method

.method static synthetic d(Lit/sephiroth/android/library/widget/EnhancedListView;)V
    .locals 0

    invoke-direct {p0}, Lit/sephiroth/android/library/widget/EnhancedListView;->c()V

    return-void
.end method

.method private e()Landroid/widget/AbsListView$OnScrollListener;
    .locals 1

    new-instance v0, Lit/sephiroth/android/library/widget/EnhancedListView$5;

    invoke-direct {v0, p0}, Lit/sephiroth/android/library/widget/EnhancedListView$5;-><init>(Lit/sephiroth/android/library/widget/EnhancedListView;)V

    return-object v0
.end method

.method static synthetic e(Lit/sephiroth/android/library/widget/EnhancedListView;)V
    .locals 0

    invoke-direct {p0}, Lit/sephiroth/android/library/widget/EnhancedListView;->d()V

    return-void
.end method

.method static synthetic f(Lit/sephiroth/android/library/widget/EnhancedListView;)I
    .locals 2

    iget v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->C:I

    add-int/lit8 v1, v0, 0x1

    iput v1, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->C:I

    return v0
.end method

.method static synthetic g(Lit/sephiroth/android/library/widget/EnhancedListView;)I
    .locals 0

    iget p0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->C:I

    return p0
.end method

.method static synthetic h(Lit/sephiroth/android/library/widget/EnhancedListView;)[Ljava/lang/Object;
    .locals 0

    iget-object p0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->e:[Ljava/lang/Object;

    return-object p0
.end method

.method static synthetic i(Lit/sephiroth/android/library/widget/EnhancedListView;)I
    .locals 1

    iget v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->q:I

    add-int/lit8 v0, v0, -0x1

    iput v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->q:I

    return v0
.end method

.method static synthetic j(Lit/sephiroth/android/library/widget/EnhancedListView;)Ljava/util/List;
    .locals 0

    iget-object p0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->p:Ljava/util/List;

    return-object p0
.end method

.method static synthetic k(Lit/sephiroth/android/library/widget/EnhancedListView;)I
    .locals 0

    iget p0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->q:I

    return p0
.end method

.method static synthetic l(Lit/sephiroth/android/library/widget/EnhancedListView;)Ljava/util/SortedSet;
    .locals 0

    iget-object p0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->o:Ljava/util/SortedSet;

    return-object p0
.end method

.method static synthetic m(Lit/sephiroth/android/library/widget/EnhancedListView;)Lit/sephiroth/android/library/widget/EnhancedListView$b;
    .locals 0

    iget-object p0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->g:Lit/sephiroth/android/library/widget/EnhancedListView$b;

    return-object p0
.end method

.method static synthetic n(Lit/sephiroth/android/library/widget/EnhancedListView;)F
    .locals 0

    iget p0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->A:F

    return p0
.end method

.method static synthetic o(Lit/sephiroth/android/library/widget/EnhancedListView;)Z
    .locals 0

    iget-boolean p0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->j:Z

    return p0
.end method

.method static synthetic p(Lit/sephiroth/android/library/widget/EnhancedListView;)Landroid/os/Handler;
    .locals 0

    iget-object p0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->D:Landroid/os/Handler;

    return-object p0
.end method

.method static synthetic q(Lit/sephiroth/android/library/widget/EnhancedListView;)J
    .locals 2

    iget-wide v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->l:J

    return-wide v0
.end method


# virtual methods
.method public a()Lit/sephiroth/android/library/widget/EnhancedListView;
    .locals 2

    iget-object v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->g:Lit/sephiroth/android/library/widget/EnhancedListView$b;

    if-nez v0, :cond_0

    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "You must pass an OnDismissCallback to the list before enabling Swipe to Dismiss."

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_0
    const/4 v0, 0x1

    iput-boolean v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->f:Z

    return-object p0
.end method

.method public a(I)Lit/sephiroth/android/library/widget/EnhancedListView;
    .locals 0

    iput p1, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->m:I

    return-object p0
.end method

.method public a(J)Lit/sephiroth/android/library/widget/EnhancedListView;
    .locals 0

    iput-wide p1, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->l:J

    return-object p0
.end method

.method public a(Lit/sephiroth/android/library/widget/EnhancedListView$SwipeDirection;)Lit/sephiroth/android/library/widget/EnhancedListView;
    .locals 0

    iput-object p1, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->k:Lit/sephiroth/android/library/widget/EnhancedListView$SwipeDirection;

    return-object p0
.end method

.method public a(Lit/sephiroth/android/library/widget/EnhancedListView$UndoStyle;)Lit/sephiroth/android/library/widget/EnhancedListView;
    .locals 0

    iput-object p1, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->i:Lit/sephiroth/android/library/widget/EnhancedListView$UndoStyle;

    return-object p0
.end method

.method public a(Lit/sephiroth/android/library/widget/EnhancedListView$b;)Lit/sephiroth/android/library/widget/EnhancedListView;
    .locals 0

    iput-object p1, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->g:Lit/sephiroth/android/library/widget/EnhancedListView$b;

    return-object p0
.end method

.method public a(Z)Lit/sephiroth/android/library/widget/EnhancedListView;
    .locals 0

    iput-boolean p1, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->j:Z

    return-object p0
.end method

.method public b()V
    .locals 2

    iget-object v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->n:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lit/sephiroth/android/library/widget/EnhancedListView$f;

    invoke-virtual {v1}, Lit/sephiroth/android/library/widget/EnhancedListView$f;->b()V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->n:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    iget-object v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->B:Landroid/widget/PopupWindow;

    invoke-virtual {v0}, Landroid/widget/PopupWindow;->isShowing()Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->B:Landroid/widget/PopupWindow;

    invoke-virtual {v0}, Landroid/widget/PopupWindow;->dismiss()V

    :cond_1
    return-void
.end method

.method public onTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 11

    :try_start_0
    iget-boolean v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->f:Z

    if-nez v0, :cond_0

    invoke-super {p0, p1}, Landroid/widget/ListView;->onTouchEvent(Landroid/view/MotionEvent;)Z

    move-result v0

    return v0

    :cond_0
    iget-object v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->B:Landroid/widget/PopupWindow;

    invoke-virtual {v0}, Landroid/widget/PopupWindow;->isShowing()Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->D:Landroid/os/Handler;

    iget-object v1, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->D:Landroid/os/Handler;

    iget v2, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->C:I

    invoke-virtual {v1, v2}, Landroid/os/Handler;->obtainMessage(I)Landroid/os/Message;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/os/Handler;->sendMessage(Landroid/os/Message;)Z

    :cond_1
    iget v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->t:I

    const/4 v1, 0x2

    if-ge v0, v1, :cond_2

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/EnhancedListView;->getWidth()I

    move-result v0

    iput v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->t:I

    :cond_2
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getActionMasked()I

    move-result v0

    const/high16 v2, 0x3f800000    # 1.0f

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x1

    packed-switch v0, :pswitch_data_0

    goto/16 :goto_8

    :pswitch_0
    iget-object v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->x:Landroid/view/VelocityTracker;

    if-eqz v0, :cond_14

    iget-boolean v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->r:Z

    if-eqz v0, :cond_3

    goto/16 :goto_8

    :cond_3
    iget-object v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->x:Landroid/view/VelocityTracker;

    invoke-virtual {v0, p1}, Landroid/view/VelocityTracker;->addMovement(Landroid/view/MotionEvent;)V

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawX()F

    move-result v0

    iget v1, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->y:F

    sub-float/2addr v0, v1

    invoke-direct {p0, v0}, Lit/sephiroth/android/library/widget/EnhancedListView;->a(F)Z

    move-result v1

    if-eqz v1, :cond_5

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/EnhancedListView;->getParent()Landroid/view/ViewParent;

    move-result-object v1

    if-eqz v1, :cond_4

    invoke-interface {v1, v6}, Landroid/view/ViewParent;->requestDisallowInterceptTouchEvent(Z)V

    :cond_4
    invoke-static {v0}, Ljava/lang/Math;->abs(F)F

    move-result v1

    iget v3, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->a:F

    cmpl-float v1, v1, v3

    if-lez v1, :cond_6

    iput-boolean v6, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->s:Z

    invoke-virtual {p0, v6}, Lit/sephiroth/android/library/widget/EnhancedListView;->requestDisallowInterceptTouchEvent(Z)V

    invoke-static {p1}, Landroid/view/MotionEvent;->obtain(Landroid/view/MotionEvent;)Landroid/view/MotionEvent;

    move-result-object v1

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getActionIndex()I

    move-result v3

    shl-int/lit8 v3, v3, 0x8

    or-int/lit8 v3, v3, 0x3

    invoke-virtual {v1, v3}, Landroid/view/MotionEvent;->setAction(I)V

    invoke-super {p0, v1}, Landroid/widget/ListView;->onTouchEvent(Landroid/view/MotionEvent;)Z

    goto :goto_0

    :cond_5
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawX()F

    move-result v0

    iput v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->y:F

    const/4 v0, 0x0

    :cond_6
    :goto_0
    iget-boolean v1, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->s:Z

    if-eqz v1, :cond_14

    iget-object v1, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->u:Landroid/view/View;

    invoke-static {v1, v0}, Lcom/mg/ola/a/a/c/b;->e(Landroid/view/View;F)V

    iget-object v1, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->u:Landroid/view/View;

    const/high16 v3, 0x40000000    # 2.0f

    invoke-static {v0}, Ljava/lang/Math;->abs(F)F

    move-result v0

    mul-float v0, v0, v3

    iget v3, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->t:I

    int-to-float v3, v3

    div-float/2addr v0, v3

    sub-float v0, v2, v0

    invoke-static {v2, v0}, Ljava/lang/Math;->min(FF)F

    move-result v0

    invoke-static {v5, v0}, Ljava/lang/Math;->max(FF)F

    move-result v0

    invoke-static {v1, v0}, Lcom/mg/ola/a/a/c/b;->a(Landroid/view/View;F)V

    return v6

    :pswitch_1
    iget-object v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->x:Landroid/view/VelocityTracker;

    if-nez v0, :cond_7

    goto/16 :goto_8

    :cond_7
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawX()F

    move-result v0

    iget v7, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->y:F

    sub-float/2addr v0, v7

    iget-object v7, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->x:Landroid/view/VelocityTracker;

    invoke-virtual {v7, p1}, Landroid/view/VelocityTracker;->addMovement(Landroid/view/MotionEvent;)V

    iget-object v7, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->x:Landroid/view/VelocityTracker;

    const/16 v8, 0x3e8

    invoke-virtual {v7, v8}, Landroid/view/VelocityTracker;->computeCurrentVelocity(I)V

    iget-object v7, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->x:Landroid/view/VelocityTracker;

    invoke-virtual {v7}, Landroid/view/VelocityTracker;->getXVelocity()F

    move-result v7

    invoke-static {v7}, Ljava/lang/Math;->abs(F)F

    move-result v7

    iget-object v8, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->x:Landroid/view/VelocityTracker;

    invoke-virtual {v8}, Landroid/view/VelocityTracker;->getYVelocity()F

    move-result v8

    invoke-static {v8}, Ljava/lang/Math;->abs(F)F

    move-result v8

    invoke-static {v0}, Ljava/lang/Math;->abs(F)F

    move-result v9

    iget v10, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->t:I

    div-int/2addr v10, v1

    int-to-float v1, v10

    cmpl-float v1, v9, v1

    if-lez v1, :cond_9

    iget-boolean v1, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->s:Z

    if-eqz v1, :cond_9

    cmpl-float v0, v0, v5

    if-lez v0, :cond_8

    :goto_1
    const/4 v0, 0x1

    goto :goto_2

    :cond_8
    const/4 v0, 0x0

    goto :goto_2

    :cond_9
    iget v1, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->b:I

    int-to-float v1, v1

    cmpg-float v1, v1, v7

    if-gtz v1, :cond_a

    iget v1, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->c:I

    int-to-float v1, v1

    cmpg-float v1, v7, v1

    if-gtz v1, :cond_a

    cmpg-float v1, v8, v7

    if-gez v1, :cond_a

    iget-boolean v1, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->s:Z

    if-eqz v1, :cond_a

    iget-object v1, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->x:Landroid/view/VelocityTracker;

    invoke-virtual {v1}, Landroid/view/VelocityTracker;->getXVelocity()F

    move-result v1

    invoke-direct {p0, v1}, Lit/sephiroth/android/library/widget/EnhancedListView;->a(F)Z

    move-result v1

    if-eqz v1, :cond_a

    iget v1, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->t:I

    int-to-float v1, v1

    const v7, 0x3e4ccccd    # 0.2f

    mul-float v1, v1, v7

    cmpl-float v0, v0, v1

    if-ltz v0, :cond_a

    iget-object v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->x:Landroid/view/VelocityTracker;

    invoke-virtual {v0}, Landroid/view/VelocityTracker;->getXVelocity()F

    move-result v0

    cmpl-float v0, v0, v5

    if-lez v0, :cond_8

    goto :goto_1

    :cond_a
    const/4 v0, 0x0

    const/4 v6, 0x0

    :goto_2
    if-eqz v6, :cond_b

    iget-object v1, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->u:Landroid/view/View;

    iget-object v2, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->v:Landroid/view/View;

    iget v6, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->z:I

    invoke-direct {p0, v1, v2, v6, v0}, Lit/sephiroth/android/library/widget/EnhancedListView;->a(Landroid/view/View;Landroid/view/View;IZ)V

    goto :goto_3

    :cond_b
    iget-boolean v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->s:Z

    if-eqz v0, :cond_c

    iget-object v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->u:Landroid/view/View;

    invoke-static {v0}, Lcom/mg/ola/a/a/c/c;->a(Landroid/view/View;)Lcom/mg/ola/a/a/c/c;

    move-result-object v0

    invoke-virtual {v0, v5}, Lcom/mg/ola/a/a/c/c;->a(F)Lcom/mg/ola/a/a/c/c;

    move-result-object v0

    invoke-virtual {v0, v2}, Lcom/mg/ola/a/a/c/c;->b(F)Lcom/mg/ola/a/a/c/c;

    move-result-object v0

    iget-wide v1, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->d:J

    invoke-virtual {v0, v1, v2}, Lcom/mg/ola/a/a/c/c;->a(J)Lcom/mg/ola/a/a/c/c;

    move-result-object v0

    invoke-virtual {v0, v3}, Lcom/mg/ola/a/a/c/c;->a(Lcom/mg/ola/a/a/b/a$a;)Lcom/mg/ola/a/a/c/c;

    :cond_c
    :goto_3
    iput-object v3, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->x:Landroid/view/VelocityTracker;

    iput v5, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->y:F

    iput-object v3, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->u:Landroid/view/View;

    iput-object v3, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->v:Landroid/view/View;

    const/4 v0, -0x1

    iput v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->z:I

    iput-boolean v4, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->s:Z

    goto/16 :goto_8

    :pswitch_2
    iget-boolean v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->r:Z

    if-eqz v0, :cond_d

    invoke-super {p0, p1}, Landroid/widget/ListView;->onTouchEvent(Landroid/view/MotionEvent;)Z

    move-result v0

    return v0

    :cond_d
    new-instance v0, Landroid/graphics/Rect;

    invoke-direct {v0}, Landroid/graphics/Rect;-><init>()V

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/EnhancedListView;->getChildCount()I

    move-result v2

    new-array v1, v1, [I

    invoke-virtual {p0, v1}, Lit/sephiroth/android/library/widget/EnhancedListView;->getLocationOnScreen([I)V

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawX()F

    move-result v5

    float-to-int v5, v5

    aget v4, v1, v4

    sub-int/2addr v5, v4

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawY()F

    move-result v4

    float-to-int v4, v4

    aget v1, v1, v6

    sub-int/2addr v4, v1

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/EnhancedListView;->getHeaderViewsCount()I

    move-result v1

    :goto_4
    if-ge v1, v2, :cond_10

    invoke-virtual {p0, v1}, Lit/sephiroth/android/library/widget/EnhancedListView;->getChildAt(I)Landroid/view/View;

    move-result-object v7

    if-eqz v7, :cond_f

    invoke-virtual {v7, v0}, Landroid/view/View;->getHitRect(Landroid/graphics/Rect;)V

    invoke-virtual {v0, v5, v4}, Landroid/graphics/Rect;->contains(II)Z

    move-result v8

    if-eqz v8, :cond_f

    iget v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->m:I

    if-lez v0, :cond_e

    iget v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->m:I

    invoke-virtual {v7, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    if-eqz v0, :cond_e

    iput-object v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->u:Landroid/view/View;

    iput-object v7, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->v:Landroid/view/View;

    goto :goto_5

    :cond_e
    iput-object v7, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->v:Landroid/view/View;

    iput-object v7, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->u:Landroid/view/View;

    goto :goto_5

    :cond_f
    add-int/lit8 v1, v1, 0x1

    goto :goto_4

    :cond_10
    :goto_5
    iget-object v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->u:Landroid/view/View;

    if-eqz v0, :cond_13

    iget-object v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->u:Landroid/view/View;

    invoke-virtual {p0, v0}, Lit/sephiroth/android/library/widget/EnhancedListView;->getPositionForView(Landroid/view/View;)I

    move-result v0

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/EnhancedListView;->getHeaderViewsCount()I

    move-result v1

    sub-int/2addr v0, v1

    iget-object v1, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->h:Lit/sephiroth/android/library/widget/EnhancedListView$c;

    if-eqz v1, :cond_12

    iget-object v1, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->h:Lit/sephiroth/android/library/widget/EnhancedListView$c;

    invoke-interface {v1, p0, v0}, Lit/sephiroth/android/library/widget/EnhancedListView$c;->a(Lit/sephiroth/android/library/widget/EnhancedListView;I)Z

    move-result v1

    if-eqz v1, :cond_11

    goto :goto_6

    :cond_11
    iput-object v3, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->v:Landroid/view/View;

    iput-object v3, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->u:Landroid/view/View;

    goto :goto_7

    :cond_12
    :goto_6
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawX()F

    move-result v1

    iput v1, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->y:F

    iput v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->z:I

    invoke-static {}, Landroid/view/VelocityTracker;->obtain()Landroid/view/VelocityTracker;

    move-result-object v0

    iput-object v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->x:Landroid/view/VelocityTracker;

    iget-object v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView;->x:Landroid/view/VelocityTracker;

    invoke-virtual {v0, p1}, Landroid/view/VelocityTracker;->addMovement(Landroid/view/MotionEvent;)V

    :cond_13
    :goto_7
    invoke-super {p0, p1}, Landroid/widget/ListView;->onTouchEvent(Landroid/view/MotionEvent;)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return v6

    :catch_0
    :cond_14
    :goto_8
    invoke-super {p0, p1}, Landroid/widget/ListView;->onTouchEvent(Landroid/view/MotionEvent;)Z

    move-result p1

    return p1

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method protected onWindowVisibilityChanged(I)V
    .locals 0

    invoke-super {p0, p1}, Landroid/widget/ListView;->onWindowVisibilityChanged(I)V

    if-eqz p1, :cond_0

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/EnhancedListView;->b()V

    :cond_0
    return-void
.end method
