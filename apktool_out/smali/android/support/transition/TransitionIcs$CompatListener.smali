.class Landroid/support/transition/TransitionIcs$CompatListener;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/support/transition/TransitionPort$TransitionListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroid/support/transition/TransitionIcs;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "CompatListener"
.end annotation


# instance fields
.field private final mListeners:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Landroid/support/transition/TransitionInterfaceListener;",
            ">;"
        }
    .end annotation
.end field

.field final synthetic this$0:Landroid/support/transition/TransitionIcs;


# direct methods
.method constructor <init>(Landroid/support/transition/TransitionIcs;)V
    .locals 0

    iput-object p1, p0, Landroid/support/transition/TransitionIcs$CompatListener;->this$0:Landroid/support/transition/TransitionIcs;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    iput-object p1, p0, Landroid/support/transition/TransitionIcs$CompatListener;->mListeners:Ljava/util/ArrayList;

    return-void
.end method


# virtual methods
.method public addListener(Landroid/support/transition/TransitionInterfaceListener;)V
    .locals 1

    iget-object v0, p0, Landroid/support/transition/TransitionIcs$CompatListener;->mListeners:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    return-void
.end method

.method public isEmpty()Z
    .locals 1

    iget-object v0, p0, Landroid/support/transition/TransitionIcs$CompatListener;->mListeners:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    return v0
.end method

.method public onTransitionCancel(Landroid/support/transition/TransitionPort;)V
    .locals 2

    iget-object p1, p0, Landroid/support/transition/TransitionIcs$CompatListener;->mListeners:Ljava/util/ArrayList;

    invoke-virtual {p1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/support/transition/TransitionInterfaceListener;

    iget-object v1, p0, Landroid/support/transition/TransitionIcs$CompatListener;->this$0:Landroid/support/transition/TransitionIcs;

    iget-object v1, v1, Landroid/support/transition/TransitionIcs;->mExternalTransition:Landroid/support/transition/TransitionInterface;

    invoke-interface {v0, v1}, Landroid/support/transition/TransitionInterfaceListener;->onTransitionCancel(Landroid/support/transition/TransitionInterface;)V

    goto :goto_0

    :cond_0
    return-void
.end method

.method public onTransitionEnd(Landroid/support/transition/TransitionPort;)V
    .locals 2

    iget-object p1, p0, Landroid/support/transition/TransitionIcs$CompatListener;->mListeners:Ljava/util/ArrayList;

    invoke-virtual {p1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/support/transition/TransitionInterfaceListener;

    iget-object v1, p0, Landroid/support/transition/TransitionIcs$CompatListener;->this$0:Landroid/support/transition/TransitionIcs;

    iget-object v1, v1, Landroid/support/transition/TransitionIcs;->mExternalTransition:Landroid/support/transition/TransitionInterface;

    invoke-interface {v0, v1}, Landroid/support/transition/TransitionInterfaceListener;->onTransitionEnd(Landroid/support/transition/TransitionInterface;)V

    goto :goto_0

    :cond_0
    return-void
.end method

.method public onTransitionPause(Landroid/support/transition/TransitionPort;)V
    .locals 2

    iget-object p1, p0, Landroid/support/transition/TransitionIcs$CompatListener;->mListeners:Ljava/util/ArrayList;

    invoke-virtual {p1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/support/transition/TransitionInterfaceListener;

    iget-object v1, p0, Landroid/support/transition/TransitionIcs$CompatListener;->this$0:Landroid/support/transition/TransitionIcs;

    iget-object v1, v1, Landroid/support/transition/TransitionIcs;->mExternalTransition:Landroid/support/transition/TransitionInterface;

    invoke-interface {v0, v1}, Landroid/support/transition/TransitionInterfaceListener;->onTransitionPause(Landroid/support/transition/TransitionInterface;)V

    goto :goto_0

    :cond_0
    return-void
.end method

.method public onTransitionResume(Landroid/support/transition/TransitionPort;)V
    .locals 2

    iget-object p1, p0, Landroid/support/transition/TransitionIcs$CompatListener;->mListeners:Ljava/util/ArrayList;

    invoke-virtual {p1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/support/transition/TransitionInterfaceListener;

    iget-object v1, p0, Landroid/support/transition/TransitionIcs$CompatListener;->this$0:Landroid/support/transition/TransitionIcs;

    iget-object v1, v1, Landroid/support/transition/TransitionIcs;->mExternalTransition:Landroid/support/transition/TransitionInterface;

    invoke-interface {v0, v1}, Landroid/support/transition/TransitionInterfaceListener;->onTransitionResume(Landroid/support/transition/TransitionInterface;)V

    goto :goto_0

    :cond_0
    return-void
.end method

.method public onTransitionStart(Landroid/support/transition/TransitionPort;)V
    .locals 2

    iget-object p1, p0, Landroid/support/transition/TransitionIcs$CompatListener;->mListeners:Ljava/util/ArrayList;

    invoke-virtual {p1}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/support/transition/TransitionInterfaceListener;

    iget-object v1, p0, Landroid/support/transition/TransitionIcs$CompatListener;->this$0:Landroid/support/transition/TransitionIcs;

    iget-object v1, v1, Landroid/support/transition/TransitionIcs;->mExternalTransition:Landroid/support/transition/TransitionInterface;

    invoke-interface {v0, v1}, Landroid/support/transition/TransitionInterfaceListener;->onTransitionStart(Landroid/support/transition/TransitionInterface;)V

    goto :goto_0

    :cond_0
    return-void
.end method

.method public removeListener(Landroid/support/transition/TransitionInterfaceListener;)V
    .locals 1

    iget-object v0, p0, Landroid/support/transition/TransitionIcs$CompatListener;->mListeners:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->remove(Ljava/lang/Object;)Z

    return-void
.end method
