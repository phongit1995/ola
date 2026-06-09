.class Lcom/mg/ola/common/widget/IndexableListView$1;
.super Landroid/view/GestureDetector$SimpleOnGestureListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mg/ola/common/widget/IndexableListView;->onTouchEvent(Landroid/view/MotionEvent;)Z
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/mg/ola/common/widget/IndexableListView;


# direct methods
.method constructor <init>(Lcom/mg/ola/common/widget/IndexableListView;)V
    .locals 0

    iput-object p1, p0, Lcom/mg/ola/common/widget/IndexableListView$1;->a:Lcom/mg/ola/common/widget/IndexableListView;

    invoke-direct {p0}, Landroid/view/GestureDetector$SimpleOnGestureListener;-><init>()V

    return-void
.end method


# virtual methods
.method public onFling(Landroid/view/MotionEvent;Landroid/view/MotionEvent;FF)Z
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/widget/IndexableListView$1;->a:Lcom/mg/ola/common/widget/IndexableListView;

    invoke-static {v0}, Lcom/mg/ola/common/widget/IndexableListView;->a(Lcom/mg/ola/common/widget/IndexableListView;)Lcom/mg/ola/common/widget/c;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mg/ola/common/widget/IndexableListView$1;->a:Lcom/mg/ola/common/widget/IndexableListView;

    invoke-static {v0}, Lcom/mg/ola/common/widget/IndexableListView;->a(Lcom/mg/ola/common/widget/IndexableListView;)Lcom/mg/ola/common/widget/c;

    move-result-object v0

    invoke-virtual {v0}, Lcom/mg/ola/common/widget/c;->a()V

    :cond_0
    invoke-super {p0, p1, p2, p3, p4}, Landroid/view/GestureDetector$SimpleOnGestureListener;->onFling(Landroid/view/MotionEvent;Landroid/view/MotionEvent;FF)Z

    move-result p1

    return p1
.end method
