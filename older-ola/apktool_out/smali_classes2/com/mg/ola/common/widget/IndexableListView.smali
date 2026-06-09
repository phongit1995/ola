.class public Lcom/mg/ola/common/widget/IndexableListView;
.super Landroid/widget/ListView;


# instance fields
.field private a:Z

.field private b:Lcom/mg/ola/common/widget/c;

.field private c:Landroid/view/GestureDetector;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0

    invoke-direct {p0, p1}, Landroid/widget/ListView;-><init>(Landroid/content/Context;)V

    const/4 p1, 0x0

    iput-boolean p1, p0, Lcom/mg/ola/common/widget/IndexableListView;->a:Z

    const/4 p1, 0x0

    iput-object p1, p0, Lcom/mg/ola/common/widget/IndexableListView;->b:Lcom/mg/ola/common/widget/c;

    iput-object p1, p0, Lcom/mg/ola/common/widget/IndexableListView;->c:Landroid/view/GestureDetector;

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Landroid/widget/ListView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    const/4 p1, 0x0

    iput-boolean p1, p0, Lcom/mg/ola/common/widget/IndexableListView;->a:Z

    const/4 p1, 0x0

    iput-object p1, p0, Lcom/mg/ola/common/widget/IndexableListView;->b:Lcom/mg/ola/common/widget/c;

    iput-object p1, p0, Lcom/mg/ola/common/widget/IndexableListView;->c:Landroid/view/GestureDetector;

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Landroid/widget/ListView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    const/4 p1, 0x0

    iput-boolean p1, p0, Lcom/mg/ola/common/widget/IndexableListView;->a:Z

    const/4 p1, 0x0

    iput-object p1, p0, Lcom/mg/ola/common/widget/IndexableListView;->b:Lcom/mg/ola/common/widget/c;

    iput-object p1, p0, Lcom/mg/ola/common/widget/IndexableListView;->c:Landroid/view/GestureDetector;

    return-void
.end method

.method static synthetic a(Lcom/mg/ola/common/widget/IndexableListView;)Lcom/mg/ola/common/widget/c;
    .locals 0

    iget-object p0, p0, Lcom/mg/ola/common/widget/IndexableListView;->b:Lcom/mg/ola/common/widget/c;

    return-object p0
.end method


# virtual methods
.method public draw(Landroid/graphics/Canvas;)V
    .locals 1

    invoke-super {p0, p1}, Landroid/widget/ListView;->draw(Landroid/graphics/Canvas;)V

    iget-object v0, p0, Lcom/mg/ola/common/widget/IndexableListView;->b:Lcom/mg/ola/common/widget/c;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mg/ola/common/widget/IndexableListView;->b:Lcom/mg/ola/common/widget/c;

    invoke-virtual {v0, p1}, Lcom/mg/ola/common/widget/c;->a(Landroid/graphics/Canvas;)V

    :cond_0
    return-void
.end method

.method public isFastScrollEnabled()Z
    .locals 1

    iget-boolean v0, p0, Lcom/mg/ola/common/widget/IndexableListView;->a:Z

    return v0
.end method

.method public onInterceptTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 0

    const/4 p1, 0x1

    return p1
.end method

.method protected onSizeChanged(IIII)V
    .locals 1

    invoke-super {p0, p1, p2, p3, p4}, Landroid/widget/ListView;->onSizeChanged(IIII)V

    iget-object v0, p0, Lcom/mg/ola/common/widget/IndexableListView;->b:Lcom/mg/ola/common/widget/c;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mg/ola/common/widget/IndexableListView;->b:Lcom/mg/ola/common/widget/c;

    invoke-virtual {v0, p1, p2, p3, p4}, Lcom/mg/ola/common/widget/c;->a(IIII)V

    :cond_0
    return-void
.end method

.method public onTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 3

    iget-object v0, p0, Lcom/mg/ola/common/widget/IndexableListView;->b:Lcom/mg/ola/common/widget/c;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mg/ola/common/widget/IndexableListView;->b:Lcom/mg/ola/common/widget/c;

    invoke-virtual {v0, p1}, Lcom/mg/ola/common/widget/c;->a(Landroid/view/MotionEvent;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 p1, 0x1

    return p1

    :cond_0
    iget-object v0, p0, Lcom/mg/ola/common/widget/IndexableListView;->c:Landroid/view/GestureDetector;

    if-nez v0, :cond_1

    new-instance v0, Landroid/view/GestureDetector;

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/IndexableListView;->getContext()Landroid/content/Context;

    move-result-object v1

    new-instance v2, Lcom/mg/ola/common/widget/IndexableListView$1;

    invoke-direct {v2, p0}, Lcom/mg/ola/common/widget/IndexableListView$1;-><init>(Lcom/mg/ola/common/widget/IndexableListView;)V

    invoke-direct {v0, v1, v2}, Landroid/view/GestureDetector;-><init>(Landroid/content/Context;Landroid/view/GestureDetector$OnGestureListener;)V

    iput-object v0, p0, Lcom/mg/ola/common/widget/IndexableListView;->c:Landroid/view/GestureDetector;

    :cond_1
    iget-object v0, p0, Lcom/mg/ola/common/widget/IndexableListView;->c:Landroid/view/GestureDetector;

    invoke-virtual {v0, p1}, Landroid/view/GestureDetector;->onTouchEvent(Landroid/view/MotionEvent;)Z

    invoke-super {p0, p1}, Landroid/widget/ListView;->onTouchEvent(Landroid/view/MotionEvent;)Z

    move-result p1

    return p1
.end method

.method public bridge synthetic setAdapter(Landroid/widget/Adapter;)V
    .locals 0

    check-cast p1, Landroid/widget/ListAdapter;

    invoke-virtual {p0, p1}, Lcom/mg/ola/common/widget/IndexableListView;->setAdapter(Landroid/widget/ListAdapter;)V

    return-void
.end method

.method public setAdapter(Landroid/widget/ListAdapter;)V
    .locals 1

    invoke-super {p0, p1}, Landroid/widget/ListView;->setAdapter(Landroid/widget/ListAdapter;)V

    iget-object v0, p0, Lcom/mg/ola/common/widget/IndexableListView;->b:Lcom/mg/ola/common/widget/c;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mg/ola/common/widget/IndexableListView;->b:Lcom/mg/ola/common/widget/c;

    invoke-virtual {v0, p1}, Lcom/mg/ola/common/widget/c;->a(Landroid/widget/Adapter;)V

    :cond_0
    return-void
.end method

.method public setFastScrollEnabled(Z)V
    .locals 1

    iput-boolean p1, p0, Lcom/mg/ola/common/widget/IndexableListView;->a:Z

    iget-boolean p1, p0, Lcom/mg/ola/common/widget/IndexableListView;->a:Z

    if-eqz p1, :cond_0

    iget-object p1, p0, Lcom/mg/ola/common/widget/IndexableListView;->b:Lcom/mg/ola/common/widget/c;

    if-nez p1, :cond_1

    new-instance p1, Lcom/mg/ola/common/widget/c;

    invoke-virtual {p0}, Lcom/mg/ola/common/widget/IndexableListView;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-direct {p1, v0, p0}, Lcom/mg/ola/common/widget/c;-><init>(Landroid/content/Context;Landroid/widget/ListView;)V

    :goto_0
    iput-object p1, p0, Lcom/mg/ola/common/widget/IndexableListView;->b:Lcom/mg/ola/common/widget/c;

    return-void

    :cond_0
    iget-object p1, p0, Lcom/mg/ola/common/widget/IndexableListView;->b:Lcom/mg/ola/common/widget/c;

    if-eqz p1, :cond_1

    iget-object p1, p0, Lcom/mg/ola/common/widget/IndexableListView;->b:Lcom/mg/ola/common/widget/c;

    invoke-virtual {p1}, Lcom/mg/ola/common/widget/c;->b()V

    const/4 p1, 0x0

    goto :goto_0

    :cond_1
    return-void
.end method
