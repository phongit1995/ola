.class Landroid/support/transition/TransitionPort$AnimationInfo;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroid/support/transition/TransitionPort;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "AnimationInfo"
.end annotation


# instance fields
.field name:Ljava/lang/String;

.field values:Landroid/support/transition/TransitionValues;

.field view:Landroid/view/View;

.field windowId:Landroid/support/transition/WindowIdPort;


# direct methods
.method constructor <init>(Landroid/view/View;Ljava/lang/String;Landroid/support/transition/WindowIdPort;Landroid/support/transition/TransitionValues;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Landroid/support/transition/TransitionPort$AnimationInfo;->view:Landroid/view/View;

    iput-object p2, p0, Landroid/support/transition/TransitionPort$AnimationInfo;->name:Ljava/lang/String;

    iput-object p4, p0, Landroid/support/transition/TransitionPort$AnimationInfo;->values:Landroid/support/transition/TransitionValues;

    iput-object p3, p0, Landroid/support/transition/TransitionPort$AnimationInfo;->windowId:Landroid/support/transition/WindowIdPort;

    return-void
.end method
